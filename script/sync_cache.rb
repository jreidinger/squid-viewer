require "mirror_data"

Rails.logger.info "env #{Rails.env}"
CacheObject.destroy_all
MirrorData.read_cache_objects.each do |url, object|
  Rails.logger.info "url #{url}"
  next unless url =~ /\.(iso|rpm)$/
  CacheObject.create! :object => object, :url => url
end
