import { FloatingWindowModel, WindowConstants } from '../models/FloatingWindowModel';

export class FloatingWindowViewModel {
  private static instance: FloatingWindowViewModel = new FloatingWindowViewModel();
  private model: FloatingWindowModel = new FloatingWindowModel();
  private backgroundColor: string = '#F5F5F5CC';

  private constructor() {
    // 私有构造函数确保单例
  }

  static getInstance(): FloatingWindowViewModel {
    return FloatingWindowViewModel.instance;
  }

  getMessage(): string {
    return this.model.message;
  }

  setMessage(value: string): void {
    this.model.message = value;
  }

  getIsShow(): boolean {
    return this.model.isShow;
  }

  setIsShow(value: boolean): void {
    this.model.isShow = value;
  }

  getPosX(): number {
    return this.model.posX;
  }

  getPosY(): number {
    return this.model.posY;
  }

  setPosX(value: number): void {
    this.model.posX = Math.max(0, Math.min(value, this.model.WINDOW_WIDTH - this.model.PANEL_WIDTH));
  }

  setPosY(value: number): void {
    this.model.posY = Math.max(0, Math.min(value, this.model.WINDOW_HEIGHT - this.model.PANEL_HEIGHT));
  }

  moveToTopCenter(): void {
    const centerX = 30;
    const topY = 20;
    this.setPosX(centerX);
    this.setPosY(topY);
  }

  getConstants(): WindowConstants {
    return {
      WINDOW_WIDTH: this.model.WINDOW_WIDTH,
      WINDOW_HEIGHT: this.model.WINDOW_HEIGHT,
      PANEL_WIDTH: this.model.PANEL_WIDTH,
      PANEL_HEIGHT: this.model.PANEL_HEIGHT
    };
  }

  getBackgroundColor(): string {
    return this.backgroundColor;
  }

  setBackgroundColor(color: string): void {
    this.backgroundColor = color;
  }

  static setBackgroundColor(color: string): void {
    FloatingWindowViewModel.instance.setBackgroundColor(color);
  }
} 