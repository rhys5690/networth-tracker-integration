import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "name" ]

  submit() {
    console.log('pressed submit');
  }

  get name() {
    return this.nameTarget.value
  }
}
