class CreateCommonTitles < ActiveRecord::Migration
  def change
    create_table :common_titles do |t|

      t.timestamps
    end
  end
end
