namespace :db do
  desc "Syncs local database with production"
  task :sync do
    puts 'Syncing local database with production...'

    db_config = Rails.configuration.database_configuration
    database_name = db_config['development']['database']

    begin
      `heroku pg:backups:capture --app gustilogistics`
      `curl -o latest.dump \`heroku pg:backups:url --app gustilogistics\``
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{database_name} latest.dump`
    ensure
      `rm latest.dump`
    end
  end

  namespace :seed do
    desc "Import Unit Activity Reports"
    task :activity => :environment do
      uars = Dir.glob("#{Rails.root}/db/seeds/uar/**/*.xlsx")
      uars.each { |file| ActivityImport.new(file: file).save }
    end

    desc "Import Items Sold to Customers reports"
    task :purchase => :environment do
      itscs = Dir.glob("#{Rails.root}/db/seeds/items_sold/**/*.xlsx")
      itscs.each { |file| PurchaseImport.new(file: file).save }
    end

    desc "Import Products along with parameters from csv"
    task :product => :environment do
      path_to_products = Rails.root.join('db', 'seeds', 'products', 'products.csv')
      ProductImport.new(path_to_products).save
    end
  end
end
