import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { FloatingWindowViewModel } from '../viewmodels/FloatingWindowViewModel';

@Entry
@Component
struct Index {
  private viewModel: FloatingWindowViewModel = new FloatingWindowViewModel();
  @State message: string = this.viewModel.getMessage();
  @State isShow: boolean = this.viewModel.getIsShow();
  @State posX: number = this.viewModel.getPosX();
  @State posY: number = this.viewModel.getPosY();
  private startPosX: number = 0;
  private startPosY: number = 0;
  private startTouchX: number = 0;
  private startTouchY: number = 0;
  private isDragging: boolean = false;

  private moveToTopCenter() {
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut,
    }, () => {
      this.viewModel.moveToTopCenter();
      this.posX = this.viewModel.getPosX();
      this.posY = this.viewModel.getPosY();
    })
  }

  build() {
    Stack() {
      Scroll() {
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
            EnablementItem({ 
              title: '悬浮窗使用教程',
              brief: '学习如何使用和控制悬浮窗，掌握基本操作技巧',
              imageSrc: $r('app.media.jiemianyi')
            })
            EnablementItem({ 
              title: '悬浮窗进阶技巧',
              brief: '探索悬浮窗的高级特性，实现更多自定义功能',
              imageSrc: $r('app.media.jiemianer')
            })
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
            TutorialItem({ 
              title: 'Step1 基础操作指南',
              brief: '学习悬浮窗的基本操作，包括拖拽、显示/隐藏等基础功能的使用方法',
              imageSrc: $r('app.media.jiemiansan')
            })
              .margin({ bottom: 12 })
            TutorialItem({ 
              title: 'Step2 自定义设置',
              brief: '了解如何调整悬浮窗的大小、位置、样式等个性化设置选项',
              imageSrc: $r('app.media.jiemiansi')
            })
              .margin({ bottom: 12 })
            TutorialItem({ 
              title: 'Step3 高级功能探索',
              brief: '探索悬浮窗的高级特性，如动画效果、交互响应等进阶功能',
              imageSrc: $r('app.media.jiemianwu')
            })
          }
          .width('92%')
          .margin({ top: 6, bottom: 60 })
          .padding({ left: 4, right: 4 })
        }
        .width('100%')
        .padding({ bottom: 48 })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      if (this.isShow) {
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
                this.viewModel.setIsShow(false);
                this.isShow = false;
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
        .width(this.viewModel.getConstants().PANEL_WIDTH)
        .height(this.viewModel.getConstants().PANEL_HEIGHT)
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

              const deltaX = event.offsetX - this.startTouchX;
              const deltaY = event.offsetY - this.startTouchY;

              this.viewModel.setPosX(this.startPosX + deltaX);
              this.viewModel.setPosY(this.startPosY + deltaY);
              
              this.posX = this.viewModel.getPosX();
              this.posY = this.viewModel.getPosY();
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
            this.viewModel.setIsShow(true);
            this.isShow = true;
            this.moveToTopCenter();
          })
      }

      Row() {
        Button({ type: ButtonType.Normal }) {
          Column() {
            Image($r('app.media.fangdajing'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
            Text('教程')
              .fontSize(14)
              .fontColor('#333333')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
        }
        .backgroundColor(Color.White)
        .layoutWeight(1)
        .height(56)
        .onClick(() => {
          hilog.info(0x0000, 'testTag', '%{public}s', '点击了教程按钮');
        })

        Button({ type: ButtonType.Normal }) {
          Column() {
            Image($r('app.media.chilun'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
            Text('设置')
              .fontSize(14)
              .fontColor('#333333')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
        }
        .backgroundColor(Color.White)
        .layoutWeight(1)
        .height(56)
        .onClick(() => {
          hilog.info(0x0000, 'testTag', '%{public}s', '点击了设置按钮');
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .position({ x: 0, y: '100%' })
      .translate({ y: -56 })
      .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.1)', offsetY: -2 })
      .zIndex(2)
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
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
  @Prop title: string = '如何受用悬浮窗';
  @Prop brief: string = '使用悬浮窗的一些小技巧';
  @Prop imageSrc: Resource = $r('app.media.jiemianyi');

  build() {
    Column() {
      Image(this.imageSrc)
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
  @Prop title: string = 'Step1 快速入门介绍';
  @Prop brief: string = '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。';
  @Prop imageSrc: Resource = $r('app.media.jiemiansan');

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

      Image(this.imageSrc)
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
