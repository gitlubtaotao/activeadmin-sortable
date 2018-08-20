require 'activeadmin-sortable/version'
require 'activeadmin'
require 'rails/engine'

module ActiveAdmin
  module Sortable
    module ControllerActions
      def sortable
        member_action :sort, :method => :post do
          resource.insert_at params[:position].to_i
          head 200
        end
      end
    end

    module TableMethods
      HANDLE = '&#x2195;'.html_safe

      # position_name: 排序的字段名,默认是: position
      def sortable_handle_column position_name = 'position'
        column '', :class => "activeadmin-sortable" do |resource|
          position = nil
          position = resource.send(position_name) if position_name.present?
          sort_url, query_params = resource_path(resource).split '?', 2
          sort_url += "/sort"
          sort_url += "?" + query_params if query_params
          content_tag :span, HANDLE, :class => 'handle', 'data-sort-url' => sort_url,position: position
        end
      end
    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)
    
    class Engine < ::Rails::Engine
      # Including an Engine tells Rails that this gem contains assets
    end
  end
end


