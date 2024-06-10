import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["alert"];

  connect() {
    this.alertTargets.forEach((alert) => {
      setTimeout(() => {
        alert.classList.remove("show");
        alert.classList.add("fade");
        setTimeout(() => {
          alert.remove();
        }, 150); // Wait for fade out transition
      }, 5000); // 5000 milliseconds = 5 seconds
    });
  }
}
