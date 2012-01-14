require "gmd/version"
require "tilt"
require "redcarpet"
require "erb"

module Gmd
  class << self

    def get_layout_paths(file)
      [
        file,
        "layout/#{file}",
        "layouts/#{file}",
        "~/.gmd/#{file}",
        File.join(defalut_layouts_dir, file),
        "~/.tilt/#{file}",
        "/etc/tilt/#{file}"
      ]
    end

    def choose_file_from_paths(paths)
      paths.map { |p| File.expand_path(p) }.find { |p| File.exist?(p) }
    end

    def default_layouts_dir
      File.join(
        File.dirname(__FILE__),
        "gmd",
        "templates"
      )
    end

    def default_layout
      default_layouts_dir + "/default.html.erb"
    end

  end
end
