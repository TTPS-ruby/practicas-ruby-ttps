class Smiley
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    new_response = response.map { |l| smileify(l) }
    headers['Content-Length'] = new_response.map(&:length).inject(0, &:+).to_s
    [status, headers, new_response]
  end

  def smileify(string)
    if string =~ /\b(Si|No)\b/
      "#{string} #{smiley_for(string)}"
    else
      string
    end
  end

  def smiley_for(string)
    case string
    when /Si/
      ':)'
    when /No/
      ':('
    end
  end
end
