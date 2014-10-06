module Rivendell::Export
  class Cut

    attr_accessor :backend_cut

    @@snd_directory = "/var/snd"
    cattr_accessor :snd_directory

    def initialize(backend_cut)
      @backend_cut = backend_cut
    end

    def name
      backend_cut.cut_name
    end

    def file
      File.join snd_directory, "#{name}.wav"
    end

    def target_file(target, path)
      File.join(target, resolved_path(path)).gsub(%r{/+},'/')
    end

    def cut
      self
    end

    delegate :cart, to: :backend_cut

    def resolved_path(path)
      path.dup.tap do |resolved_path|
        path.scan(/([{\[])(cut|cart).([a-z_]+)([}\]])/).each do |open, object, attribute, close|
          value = (send(object).send(attribute) rescue nil) or ""
          value = value.parameterize if value and open == "[" and close == "]"
          resolved_path.gsub! "#{open}#{object}.#{attribute}#{close}", value.to_s
        end
      end
    end

    def export(options = {})
      unless File.exists?(file)
        $stderr.puts "Can't find audio file (#{file}) for Cut #{name}"
        return
      end

      output_file = target_file(options[:target], options[:path])

      if File.exists?(output_file)
        $stderr.puts "Target file (#{output_file}) already exists for Cut #{name}" 
        return
      end
      
      puts "Export #{cut.name} to #{output_file}" if options[:verbose]
      
      FileUtils.mkdir_p File.dirname(output_file)

      Sox::Command.new do |sox|
        sox.input file
        sox.output output_file
      end.run!
    end

  end
end
