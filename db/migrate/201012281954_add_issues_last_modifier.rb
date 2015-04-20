class AddIssuesLastModifier < ActiveRecord::Migration

  def self.up
    add_column :issues, :last_modifier_id, :integer

    Issue.all.each do |i|
      i.update_attributes({:last_modifier => (i.journals.blank? ? i.author : i.journals.first(:order=>"#{Journal.table_name}.created_on DESC").user)})
    end
  end

  def self.down
    remove_column :issues, :last_modifier
  end
end
