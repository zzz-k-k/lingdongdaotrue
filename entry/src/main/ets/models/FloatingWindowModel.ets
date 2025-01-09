export interface WindowConstants {
  WINDOW_WIDTH: number;
  WINDOW_HEIGHT: number;
  PANEL_WIDTH: number;
  PANEL_HEIGHT: number;
}

export class FloatingWindowModel {
  readonly WINDOW_WIDTH: number = 360;   // 设备宽度（vp）
  readonly WINDOW_HEIGHT: number = 640;  // 设备高度（vp）
  readonly PANEL_WIDTH: number = 300;    // 悬浮窗宽度（vp）
  readonly PANEL_HEIGHT: number = 200;   // 悬浮窗高度（vp）

  message: string = '一个幽默风趣的牛仔';
  isShow: boolean = true;
  posX: number = 100;
  posY: number = 100;
} 