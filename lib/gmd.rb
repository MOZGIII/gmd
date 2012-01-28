require "gmd/version"
require "tilt"
require "redcarpet"
require "erb"
require "gmd/helpers"
require "gmd/redcarpet_template_fix"

module Gmd
  class << self
  
    def get_layout_paths(file)
      [
        file,
        "#{file}.html.erb",
        "#{file}/layout.html.erb",
        "layout/#{file}",
        "layout/#{file}.html.erb",
        "layouts/#{file}",
        "layouts/#{file}.html.erb",
        "layouts/#{file}/layout.html.erb",
        "~/.gmd/#{file}",
        "~/.gmd/#{file}.html.erb",
        "~/.gmd/#{file}/layout.html.erb",
        File.join(default_layouts_dir, file),
        File.join(default_layouts_dir, file + ".html.erb"),
        File.join(default_layouts_dir, file + "/layout.html.erb"),
        "~/.tilt/#{file}",
        "/etc/tilt/#{file}"
      ]
    end

    def choose_file_from_paths(paths)
      paths.map { |p| File.expand_path(p) }.find { |p| File.file?(p) }
    end

    def default_layouts_dir
      File.dirname(__FILE__) + "/gmd/templates/layouts"
    end

    def default_layout
      default_layouts_dir + "/default/layout.html.erb"
    end

    def layout_meta_tags
      <<-METATAGS
        <meta name="generator" content="gmd #{Gmd::VERSION}">
      METATAGS
    end

    # Used to load files from templates/common/ dir
    def load_common(file)
      paths = [
        File.dirname(__FILE__) + "/gmd/templates/common/#{file}",
        File.dirname(__FILE__) + "/gmd/templates/common/#{file}.html.erb",
        File.dirname(__FILE__) + "/gmd/templates/common/#{file}.erb"
      ]
      filepath = choose_file_from_paths(paths)
      raise "Unable to find file: #{file}" unless filepath
      tilt_render(filepath)
    end

    # Escapes all markdown symbols found
    def escape_markdown(str)
      symbols = "\\`*_{}[]()#+-.!".split('')
      symbols.each { |s| str.gsub!(s, "\\" + s) }
      str
    end

    # Used to find and autoescape LaTeX in Markdown files
    # NOT SAFE YET! DO NO USE THIS!
    def fix_latex(str)
      inline_exp = /(([^\$]\${1}[^\$].*?[^\$]?\${1}[^\$]))/
      multline_exp = /((\\begin\{(\w+?)\}.+?\\end\{\3\})|(\$\$.+?\$\$))/m
      str.gsub!(multline_exp) { |s| escape_markdown($1) }
      str.gsub!(inline_exp) { |s| escape_markdown($1) }
      str
    end
    
    def var
      @var ||= {}
    end
    
    # Here we can specify the default options for different renderers
    def rendering_options(engine)
      case engine.name
      when /Redcarpet/
        {
          :no_intra_emphasis => true,
          :tables => true,
          :fenced_code_blocks => true,
          :autolink => true,
          :strikethrough => true,
          :lax_html_blocks => true,
          :space_after_headers => true,
          :superscript => false
        }
      end
    end
    
    def tilt_render(file, locals = {}, &block)
      Tilt.new(file, 1, rendering_options(Tilt[file]) || {})
        .render(Gmd::ExtraBinding, locals, &block)
        .force_encoding("UTF-8")
    end
    
  end
  
  class ExtraBinding
    class << self
    
      include Helpers
      
      def method_missing(method_sym, *arguments, &block)
        if Gmd.respond_to?(method_sym)
          Gmd.__send__(method_sym, *arguments, &block)
        else
          super
        end
      end
      
      def respond_to?(method_sym)
        super || Gmd.respond_to?(method_sym)
      end
    end
  end
  
end
