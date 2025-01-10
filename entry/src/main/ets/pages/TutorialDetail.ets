import router from '@ohos.router';

interface RouterParams {
  title: string;
  type: string;
}

@Component
struct TutorialSectionItem {
  @State private isPressed: boolean = false;
  title: string = '';
  content: string = '';
  stepNumber?: number;

  build() {
    Column() {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 8 })
      Text(this.content)
        .fontSize(16)
        .fontColor('#666666')
        .lineHeight(24)
    }
    .backgroundColor(Color.White)
    .padding(16)
    .borderRadius(12)
    .margin({ bottom: 12 })
    .width('100%')
    .opacity(this.isPressed ? 0.8 : 1)
    .onClick(() => {
      if (this.stepNumber !== undefined) {
        try {
          router.pushUrl({
            url: 'pages/StepTutorial',
            params: {
              initialStep: this.stepNumber
            }
          });
        } catch {
          console.error('Failed to navigate');
        }
      }
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
  }
}

@Entry
@Component
struct TutorialDetail {
  @State title: string = '';
  @State type: string = '';

  aboutToAppear() {
    const params = router.getParams() as RouterParams;
    this.title = params?.title ?? '悬浮窗使用教程';
    this.type = params?.type ?? 'basic';
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
        Text(this.title)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 教程内容
      Scroll() {
        Column() {
          if (this.type === 'basic') {
            // 基础教程内容
            Button({ type: ButtonType.Normal }) {
              Row() {
                Text('查看分步骤图文教程')
                  .fontSize(16)
                  .fontColor('#2196F3')
              }
            }
            .onClick(() => {
              router.pushUrl({ url: 'pages/StepTutorial' });
            })
            .backgroundColor('#E3F2FD')
            .padding(12)
            .borderRadius(8)
            .margin({ bottom: 16 })
            .width('100%')

            TutorialSectionItem({
              title: '1. 显示/隐藏悬浮窗',
              content: '点击右上角的"×"按钮可以关闭悬浮窗，点击左上角的"显示悬浮窗"按钮可以重新显示悬浮窗。',
              stepNumber: 1
            })
            
            TutorialSectionItem({
              title: '2. 拖动悬浮窗',
              content: '用手指按住悬浮窗的任意位置可以拖动悬浮窗到屏幕的任意位置。悬浮窗会自动防止超出屏幕边界。',
              stepNumber: 2
            })
            
            TutorialSectionItem({
              title: '3. 一键置顶',
              content: '点击悬浮窗底部的"一键置顶"按钮，悬浮窗会自动移动到屏幕顶部居中位置。',
              stepNumber: 3
            })
            
            TutorialSectionItem({
              title: '4. 自定义设置',
              content: '点击底部导航栏的"设置"按钮，可以进入设置页面，在那里可以修改悬浮窗的标题、内容和背景颜色。'
            })
          } else {
            // 进阶教程内容
            TutorialSectionItem({
              title: '1. 背景颜色设置',
              content: '在设置页面中，提供了6种预设的背景颜色供选择，包括默认灰色、浅粉红、淡紫色、淡绿色、爱丽丝蓝和浅黄色。点击颜色圆圈可以立即预览效果。'
            })
            
            TutorialSectionItem({
              title: '2. 文本自定义',
              content: '可以自定义悬浮窗的标题和内容文本，输入的内容会实时显示在悬浮窗上。这让您可以根据需要显示任何想要的信息。'
            })
            
            TutorialSectionItem({
              title: '3. 位置记忆',
              content: '悬浮窗的位置信息会被记住，即使关闭后重新打开，也会保持在上次的位置。这提供了更好的使用体验。'
            })
            
            TutorialSectionItem({
              title: '4. 边界保护',
              content: '拖动悬浮窗时，内置了边界保护机制，确保悬浮窗不会完全移出屏幕，始终保持可操作性。'
            })
          }
        }
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
  }
} 