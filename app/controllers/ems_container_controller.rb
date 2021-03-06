class EmsContainerController < ApplicationController
  include Mixins::GenericListMixin
  include Mixins::GenericShowMixin
  include EmsCommon        # common methods for EmsInfra/Cloud/Container controllers
  include Mixins::EmsCommonAngular
  include Mixins::GenericSessionMixin
  include Mixins::DashboardViewMixin

  before_action :check_privileges
  before_action :get_session_data
  after_action :cleanup_action
  after_action :set_session_data

  def self.model
    ManageIQ::Providers::ContainerManager
  end

  def self.table_name
    @table_name ||= "ems_container"
  end

  def show_list
    process_show_list(:gtl_dbname => 'emscontainer')
  end

  def ems_path(*args)
    ems_container_path(*args)
  end

  def new_ems_path
    new_ems_container_path
  end

  def ems_container_form_fields
    ems_form_fields
  end

  private

  def textual_group_list
    [%i(properties endpoints status miq_custom_attributes), %i(relationships topology smart_management)]
  end
  helper_method :textual_group_list

  ############################
  # Special EmsCloud link builder for restful routes
  def show_link(ems, options = {})
    ems_path(ems.id, options)
  end

  def restful?
    true
  end
  public :restful?

  menu_section :cnt
end
