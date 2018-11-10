namespace :recordings do
  desc "takes a folder from the zoom recorder makes mp3s from the tracks"
  task :convert_to_mp3, [:starting_folder,:target,:with_transcript] => :environment do |t,args|

    make_mp3s args.starting_folder, args.target,args.with_transcript
  end

  desc "takes a folder from the zoom recorder runs the transcription in debug mode - does not save it"
  task :test_transcript, [:starting_folder,:target] => :environment do |t,args|
    transcript = []
    files = Dir.glob("#{args.starting_folder}/*.WAV")
    unless files.nil? || files.count == 0 
      files.each do |f|
        transcript << `#{build_sphinx_command(f)}`
      end
    end
    puts transcript.join(" <<>> ")
  end

  def make_mp3s(starting_folder, target,with_transcript)
    ending_paths = Dir.glob("#{starting_folder}/**/*.hprj")
    i=0
    ending_paths.each do |ep|
      i += 1
      path = File.dirname(ep)
      md5 = Recording.calc_md5(nil,ep).to_s
      rec = Recording.find_or_create_by(checksum: md5)
      next if rec.copied_to_mp3
      rec.setup(path,md5)
      files = Dir.glob("#{path}/*.WAV")
      unless files.nil? || files.count == 0
        FileUtils.mkdir_p(target)
        combined_file = build_filename(files)
        rec.copied_to_mp3 = sh build_sox_command(files,target,combined_file)
        rec.file_path = "#{target}/#{combined_file}"
        if with_transcript
          transcript = []
          files.each do |f|
            sphinx = build_sphinx_command(f)
            transcript << `#{sphinx}`
          end
          rec.transcript = transcript.join(" || ")
        end
      end
      clear_tmp if rec.save
      puts "converted #{i} of #{ending_paths.count}"
    end
  end

  def build_filename(files)
    output_name = (files.count > 1 ? 'combined' : 'converted')
    return "#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}_#{output_name}"
  end

  def clear_tmp
    FileUtils.rm_rf 'tmp/'
  end

  def build_sox_command(files,path,filename)
    command = ["sox"]
    if files.count > 1
      command << "-M" 
      files.each do |f|
        command << f
      end
    else
      command << files[0]
    end
    command << "-c 2"
    command << "#{path}/#{filename}.mp3"
    command.join(' ')
  end

  def build_sphinx_command(file,debug=false)
    command = ["pocketsphinx_continuous"]
    command << "-samprate 48000 -nfft 2048" #set sample and frame size
    command << "-logfn /dev/null" unless debug
    command << "-infile #{file}"
    command.join(' ')     
  end
end
