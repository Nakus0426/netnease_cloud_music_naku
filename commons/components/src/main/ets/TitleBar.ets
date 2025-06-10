import { AppStore } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'
import { TextModifier } from 'styles'
import { ZRouter } from '@hzw/zrouter'

@ComponentV2
export struct TitleBar {
  @Param title: string = ''
  @Param more: boolean = false
  @Param borderVisible: boolean = false
  //#region 顶部安全区域
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local topRectHeight: number = this.appStore.topRectHeight

  @Monitor('appStore.topRectHeight')
  onTopRectHeightChange() {
    this.topRectHeight = this.appStore.topRectHeight
    this.onHeightChange(this.titleBarHeight)
  }

  //#endregion

  //#region 高度
  @Event onHeightChange: (height: number) => void

  @Computed
  get titleBarHeight() {
    return this.topRectHeight + 64
  }

  //#endregion

  aboutToAppear() {
    this.onHeightChange(this.titleBarHeight)
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      Image($r('app.media.arrow_left'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.text_1'))
        .onClick(() => ZRouter.getInstance().pop())

      Text(this.title)
        .attributeModifier(new TextModifier({ size: 'h4', depth: 1 }))

      Image($r('app.media.more'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.text_1'))
        .visibility(this.more ? Visibility.Visible : Visibility.Hidden)
    }
    .width('100%')
    .height(this.titleBarHeight)
    .backgroundColor($r('app.color.base'))
    .border({ width: { bottom: 1 }, color: this.borderVisible ? $r('app.color.border') : Color.Transparent })
    .padding({ top: this.topRectHeight, right: 24, left: 24 })
  }
}