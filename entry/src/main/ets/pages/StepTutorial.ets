import router from '@ohos.router';

interface RouterParams {
  initialStep?: number;
}

@Entry
@Component
struct StepTutorial {
  @State currentStep: number = 1;
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    if (params?.initialStep) {
      this.currentStep = params.initialStep;
    }
  }
  
  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .margin({ right: 16 })
          .onClick(() => {
            router.back();
          })
        Text('使用步骤')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 步骤内容
      Scroll(this.scroller) {
        Column() {
          // 步骤1
          Column() {
            Image($r('app.media.step_1'))
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(12)
            
            Text('第1步：打开悬浮窗')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 16, bottom: 8 })
            
            Text('点击应用顶部的"显示悬浮窗"按钮，即可打开悬浮窗。悬浮窗会显示在屏幕中央位置。')
              .fontSize(16)
              .fontColor('#666666')
              .lineHeight(24)
          }
          .id('step1')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })
          .opacity(this.currentStep === 1 ? 1 : 0.6)

          // 步骤2
          Column() {
            Image($r('app.media.step_2'))
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(12)
            
            Text('第2步：拖动调整位置')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 16, bottom: 8 })
            
            Text('按住悬浮窗的任意位置，可以将其拖动到屏幕上任何你想要的位置。悬浮窗会自动避免超出屏幕边界。')
              .fontSize(16)
              .fontColor('#666666')
              .lineHeight(24)
          }
          .id('step2')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })
          .opacity(this.currentStep === 2 ? 1 : 0.6)

          // 步骤3
          Column() {
            Image($r('app.media.step_3'))
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(12)
            
            Text('第3步：自定义设置')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 16, bottom: 8 })
            
            Text('点击底部导航栏的"设置"按钮，进入设置页面。在这里你可以修改悬浮窗的标题、内容文本，以及选择不同的背景颜色。所有的修改都会实时反映在悬浮窗上。')
              .fontSize(16)
              .fontColor('#666666')
              .lineHeight(24)
          }
          .id('step3')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 16 })
          .opacity(this.currentStep === 3 ? 1 : 0.6)
        }
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
      .onScrollEdge((side: Edge) => {
        if (side === Edge.Top && this.currentStep > 1) {
          this.currentStep--;
        } else if (side === Edge.Bottom && this.currentStep < 3) {
          this.currentStep++;
        }
      })
    }
  }

  onPageShow() {
    // 页面显示时滚动到指定步骤
    setTimeout(() => {
      this.scroller.scrollToElement(`step${this.currentStep}`, {
        duration: 300,
        align: ScrollAlign.Center
      });
    }, 100);
  }
} 