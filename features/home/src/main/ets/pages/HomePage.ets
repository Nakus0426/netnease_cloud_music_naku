import { Route, ZRouter } from '@hzw/zrouter'
import { Routes } from 'utils'

@ComponentV2
@Route({ name: Routes.HOME_INDEX })
export struct HomePage {
  build() {
    Navigation(ZRouter.getNavStack()) {
      Column() {
        Button('跳转至HOME_2')
          .onClick(() => ZRouter.getInstance().navigation(Routes.HOME_INDEX_2))
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.Red)
  }
}
