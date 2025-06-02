import { Route } from '@hzw/zrouter'
import { Routes } from 'utils'
import { NavDestinationTitle } from 'components'

@ComponentV2
@Route({ name: Routes.HOME_TOP_SONG })
export struct TopSongPage {
  @Local refreshing: boolean = false
  @Local titleBarHeight: number = 0

  @Builder
  titleBar() {
    NavDestinationTitle({ title: '新歌速递', onHeightChange: value => this.titleBarHeight = value })
  }

  @Builder
  refreshContent() {
    Row() {
      LoadingProgress()
        .height(36)
    }
    .height(this.titleBarHeight + 36)
    .alignItems(VerticalAlign.Bottom)
  }

  build() {
    NavDestination() {
      Refresh({ refreshing: this.refreshing!!, builder: this.refreshContent }) {
        Scroll() {
          Column() {
            Repeat([1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
              1,
              1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
              .each(() => {
                Text('scroll')
                  .fontSize(32)
                  .fontColor(Color.Red)
              })
          }
          .padding({ top: this.titleBarHeight })
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .refreshOffset(this.titleBarHeight + 36)
    }
    .title({ builder: this.titleBar, height: this.titleBarHeight }, { barStyle: BarStyle.STACK })
    .hideBackButton(true)
  }
}
