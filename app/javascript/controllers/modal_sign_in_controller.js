import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal-sign-in"
export default class extends Controller {
  static targets = ["modal", "sign"];

  connect() {
    console.log("ModalSignInController connected");
  }

  fire() {
    console.log("Button clicked!"); // Debug statement

    this.modalTarget.classList.toggle("d-none");
    if (this.modalTarget.classList.contains("d-none")) {
      document.body.style.overflow = "auto";
    } else {
      document.body.style.overflow = "hidden";
    }
    console.log("Toggled visibility!"); // Debug statement
  }

  toggle() {
    console.log("Button clicked!"); // Debug statement

    this.signTarget.classList.toggle("d-none");
    if (this.signTarget.classList.contains("d-none")) {
      document.body.style.overflow = "auto";
    } else {
      document.body.style.overflow = "hidden";
    }
    console.log("Toggled visibility!"); // Debug statement
  }
}
