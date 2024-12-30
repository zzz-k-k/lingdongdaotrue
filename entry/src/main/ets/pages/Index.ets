import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State isShow: boolean = true;
  @State posX: number = 100;
  @State posY: number = 100;

  build() {
    Stack() {
      // 背景内容
      RelativeContainer() {
        Text(this.message)
          .id('HelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .height('100%')
      .width('100%')

      if (this.isShow) {
        // 悬浮窗
        Column() {
          Row() {
            Text('悬浮窗')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Blank()
            Button('关闭')
              .fontSize(16)
              .onClick(() => {
                this.isShow = false
              })
          }
          .width('100%')
          .padding(10)
          .backgroundColor('#EEEEEE')

          Text('这是一个简单的悬浮窗')
            .fontSize(16)
            .padding(10)
        }
        .width(300)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
        .position({x: this.posX + 'px', y: this.posY + 'px'})
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              console.info('Pan start')
            })
            .onActionUpdate((event: GestureEvent) => {
              if (event && event.offsetX) {
                this.posX += event.offsetX
              }
              if (event && event.offsetY) {
                this.posY += event.offsetY
              }
            })
            .onActionEnd(() => {
              console.info('Pan end')
            })
        )
      }

      if (!this.isShow) {
        Button('显示悬浮窗')
          .position({x: 20, y: 20})
          .onClick(() => {
            this.isShow = true
          })
      }
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }
}

@Styles function card() {
  .width('100%')
  .padding(12)
  .backgroundColor(Color.White)
  .borderRadius(8)
  .shadow({ radius: 4, color: '#1F000000', offsetX: 2, offsetY: 2 })
}