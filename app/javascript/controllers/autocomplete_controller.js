import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "input" ];

  connect() {
  }

  autosuggest() {
    console.log(this.inputValue);
  }

  get inputValue() {
    return this.inputTarget.value;
  }
}
