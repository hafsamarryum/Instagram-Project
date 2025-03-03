# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "toastr", to: "https://cdn.jsdelivr.net/npm/toastr@2.1.4/build/toastr.min.js"

pin "@hotwired/turbo-rails", to: "turbo.min.js"
