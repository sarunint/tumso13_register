class AddNameNumberSoiRoadSubdistrictDistrictProvinceZipTelephoneFaxWebsiteToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :name, :string
    add_column :schools, :number, :string
    add_column :schools, :soi, :string
    add_column :schools, :road, :string
    add_column :schools, :subdistrict, :string
    add_column :schools, :district, :string
    add_column :schools, :province, :string
    add_column :schools, :zip, :string
    add_column :schools, :telephone, :string
    add_column :schools, :fax, :string
    add_column :schools, :website, :string
  end
end
