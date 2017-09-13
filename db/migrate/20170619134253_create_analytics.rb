class CreateAnalytics < ActiveRecord::Migration[5.1]
  def change
    create_table :analytics do |t|
      t.string :analytic_name
      t.text :analytic, :limit => 2147483647
      t.string :analytic_type
      t.string :analytic_format
      t.string :tlp, :default => "Amber"
      t.integer :user_id
      t.integer :version, :default => 1

      t.timestamps
    end

    add_index :analytics, [:analytic_name, :tlp, :updated_at]
  end
end
