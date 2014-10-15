module GPXBlogger
  class Generator < Jekyll::Generator
    def generate(site)

        site.posts.each do |post|
            if post.data['gpx']
                puts "Generate map information for #{post.name}"
                
                post.data['altitude'] = "1000 hm"
                post.data['distance'] = "10 km"

                name = post.name[0, post.name.length - 3] #remove file extension '.md'

                imageDir = "#{site.source}/images/#{name}/map/"
                input = "#{site.source}/routes/#{name}.gpx"
                output = "#{site.source}/routes/#{name}.json"

                puts "image dir: #{imageDir}"
                puts "output: #{output}"
                puts "input: #{input}"

                post.data['geojson'] = "#{site.baseurl}routes/#{name}.json"
                post.data['geoimagedir'] = "#{site.baseurl}images/#{name}/map/"
                post.data['mapid'] = name.tr('-','')
                result = `python #{site.source}/_plugins/hike-blogger/generateGeoJsonFromGPX.py -i #{imageDir} -o #{output} #{input}`
                puts result

                site.static_files << Jekyll::StaticFile.new(site, site.source, '/routes/', "#{name}.json") #mark generated json-file as changed so it is copied to the site by jekyll
            end
        end

    end
  end
end