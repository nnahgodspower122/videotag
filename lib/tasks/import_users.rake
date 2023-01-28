require 'csv'
require 'rake'
require 'pry'

desc "Import users from csv file"
  namespace :import do
  task :import_users => [:environment] do

    file = "db/users.csv"
    
    CSV.foreach(file, :headers => true) do |row|
      value = {
        title: row[1],
        body: row[2]
      }
      Post.create(row.to_hash)
      puts "data imported succesfully"
    end

  end
end