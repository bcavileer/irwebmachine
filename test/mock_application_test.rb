require_relative "setup"

class Resource < Webmachine::Resource
  def content_types_provided
    [["plain/text", :to_text]]
  end

  def content_types_accepted
    [["*/*", :accept]] 
  end

  def allowed_methods
    %w(GET POST DELETE PUT)
  end

  # POST
  def process_post
    response.body = "POST OK"   
  end

  # GET
  def to_text
    response.body = "GET OK"
  end

  # PUT
  def accept
    response.body = "PUT OK"
  end

  # DELETE
  def delete_resource
    response.body = "DELETE OK"
  end

  def finish_request
    response.headers['X-Request-Query'] = request.query
    response.headers['X-Request-Headers'] = request.headers
  end
end

class MockApplicationTest < Test::Unit::TestCase

  def setup
    @app = IRWebmachine::MockApplication.new(app) 
  end

  def test_get
    res = @app.get "/mock_application"
    assert_equal "GET OK", res.body
  end

  def test_post
    res = @app.post "/mock_application"
    assert_equal "POST OK", res.body
  end

  def test_delete
    res = @app.delete "/mock_application"
    assert_equal "DELETE OK", res.body
  end

  def test_put
    res = @app.put "/mock_application"
    assert_equal "PUT OK", res.body
  end

  def test_query
    %w(get post delete put).each do |verb|
      res = @app.send(verb, "/mock_application", {"foo" => "bar"}) 
      assert_equal({"foo" => "bar"}, res.headers['X-Request-Query'])
    end
  end

  def test_headers
    %w(get post delete put).each do |verb|
      res = @app.send(verb, "/mock_application", {}, {'Answer' => '42'})
      assert_equal({'Answer' => '42'}, res.headers['X-Request-Headers'])
    end
  end

private

  def app
    Webmachine::Application.new do |app|
      app.routes do
        add ["mock_application"], Resource
      end
    end
  end

end
