module AwsRotate
  class Backup < Base
    def run
      return if @options[:noop] || @options[:backup] == false
      return unless credentials_exist?
      backup_path = @credentials_path + ".bak-#{Time.now.strftime("%F-%T")}"
      FileUtils.cp(@credentials_path, backup_path)
      puts "Backed up credentials file at: #{backup_path}"
    end

    def credentials_exist?
      File.exist?(@credentials_path)
    end
  end
end
