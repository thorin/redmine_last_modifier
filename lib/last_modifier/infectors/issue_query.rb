module LastModifier
  module Infectors
    module IssueQuery
      module ClassMethods; end

      module InstanceMethods

        def available_filters_with_last_modifier
          return @available_filters if @available_filters
          available_filters_without_last_modifier

          if @available_filters["author_id"]
            user_values = @available_filters["author_id"][:values]
            @available_filters["last_modifier_id"] = { :name => l(:field_last_modifier), :type => :list_optional, :order => 5.5, :values => user_values }
          end
          add_associations_custom_fields_filters :last_modifier
          @available_filters
        end

        def statement_with_last_modifier
          stmt = statement_without_last_modifier
          return stmt unless stmt

          user_id = User.current.logged? ? User.current.id: 0
          stmt.gsub %r{IN \(([^\'\)]*)'me'([^\)]*)\)}, "IN (\\1#{user_id}\\2)"
        end

      end

      def self.included(receiver)
        receiver.extend(ClassMethods)
        receiver.send(:include, InstanceMethods)
        receiver.class_eval do
          unloadable

          alias_method_chain :available_filters, :last_modifier
          alias_method_chain :statement, :last_modifier
        end
      end

    end
  end
end
