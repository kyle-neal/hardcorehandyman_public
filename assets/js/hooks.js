// assets/js/hooks.js
// This file is where you can define your own custom Hooks.

import Calendar from "./date-picker"
import { AsYouType } from "../vendor/libphonenumber-js.min"

let Hooks = {Calendar: Calendar, AsYouType: AsYouType}

// Usage:
// bind it to the phone number field

// <.input
//   field={@form[:phone]}
//   type="tel"
//   placeholder="Phone"
//   autocomplete="off"
//   phx-debounce="blur"
//   phx-hook="PhoneNumber"
// />
Hooks.PhoneNumber = {
    mounted() {
      this.el.addEventListener("input", e => {
        this.el.value = new AsYouType("US").input(this.el.value);
      });
    },
  }

export default Hooks
