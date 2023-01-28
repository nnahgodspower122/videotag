require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'
require 'pagy/extras/metadata'

Pagy::DEFAULT[:items]  = 10
Pagy::DEFAULT[:page]   = 1 
Pagy::DEFAULT[:cycle]  = true 
Pagy::DEFAULT[:overflow] = :last_page
