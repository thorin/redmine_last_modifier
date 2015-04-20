module LastModifier
  module Infectors
    module Issue
      module ClassMethods; end

      module InstanceMethods
        attr_accessor :attributes_before_change
      end

      def self.included(receiver)
        receiver.extend(ClassMethods)
        receiver.send(:include, InstanceMethods)
        receiver.class_eval do
          unloadable

          belongs_to :last_modifier, :class_name => 'User', :foreign_key => 'last_modifier_id'
        end
      end

    end
  end
end
