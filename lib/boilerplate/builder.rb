module Boilerplate
  
  class Builder

    attr_accessor :type, :data, :project_title, :project_name, :project_module, :path, :folders, :files, :gems, :commands, :options

    def initialize(title, data, &block)
      @type = type
      @data = if data.is_a? File
        YAML.load(data)
      else
        data
      end
      @project_title = title.titlecase
      @project_name = project_title.gsub(' ', '').underscore
      @project_module = project_name.camelcase
      @path = []
      @block = block
      @files = []
      @folders = []
      @gems = []
      @commands = []
      @options = {}
    end

    def execute(opts={})
      @options = opts
      instance_eval(&@block)
      s = "\n"
      s << (is_dryrun? ? "Would have created" : "Created")
      s << " #{@folders.length} folders, #{files.length} files. "
      s << "Unpacked #{@gems.length} gems." if @gems.length > 0
      s << "Executed #{@commands.length} commands." if @commands.length > 0
      info s, true
    end

    def full_path
      path.join('/')
    end

    def folder(name, opts={}, &block)
      info "#{ " " * full_path.length }#{name}/"
      @folders << name
      @path << name
      unless is_dryrun?
        FileUtils.mkdir_p(full_path)
      end
      instance_eval(&block) if block_given?
      @path.pop
    end
    alias_method :dir, :folder
    alias_method :d,   :folder

    def file(name, opts={}, &block)
      # Body from opts or data
      body = opts[:body] || data[name] || ""
      # Filename from opts or name
      name = opts[:filename] || name
      # Run body through ERB...
      body = ERB.new(body).result(binding) unless body.empty? or opts[:erb] == false
      info "#{ " " * full_path.length }#{name}"
      @files << name
      unless is_dryrun?
        File.open(File.join(full_path, name), 'w') do |f|
          f.write body
        end
      end
    end
    alias_method :f, :file

    def cmd(line, opts={}, &block)
      results = `#{line}`
      yield results if block_given?
    end

    def gem_unpack(name, opts={}, &block)
      info "#{ " " * full_path.length }@#{name}"
      @gems << name
    end
    alias_method :gem, :gem_unpack
    alias_method :g,   :gem_unpack

    def set(key, value=nil, &block)
      value = if block_given?
        block.call
      else
        value
      end
      @data[key] = value
    end

    def info(msg, force=false)
      if is_verbose? or force
        puts msg
      end
    end

    def method_missing(key, *args)
      if @data.has_key?(key)
        @data[key]
      else
        super(key, *args)
      end
    end

  protected

    def is_dryrun?
      options.fetch(:dry, false)
    end

    def is_quiet?
      options.fetch(:quiet, false)
    end
    def is_verbose?
      !is_quiet?
    end

  end
  
end