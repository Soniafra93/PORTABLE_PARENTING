import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal-sign-in"
export default class extends Controller {
  static target = ["modal"];

  connect() {
    console.log("ModalSignInController connected");
  }

  fire() {
    console.log("Button clicked!"); // Debug statement
    this.modalTarget.classList.toggle("d-none");
    console.log("Toggled visibility!"); // Debug statement
  }
}
