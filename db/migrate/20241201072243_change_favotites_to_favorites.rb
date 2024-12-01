class ChangeFavotitesToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_table :favotites, :favorites
  end
end
