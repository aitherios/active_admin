module ActiveAdmin

  # Deals with reloading Active Admin on each request in 
  # development and once in production.
  class Reloader

    attr_reader :active_admin_app, 
                :rails_app,
                :file_update_checker

    # @param [ActiveAdmin::Application] app
    # @param [String] rails_version The version of Rails we're using. 
    #                 We use this to switch between the correcrt Rails reloader class.
    def initialize(rails_app, active_admin_app, rails_version)
      @rails_app = rails_app
      @active_admin_app = active_admin_app
      @rails_version = rails_version.to_s
      @file_update_checker = ActiveSupport::FileUpdateChecker.new(watched_paths) do
        reload!
      end
    end

    def reload!
      active_admin_app.unload!
      rails_app.reload_routes!
      file_update_checker.instance_variable_set(:@files, watched_paths)
    end

    # Attach to Rails and perform the reload on each request.
    def attach!
      # Bring the checker into local scope for the ruby block
      checker = file_update_checker

      reloader_class.to_prepare do
        checker.execute_if_updated
      end
      Rails.application.reloaders << checker
    end

    def watched_paths
      paths = active_admin_app.load_paths
      active_admin_app.load_paths.each{|path| paths += Dir[File.join(path, "**", "*.rb")]}
      paths
    end

    def reloader_class
      if @rails_version[0..2] =~ /3\.[^0]/
        ActionDispatch::Reloader
      else
        ActionDispatch::Callbacks
      end
    end

  end
end
