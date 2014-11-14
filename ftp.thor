# https://gist.github.com/stravid/4065477/download#
class Ftp < Thor
  desc "deploy", "deploys the site via LFTP to the location specified in the environment"
  def deploy
    load_ftp_configuration
   
    start_timestamp = Time.now.to_i
   
    if system("lftp -e 'mirror -R -v #{ENV['PUBLIC_DIRECTORY']} #{ENV['FTP_TARGET_DIRECTORY']}; bye' -u #{ENV['FTP_USER']},#{ENV['FTP_PASSWORD']} #{ENV['FTP_SERVER']}")
      puts "Deploy finished. (Duration: #{Time.now.to_i - start_timestamp} seconds)"
    else
      puts 'Deploy aborted, something went wrong.'
    end
  end
   
  private
  def load_ftp_configuration
    configuration_file = "ftp_configuration.yml"
   
    if File.exists? configuration_file
      configuration_hash = YAML.load_file configuration_file
      configuration_hash.each do |key, value|
          ENV[key.upcase] = value
      end
    else
      throw 'Missing `ftp_configuration.yml` to specify ftp configuration variables.'
    end
  end
end