import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the Posts Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  static targets = [ 'submit' ]

  validate(event) {
    event.target.value ? this.submitTarget.disabled = false : this.submitTarget.disabled = true
  }

  // connect () {
  //   super.connect()
  //   // add your code here, if applicable
  // }
}
