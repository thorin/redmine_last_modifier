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
        if issue.try(:current_journal).try(:attributes_before_change)
          issue.current_journal.attributes_before_change['last_modifier_id'] = user.id
        end
      end
    end
  end

end
