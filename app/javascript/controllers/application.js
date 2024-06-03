import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromConflict(context))

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
