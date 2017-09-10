class Recording < ApplicationRecord
#  belongs_to :caller

  attr_accessor :full_path, :files

  WORKING_FOLDER = "#{Dir.pwd}/tmp/working"

  def setup(folder,md5=nil)
    @full_path = "#{WORKING_FOLDER}#{folder}" 
    @files = []
    self.recording_folder = folder if self.recording_folder.nil? 
    self.call_date = Time.zone.now if self.call_date.nil? 
    get_files(folder)
    copy_folder(folder)
    self.checksum = md5.nil? ? Recording.calc_md5(@full_path, @files[0]) : md5
   end

  def get_files(path)
    Dir.foreach(path) do |item|
      next if item == '.' or item == '..' 
      if File.directory?(item)
        get_files(item)
      else
        @files << item
      end
    end
  end

  def copy_folder(sd_folder)
    FileUtils.mkdir_p(@full_path)
    FileUtils.cp_r("#{sd_folder}/.",@full_path)
  end 

  def self.calc_md5(path,file)
    chunk_size=1024
    md5 = Digest::MD5.new
    File.open("#{path}/#{file}") do |f|
      while chunk=f.read(chunk_size)
        md5.update chunk
      end  
    end
    md5.to_s
  end

end
