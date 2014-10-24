module MirrorData
  def self.read_cache_objects
    res = {}
    Dir["/var/cache/squid/??/**/*"].each do |f|
      next unless File.file?(f)

      url = read_cache_object(f)
      res[url] = f
    end

    res
  end

  def self.read_cache_object(path)
    url = nil
    File.open(path, "rb") do |f|
       f.seek(76)
       url_size = f.read(4)
       url_size = url_size.unpack('V').first
       url = f.read(url_size.to_i-1)
    end

    url
  end
end

if $0 == __FILE__
  MirrorData.read_cache_objects.each do |key, value|
    puts "#{value} caches #{key}"
  end
end
