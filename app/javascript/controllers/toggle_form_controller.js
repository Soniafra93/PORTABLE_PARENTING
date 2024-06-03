import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["togglableElement"];

  connect() {
    console.log("ToggleFormController connected");
  }

  fire() {
    console.log("Button clicked!"); // Debug statement
    this.togglableElementTarget.classList.toggle("d-none");
    console.log("Toggled visibility!"); // Debug statement
  }
}
