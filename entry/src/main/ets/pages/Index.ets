import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Index {
  @State message: string = '一个幽默风趣的牛仔';
  @State isShow: boolean = true;
  @State posX: number = 100;
  @State posY: number = 100;
  private startPosX: number = 0;
  private startPosY: number = 0;
  private startTouchX: number = 0;
  private startTouchY: number = 0;
  private isDragging: boolean = false;
  private readonly WINDOW_WIDTH: number = 360;   // 设备宽度（vp）
  private readonly WINDOW_HEIGHT: number = 640;  // 设备高度（vp）
  private readonly PANEL_WIDTH: number = 300;    // 悬浮窗宽度（vp）
  private readonly PANEL_HEIGHT: number = 200;   // 悬浮窗高度（vp）

  private moveToTopCenter() {
    // 计算顶部中间位置
    const centerX = 30; // (360 - 300) / 2
    const topY = 20;    // 距离顶部20vp
    
    // 使用动画移动到顶部中间
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut,
    }, () => {
      this.posX = centerX;
      this.posY = topY;
    })
  }

  build() {
    Stack() {  // 使用 Stack 作为根组件，这样可以让内容和悬浮窗正确叠加
      Column() {
        Text(this.message)
          .fontSize(24)
          .fontWeight(700)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontFamily('HarmonyHeiTi-Bold')
          .lineHeight(33)
        Swiper() {
          aaaaaa()
          Banner()
          eeeeee()
        }
        .loop(true)
        Row() {
          EnablementItem()
          EnablementItem()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 25 })

        Text("教程")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 15, bottom: 8 })
          .width('92%')

        Column(){
          TutorialItem()
            .margin({ bottom: 12 })
          TutorialItem()
            .margin({ bottom: 12 })
          TutorialItem()
        }
        .width('92%')
        .margin({ top: 6 })
        .padding({ left: 4, right: 4 })
      }
      .width('100%')

      if (this.isShow) {
        // 悬浮窗
        Column() {
          Row() {
            Text('悬浮窗')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
            Blank()
            Text('×')
              .fontSize(24)
              .fontColor('#666666')
              .onClick(() => {
                this.isShow = false
              })
              .padding(8)
              .height(40)
              .width(40)
              .textAlign(TextAlign.Center)
              .borderRadius(20)
              .backgroundColor('rgba(238, 238, 238, 0.5)')
          }
          .width('100%')
          .padding(10)
          .backgroundColor('rgba(238, 238, 238, 0.5)')

          Text('这是一个简单的悬浮窗')
            .fontSize(16)
            .padding(10)
            .fontColor('#333333')
            
          Row() {
            Button() {
              Row() {
                Text('⌖')
                  .fontSize(20)
                  .fontColor(Color.White)
                  .margin({ right: 4 })
                Text('一键置顶')
                  .fontSize(16)
                  .fontColor(Color.White)
              }.alignItems(VerticalAlign.Center)
            }
            .height(35)
            .backgroundColor('#4E86FF')
            .borderRadius(17.5)
            .padding({ left: 16, right: 16 })
            .onClick(() => {
              this.moveToTopCenter();
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ bottom: 10, left: 16, right: 16 })
        }
        .width(this.PANEL_WIDTH)
        .height(this.PANEL_HEIGHT)
        .backgroundColor('rgba(245, 245, 245, 0.8)')
        .backdropBlur(8)
        .borderRadius(8)
        .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        .position({ x: this.posX + 'vp', y: this.posY + 'vp' })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              if (event && event.offsetX !== undefined && event.offsetY !== undefined) {
                this.isDragging = true;
                // 记录开始拖动时的位置
                this.startPosX = this.posX;
                this.startPosY = this.posY;
                this.startTouchX = event.offsetX;
                this.startTouchY = event.offsetY;
              }
            })
            .onActionUpdate((event: GestureEvent) => {
              if (!this.isDragging || !event || event.offsetX === undefined || event.offsetY === undefined) {
                return;
              }

              // 计算相对于起始触摸点的偏移
              const deltaX = event.offsetX - this.startTouchX;
              const deltaY = event.offsetY - this.startTouchY;

              // 直接更新位置到新位置
              this.posX = this.startPosX + deltaX;
              this.posY = this.startPosY + deltaY;

              // 限制在屏幕范围内
              this.posX = Math.max(0, Math.min(this.posX, this.WINDOW_WIDTH - this.PANEL_WIDTH));
              this.posY = Math.max(0, Math.min(this.posY, this.WINDOW_HEIGHT - this.PANEL_HEIGHT));
            })
            .onActionEnd(() => {
              this.isDragging = false;
            })
        )
      }

      if (!this.isShow) {
        Button('显示悬浮窗')
          .position({ x: '20vp', y: '20vp' })
          .onClick(() => {
            this.isShow = true;
            this.moveToTopCenter();
          })
      }
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 初始化时移动到顶部中间
    this.moveToTopCenter();
  }
}

@Styles function card() {
  .width('100%')
  .padding(12)
  .backgroundColor(Color.White)
  .borderRadius(8)
  .shadow({ radius: 4, color: '#1F000000', offsetX: 2, offsetY: 2 })
}
@Preview
@Component
struct Banner {
  build() {
    Image($r('app.media.xiangzi'))
      .objectFit(ImageFit.Cover)
      .width('100%')
      .height(160)
      .padding({ top: 11, left: 16, right: 16 })
  }
}
@Preview
@Component
struct eeeeee {
  build() {
    Image($r('app.media.img'))
      .objectFit(ImageFit.Cover)
      .width('100%')
      .height(160)
      .padding({ top: 11, left: 16, right: 16 })
  }
}
@Preview
@Component
struct aaaaaa {
  build() {
    Image($r('app.media.img_1'))
      .objectFit(ImageFit.Cover)
      .width('100%')
      .height(160)
      .padding({ top: 11, left: 16, right: 16 })
  }
}
@Preview
@Component
struct EnablementItem {
  private title: string = 'HarmonyOS第一课';
  private brief: string = '基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习��验。';

  build() {
    Column() {
      Image($r('app.media.enablement_pic1'))
        .width('100%')
        .objectFit(ImageFit.Cover)
        .height(96)
        .borderRadius({
          topLeft: 16,
          topRight: 16
        })
      Text(this.title)
        .height(19)
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .fontWeight(400)
        .padding({ left: 12, right: 12 })
        .margin({ top: 8 })
      Text(this.brief)
        .height(32)
        .width('100%')
        .fontSize(12)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontWeight(400)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 2 })
    }
    .width(160)
    .height(169)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }
}
@Preview
@Component
struct TutorialItem {
  private title: string = 'Step1 快速入门介绍';
  private brief: string = '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。';

  build() {
    Row() {
      Column() {
        Text(this.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Text(this.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .margin({ top: 5 })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })

      Image($r('app.media.enablement_pic1'))
        .objectFit(ImageFit.Cover)
        .height(64)
        .width(108)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}
