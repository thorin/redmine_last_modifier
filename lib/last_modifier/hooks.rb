module LastModifier
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_bulk_edit_before_save(context)
      update_last_modifier(context[:issue])
    end

    def controller_issues_new_before_save(context)
      update_last_modifier(context[:issue])
    end

    def controller_issues_edit_before_save(context)
      update_last_modifier(context[:issue])
    end

    def update_last_modifier(issue, user = User.current)
      if user != issue.last_modifier
        attrs = {:last_modifier => user}
        issue.assign_attributes attrs, :without_protection => true
        issue.attributes_before_change['last_modifier_id'] = user.id if issue.attributes_before_change
      end
    end
  end

end
