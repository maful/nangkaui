import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["image", "fallback"];
  static values = {
    delay: { type: Number, default: 0 }
  };

  states = {
    IDLE: "idle",
    LOADING: "loading",
    LOADED: "loaded",
    ERROR: "error"
  }

  declare delayValue: number;
  declare readonly hasFallbackTarget: boolean;
  declare readonly fallbackTarget: HTMLSpanElement;
  declare readonly imageTarget: HTMLImageElement;
  status: string;
  fallbackTimeout: number | null;

  initialize() {
    this.status = this.states.IDLE;
    this.fallbackTimeout = null;
  }

  connect() {
    const imageSource = this.imageTarget.getAttribute("data-source")!;
    this.imageTarget.addEventListener("load", this.imageLoad.bind(this));
    this.imageTarget.addEventListener("error", this.imageError.bind(this));
    this.imageTarget.src = imageSource;
  }

  disconnect() {
    this.imageTarget.removeEventListener("load", this.imageLoad.bind(this));
    this.imageTarget.removeEventListener("error", this.imageError.bind(this));

    if (this.fallbackTimeout) {
      clearTimeout(this.fallbackTimeout);
    }
  }

  imageLoad() {
    this.status = this.states.LOADED;
    this.#updateFallbackVisibility();
  }

  imageError() {
    this.status = this.states.ERROR;
    this.#updateFallbackVisibility();
  }

  #updateFallbackVisibility() {
    if (this.hasFallbackTarget) {
      if (this.delayValue > 0) {
        this.fallbackTimeout = setTimeout(() => {
          this.#toggleFallback();
        }, this.delayValue);
      } else {
        this.#toggleFallback();
      }
    }
  }

  #toggleFallback() {
    if (this.status !== this.states.LOADED) {
      this.fallbackTarget.style.display = "";
      this.imageTarget.style.display = "none";
    } else {
      this.fallbackTarget.style.display = "none";
      this.imageTarget.style.display = "";
    }
  }
}
