import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="card"
export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("Card controller connected");
  }

  navigate(event) {
    event.preventDefault();
    window.location.href = this.urlValue;
  }
}

