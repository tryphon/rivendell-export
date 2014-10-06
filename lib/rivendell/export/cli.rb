require 'trollop'

module Rivendell::Export
  class CLI

    attr_reader :arguments

    def initialize(arguments = [])
      @arguments = arguments
    end

    def snd_directory
      options[:snd_directory]
    end

    def group
      options[:group]
    end

    def format
      options[:format]
    end

    def path
      options[:filename]
    end

    def progress?
      options[:progress]
    end

    def verbose?
      options[:verbose]
    end

    def target
      options[:target]
    end
    
    def parser
      @parser ||= Trollop::Parser.new do
        opt :group, "Export only Carts from given Group", :type => String
        opt :format, "Audio format used for exported files", :type => String, :default => "wav"
        opt :snd_directory, "Rivendell /var/snd storage", :type => String, :default => "/var/snd"
        opt :target, "Directory where exported files will be created", :type => String, :required => true
        opt :filename, "Exported file name", :type => String, :default => "{cut.name}.wav"
        opt :progress, "Enable progress bar", :default => false
        opt :verbose, "Display export details", :default => false
      end
    end

    def options
      @options ||= Trollop::with_standard_exception_handling(parser) do
        raise Trollop::HelpNeeded if ARGV.empty? # show help screen
        parser.parse arguments
      end
    end
    alias_method :parse, :options
    
    def parsed_parser
      parse
      parser
    end

    def cuts
      @cuts ||= Cuts.new(group: group)
    end

    def run
      Sox.logger = Logger.new($stdout, Logger::DEBUG)
      
      Rivendell::DB.establish_connection
      Cut.snd_directory = snd_directory

      if verbose?
        source = "(from #{group}) " if group
        puts "Export #{cuts.count} cuts #{source}to #{target}"
      end

      if progress?
        progress = ProgressBar.new("Export", cuts.count)
      end
      
      cuts.each do |cut|
        cut.export target: target, format: format, path: path, verbose: verbose?
        progress.inc if progress
      end

      progress.finish if progress
    end
    
  end
end
