class AddIssuesLastModifierIndex < ActiveRecord::Migration

  def self.up
    add_index :issues, :last_modifier_id
  end

  def self.down
    remove_index :issues, :last_modifier_id
  end
end
