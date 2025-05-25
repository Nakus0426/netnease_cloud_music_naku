import { Route, ZRouter } from '@hzw/zrouter'
import { AppStore, Routes } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'

@ComponentV2
@Route({ name: Routes.HOME_INDEX })
export struct HomePage {
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local topRectHeight: number = this.appStore.topRectHeight

  @Monitor('appStore.topRectHeight')
  onTopRectHeightChange() {
    this.topRectHeight = this.appStore.topRectHeight
  }

  build() {
    Navigation(ZRouter.getNavStack()) {
      Scroll(){
        Column(){
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
          Text('123').fontSize(40)
        }
      }
      .width('100%')
      .padding({ top: this.topRectHeight })
    }
  }
}
