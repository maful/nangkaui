import { Controller } from "@hotwired/stimulus"

const NAMESPACE="nangkaui";

export default class extends Controller {
  static values = {
    defaultValue: String
  }

  defaultValueValue: string;
  activeValue: string | null = null;
  previousValue: string | null = null;

  connect() {
    this.#updateState(this.defaultValueValue);
  }

  activate(e: Event) {
    const targetElement = e.target as HTMLButtonElement;
    const targetValue = this.#extractValue(targetElement.id);
    this.#updateState(targetValue);
  }

  #updateState(targetValue: string) {
    this.previousValue = this.activeValue;
    this.activeValue = targetValue;

    this.#reloadTabs();
  }

  #reloadTabs() {
    this.#reloadTrigger();
    this.#reloadContents();
  }

  #reloadTrigger() {
    const activeElement = this.#findTrigger(this.#makeTriggerId(this.activeValue!));
    activeElement.ariaSelected = "true";
    activeElement.setAttribute("data-state", "active");
    activeElement.setAttribute("tabindex", "0");

    if (this.previousValue) {
      const previousElement = this.#findTrigger(this.#makeTriggerId(this.previousValue));
      previousElement.ariaSelected = "false";
      previousElement.setAttribute("data-state", "inactive");
      previousElement.setAttribute("tabindex", "-1");
    }
  }

  #reloadContents() {
    const activeElement = this.#findContent(this.#makeContentId(this.activeValue!));
    activeElement.setAttribute("data-state", "active");
    activeElement.removeAttribute("hidden");

    if (this.previousValue) {
      const previousElement = this.#findContent(this.#makeContentId(this.previousValue));
      previousElement.setAttribute("data-state", "inactive");
      previousElement.setAttribute("hidden", "true");
    }
  }

  #findTrigger(id: string) {
    const elm = this.element.querySelector(`button#${id}`);
    if (!elm) throw new Error(`[nangkaui][tabs] unable to find trigger button with ID ${id}`);

    return elm;
  }

  #findContent(id: string) {
    const elm = this.element.querySelector(`div#${id}`);
    if (!elm) throw new Error(`[nangkaui][tabs] unable to find content with ID ${id}`);

    return elm;
  }

  #extractValue(value: string) {
    if (!value) return "";

    return value.split("-").slice(2).join("-");
  }

  #makeTriggerId(value: string) {
    return `${NAMESPACE}-trigger-${value}`;
  }

  #makeContentId(value: string) {
    return `${NAMESPACE}-content-${value}`;
  }
}
