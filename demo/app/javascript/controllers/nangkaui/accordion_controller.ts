import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(e: Event) {
    const target = e.target as HTMLButtonElement;

    const contentID = target.getAttribute("aria-controls");
    const content:HTMLDivElement|null = this.element.querySelector(`div#${contentID}`);
    if (!content) {
      throw new Error(`Unable to find accordion content with ID ${contentID}`);
    }

    const state = target.dataset.state;
    if (state === "closed") {
      target.setAttribute("aria-expanded", "true");
      target.setAttribute("data-state", "open");
      content.removeAttribute("hidden");
      content.setAttribute("data-state", "open");
    } else {
      target.setAttribute("aria-expanded", "false");
      target.setAttribute("data-state", "closed");
      content.setAttribute("hidden", "true");
      content.setAttribute("data-state", "closed");
    }
  }
}
