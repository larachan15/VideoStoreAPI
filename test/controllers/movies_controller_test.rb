require "test_helper"

describe MoviesController do
# it "must be a real test" do
#   flunk "Need real tests"
# end
MOVIE_FIELDS = %w(id title overview release_date inventory).sort

def parse_json(expected_type:, expected_status: :success)
  must_respond_with expected_status
  expect(response.header['Content-Type']).must_include 'json'

  body = JSON.parse(response.body)
  expect(body).must_be_kind_of expected_type
  return body
end

describe "index" do
  it "is a working route" do
    get movies_path

    body = parse_json(expected_type: Array)
    expect(body.length).must_equal Movie.count
  end

  it "returns and empty array when there are no movies" do
    Movie.destroy_all
    get movies_path
    body = parse_json(expected_type: Array)
    expect(body.length).must_equal 0
  end
end

describe "show" do
  it "returns a movie with exactly the required fields" do
    movie = Movie.first

    get movie_path(movie)
    # binding.pry
    body = parse_json(expected_type: Hash)
    expect(body.keys.sort).must_equal MOVIE_FIELDS
  end

  it "doesn't blow up when a movie DNE" do
    movie = Movie.first
    movie.destroy

    get movie_path(movie)

    body = parse_json(expected_type: Hash, expected_status: :not_found)
    expect(body).must_include "errors"
  end
end

describe "create" do
  before do
    @movie = {
      title: "The Great Escape",
      overview: "Movie about WWII",
      release_date: "1965-01-18",
      inventory: 10
    }
  end

  it "creates a new movie given valid data" do
    expect{
      post movies_path, params: { movie: @movie } }.must_change "Movie.count", 1
      must_respond_with :success

      body = parse_json(expected_type: Hash)
      expect(body).must_include "id"
    end
  end

  it "returns an error for invalid data" do
    @movie = {
      title: nil
    }

    expect{
      post movies_path, params: { movie: @movie } }.wont_change "Customer.count"
      # binding.pry
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
  end
end
