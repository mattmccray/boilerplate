require 'trollop'

module Boilerplate
  class << self

    def parse_args!(args=ARGV)
      name, opts = parse_args(args)
      if name.nil?
        puts 'Error. You must specify a project name.'
        exit(1)
      else
        [name, opts]
      end
    end

    def parse_args(args=ARGV)
      opts = Trollop::options do
        version "Boilerplate Generator 0.1 (c) 2008 M@ McCray"
        banner <<-EOS
        Usage:
               gen-* [options] <project_name>
        Where * is the boilerplate generator name and [options] are:
        EOS
        opt :quiet, "Reduce output verbosity", :default => false  # a flag --verbose, defaulting to false
        opt :dry,   "Dry run, do not actually create files or directories", :default => false
      end
      if args.length > 0
        [args[0], opts]
      else
        [nil, {}]
      end
    end
  end

end
