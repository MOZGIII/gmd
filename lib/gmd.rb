require "gmd/version"
require "tilt"
require "redcarpet"
require "erb"

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
      File.join(
        File.dirname(__FILE__),
        "gmd",
        "templates"
      )
    end

    def default_layout
      default_layouts_dir + "/default/layout.html.erb"
    end

    def layout_meta_tags
      <<-METATAGS
        <meta name="generator" content="gmd #{Gmd::VERSION}">
      METATAGS
    end

  end
end
