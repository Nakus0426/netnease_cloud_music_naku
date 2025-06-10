import { TextModifier } from 'styles'

@ComponentV2
export struct Title {
  @Param title: string = ''
  @Param viewAll: boolean = false
  @Event onViewAllClick: () => void

  build() {
    Row() {
      Text(this.title)
        .attributeModifier(new TextModifier({ size: 'h4', depth: 1 }))
      Blank()
      if (this.viewAll) {
        Text('查看全部')
          .attributeModifier(new TextModifier({ size: 'small' }))
          .fontColor($r('app.color.primary_900'))
          .onClick(() => this.onViewAllClick())
      }
    }
    .width('100%')
    .padding({ right: 24, left: 24 })
    .margin({ bottom: 16 })
    .alignItems(VerticalAlign.Center)
  }
}