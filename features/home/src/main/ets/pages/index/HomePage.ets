import { Route, ZRouter } from '@hzw/zrouter'
import { AppStore, Routes } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'
import { TextModifier } from 'styles'
import { Avatar } from 'components'
import { Banner } from './Banner'
import { TopSong } from './TopSong'
import { AlbumNewest } from './AlbumNewest'

@ComponentV2
@Route({ name: Routes.HOME_INDEX })
export struct HomePage {
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local refreshing: boolean = false
  @Consumer('appTabBarHeight') appTabBarHeight: Length = 0
  //#region 顶部安全区域
  @Local topRectHeight: number = this.appStore.topRectHeight

  @Monitor('appStore.topRectHeight')
  onTopRectHeightChange() {
    this.topRectHeight = this.appStore.topRectHeight
  }

  //#endregion

  //#region 吸顶标题栏
  @Local stickyHeaderOpacity: number = 0
  handleHeaderVisibleAreaChange: VisibleAreaChangeCallback = (_isExpanding, currentRatio) => {
    this.stickyHeaderOpacity = currentRatio < 0.5 ? 1 - (currentRatio * 2) : 0
  }

  //#endregion

  @Builder
  refreshContent() {
    Row() {
      LoadingProgress()
        .height(36)
    }
    .height(this.topRectHeight + 36)
    .alignItems(VerticalAlign.Bottom)
  }

  build() {
    Navigation(ZRouter.getNavStack()) {
      Stack() {
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
            .onVisibleAreaChange([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1],
              this.handleHeaderVisibleAreaChange)

            Banner()

            TopSong()

            AlbumNewest()
          }
        }
        .width('100%')
        .height('100%')
        .padding({ top: this.topRectHeight, bottom: this.appTabBarHeight })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        Row() {
          Row({ space: 8 }) {
            Avatar()
              .width(40)
            Text('Naku')
              .attributeModifier(new TextModifier({ size: 'h3', depth: 1 }))
          }

          Row() {
            SymbolGlyph($r('sys.symbol.magnifyingglass'))
              .fontSize(24)
              .fontColor([$r('app.color.placeholder')])
          }
          .width(40)
          .height(40)
          .backgroundColor($r('app.color.card_overlay'))
          .borderRadius('50%')
          .justifyContent(FlexAlign.Center)
        }
        .position({ top: 0, right: 0, left: 0 })
        .padding({
          top: this.topRectHeight + 16,
          right: 24,
          bottom: 16,
          left: 24,
        })
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor($r('app.color.background_overlap'))
        .backgroundBlurStyle(this.stickyHeaderOpacity > 0.5 ? BlurStyle.Thick : BlurStyle.NONE)
        .border({ width: { bottom: 1 }, color: $r('app.color.border') })
        .opacity(this.stickyHeaderOpacity)
      }
      .width('100%')
      .height('100%')
    }
  }
}
