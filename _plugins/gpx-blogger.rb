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
                outputinfo = "#{site.source}/routes/#{name}-info.json"

                puts "image dir: #{imageDir}"
                puts "output: #{output}"
                puts "input: #{input}"
                puts "outputinfo: #{outputinfo}"

                post.data['geojson'] = "#{site.baseurl}/routes/#{name}.json"
                post.data['geoimagedir'] = "#{site.baseurl}/images/#{name}/map/"
                post.data['mapid'] = name.tr('-','')
                
                result = `python #{site.source}/_plugins/geoJsonGenerator/generateGeoJsonFromGPX.py -i #{imageDir} -o #{output} -s #{outputinfo} #{input}`
                puts result

                # load route infos from json and add it to post data
                routeinfo = JSON.parse( IO.read(outputinfo))
                post.data['uphill'] = routeinfo['uphill']
                post.data['length_3d'] = routeinfo['length_3d']
                post.data['length_2d'] = routeinfo['length_2d']
                post.data['downhill'] = routeinfo['downhill']
                post.data['imageCount'] = routeinfo['imageCount']
                post.data['routeinfo'] = routeinfo              

                site.static_files << Jekyll::StaticFile.new(site, site.source, '/routes/', "#{name}.json") #mark generated json-file as changed so it is copied to the site by jekyll
            end
        end
    end
  end
end