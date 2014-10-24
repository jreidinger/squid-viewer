class WelcomeController < ApplicationController
  def index
    @objects = CacheObject.all
  end

  def get
    url = params[:url]
    object = CacheObject.find_by_url(url)
    # TODO 404 if not found
    self.response_body = CacheStreamer.new(object.object, url)

    response.status = 200
    response.content_type = 'application/octet-stream'
    response.headers['Content-Disposition'] = "attachment; filename=\"#{url[(url.rindex("/")+1)..-1]}\""
  end

  private
  
  class CacheStreamer
    def initialize(file, url)
      @file = file
      @url = url
    end

    def each(&block)
      File.open(@file, "rb") do |f|
        f.seek(76)
        url_size = f.read(4)
        url_size = url_size.unpack('V').first
        url = f.read(url_size.to_i-1)
        raise "invalid file. Probably invalid cache" if url != @url
        while (f.readline != "\r\n") do;end
        loop do
          res = f.read(2048)
          break unless res
          block.call res
        end
      end
    end
  end
end
