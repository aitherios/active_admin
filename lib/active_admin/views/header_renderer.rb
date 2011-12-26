module ActiveAdmin
  module Views

    # Renderer for the header of the application. Includes the page
    # title, global navigation and utility navigation.
    class HeaderRenderer < ::ActiveAdmin::Renderer

      def to_html
        title + global_navigation + utility_navigation
      end

      protected

      # Renders the title/branding area for the site
      def title
        if active_admin_namespace.site_title_image.blank?
         title_text
        else
          title_image
        end
      end

      # Renders an image for the site's header/branding area
      def title_image
        img= image_tag(active_admin_namespace.site_title_image, :id => "site_title_image", :alt => active_admin_namespace.site_title)
        link_to(img, site_title_link, :class => 'brand')
      end

      def site_title_link
        active_admin_namespace.site_title_link.present? ? active_admin_namespace.site_title_link : '#'
      end

      # Renders a the site's header/branding area as a string
      def title_text
        if !active_admin_application.site_title_link || active_admin_application.site_title_link == ""
          link_to(active_admin_application.site_title, '#', :class => 'brand')
        else
          link_to(active_admin_application.site_title, active_admin_application.site_title_link, class: 'brand')
        end
      end

      # Renders the global navigation returned by
      # ActiveAdmin::ResourceController#current_menu
      #
      # It uses the ActiveAdmin.tabs_renderer option
      def global_navigation
        render view_factory.global_navigation, current_menu, :class => 'header-item'
      end

      def utility_navigation
        ul :class => "nav secondary-nav" do
          if current_active_admin_user?

            li class: 'dropdown', 'data-dropdown' => 'dropdown' do
              a class: 'dropdown-toggle' do
                display_name(current_active_admin_user)
              end

              if active_admin_application.logout_link_path
                ul class: 'dropdown-menu' do
                  # why logout_path doesn't work?
                  li link_to(I18n.t('active_admin.logout'), '/admin/logout', :method => logout_method)
                end
              end

            end
          end
        end
      end

      # Returns the logout path from the application settings
      def active_admin_logout_path
        if active_admin_namespace.logout_link_path.is_a?(Symbol)
          send(active_admin_namespace.logout_link_path)
        else
          active_admin_namespace.logout_link_path
        end
      end

      def logout_method
        active_admin_namespace.logout_link_method || :get
      end
    end

  end
end
