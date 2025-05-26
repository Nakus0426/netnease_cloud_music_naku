import { Route, ZRouter } from '@hzw/zrouter'
import { AppStore, Routes } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'
import { TextModifier } from 'styles'
import { Avatar } from 'components'
import { Banner } from './Banner'

@ComponentV2
@Route({ name: Routes.HOME_INDEX })
export struct HomePage {
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local refreshing: boolean = false
  //region 顶部安全区域
  @Local topRectHeight: number = this.appStore.topRectHeight

  @Monitor('appStore.topRectHeight')
  onTopRectHeightChange() {
    this.topRectHeight = this.appStore.topRectHeight
  }

  //endregion

  build() {
    Navigation(ZRouter.getNavStack()) {
      Refresh({ refreshing: this.refreshing!! }) {
        Scroll() {
          Column() {
            Flex({ alignItems: ItemAlign.Center }) {
              Column() {
                Text('Hi，Naku')
                  .attributeModifier(new TextModifier({ size: 'h3', depth: 1 }))
                Text('探索你喜爱的音乐')
                  .attributeModifier(new TextModifier({ size: 'small', depth: 3 }))
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Avatar()
                .width(40)
            }
            .padding({
              top: 16,
              right: 24,
              bottom: 24,
              left: 24,
            })
            .alignSelf(ItemAlign.Center)

            Banner()
          }
        }
        .width('100%')
      }
      .height('100%')
    }
    .padding({ top: this.topRectHeight })
  }
}
