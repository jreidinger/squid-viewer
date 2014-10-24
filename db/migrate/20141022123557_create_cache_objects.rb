class CreateCacheObjects < ActiveRecord::Migration
  def change
    create_table :cache_objects do |t|
      t.text :object
      t.text :url

      t.timestamps
    end
  end
end
