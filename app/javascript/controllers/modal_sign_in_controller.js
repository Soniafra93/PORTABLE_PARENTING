import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal-sign-in"
export default class extends Controller {
  connect() {
    console.log("Hello");
  }
}
