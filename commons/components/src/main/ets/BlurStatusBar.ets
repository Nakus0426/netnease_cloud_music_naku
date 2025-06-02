import { AppStore } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'

@ComponentV2
export struct BlurStatusBar {
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local topRectHeight: number = this.appStore.topRectHeight

  @Monitor('appStore.topRectHeight')
  onTopRectHeightChange() {
    this.topRectHeight = this.appStore.topRectHeight
  }

  build() {
    Rect()
      .width('100%')
      .height(this.topRectHeight)
      .position({ top: 0 })
      .linearGradientBlur(1000, { fractionStops: [[0, 0], [0.5, 0.5], [1, 1]], direction: GradientDirection.Top })
      .fill(Color.Transparent)
  }
}