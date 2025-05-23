import { Route, ZRouter } from '@hzw/zrouter'
import { Routes } from 'utils'

@ComponentV2
@Route({ name: Routes.HOME_INDEX_2 })
export struct HomePage2 {
  build() {
    NavDestination() {
      Column() {
        Button('跳转至HOME').onClick(() => ZRouter.getInstance().popToName(Routes.HOME_INDEX))
      }
      .width('100%')
      .height('100%')
    }
  }
}