require 'redmine'

Redmine::Plugin.register :redmine_last_modifier do
  name 'Redmine Last Modifier'
  author 'Ricardo Santos'
  author_url 'https://github.com/thorin'
  description 'This plugin adds an extra field on a ticket with the last modifier'
  url 'https://github.com/thorin/redmine_lastmodifier'
  version '1.0.0'
  requires_redmine :version_or_higher => '2.0.0'
end

RedmineApp::Application.config.after_initialize do
  IssueQuery.add_available_column(
    QueryColumn.new(:last_modifier, :sortable => ["#{Issue.table_name}.last_modifier_id"], :groupable => true)
  )
  require_dependency 'last_modifier/infectors'
end

# hooks
require_dependency 'last_modifier/hooks'
