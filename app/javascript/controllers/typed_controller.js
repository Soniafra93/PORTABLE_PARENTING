import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Travel lightly with your family.", "No more heavy luggages!",
      "Traveling made easy with Portable Parenting!"],
      typeSpeed: 100,
      showCursor: false,
    })
  }
}
