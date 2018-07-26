# GustiLogistics

Welcome to my *small business supply chain management web app*, custom built for my former company, [Gustiamo](https://www.gustiamo.com/). Although I'm continuing to add features and build out the front-end, my company has already begun to use it weekly. In short, this application helps them to manage their supply chain more efficiently and effectively via:
* Inventory and Customer Data Analytics / Visualizations
* Forecasting of Inventory Reorder Dates and Quantities

### Tech Stack

* Ruby on [Rails](http://rubyonrails.org/) application hosted on [Heroku](https://www.heroku.com/) and backed by [PostgreSQL](https://www.postgresql.org/) database.
  * Makes particular use of the following [RubyGems](https://rubygems.org/):
    * [Roo](https://github.com/roo-rb/roo) for parsing Excel spreadsheets.
    * [Bootstrap-Sass](https://github.com/twbs/bootstrap-sass/) for styling on the Front-End.
    * [jQuery](https://rubygems.org/gems/jquery-rails) for making [Ajax](https://en.wikipedia.org/wiki/Ajax_(programming)) requests.
    * [Chartkick](https://github.com/ankane/chartkick) for Data Visualizations.

### Application Features

The app requires authentication to access, so below is a recap of the main sections. 

Upon login the app displays:
* An indexing of all products', along with their current quantities and reorder by dates. 

Note: Not all suppliers and products have been uploaded yet.

![alt text](/sample_images/ProductsIndex.png "Products List")

Two **spreadsheet uploaders** can be seen at the bottom-left of the above page which:
* Are parsed as an argument from the [params hash](https://gorails.com/episodes/the-params-hash). 
* Enable the client to update the production database. 

![alt text](/sample_images/FileUploader.png "File Uploader")

The Calendar link in the top navbar leads to a **calendar page**, which takes inspiration from this [RailsCast](http://railscasts.com/episodes/213-calendars). This calendar:
* Displays which products should be reordered based on calculated reorder dates. 
* Provides a context of time, which helps envision the bigger picture of ordering, as orders are grouped from different vendors across Italy into one shipping vessel. 

![alt text](/sample_images/CalendarPage.png "Calendar Prototype")

Clicking on a product link on the calendar page takes you to a **product analysis page** which:
* Lists all vital stats, such as reorder dates and quantities.
* Displays Top B2B customers and total B2C(retail) sales in a table and pie chart. 
* Ranks customers in the last 12 months in 6-month halves, as requested by the client.
* Enables shipping status and reorder by date of product to be toggled with button. 

![alt text](/sample_images/ProductAnalysisPage.png "Product Analysis")

Finally, here's a schematic of how I calculate the **Reorder Dates and Quantities** for shipments:

![alt text](/sample_images/ReorderGustiLogistics.png "Reorder Model")

My **vision** for this application is that it will:
* Handle all matters related to supply chain management, such as reorder calculations, and customer, product, and supplier analyses / visualizations. 
* Generalize to more services, such as company communication and project management. 
* Become useful for other small "brick and mortar" businesses.
