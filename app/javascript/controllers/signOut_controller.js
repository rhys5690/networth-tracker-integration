// src/controllers/hello_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "link" ];

  connect() {
    console.log(`Hello!`);
  }

  signOut() {
    Turbolinks.visit('/');
  }
}
