import { Route } from '@hzw/zrouter'
import { Routes } from 'utils'
import { Title, TitleBar } from 'components'

@ComponentV2
@Route({ name: Routes.HOME_TOP_SONG })
export struct TopSongPage {
  //#region 标题栏
  @Local titleBarHeight: number = 0
  @Local titleBarBorderVisible: boolean = false

  @Builder
  titleBarBuilder() {
    TitleBar({
      title: '新歌速递',
      borderVisible: this.titleBarBorderVisible,
      onHeightChange: value => this.titleBarHeight = value,
    })
  }

  //#endregion

  //#region 下拉刷新
  @Local refreshing: boolean = false

  @Builder
  refreshContent() {
    Row() {
      LoadingProgress()
        .height(36)
    }
    .width('100%')
    .height(36)
    .alignItems(VerticalAlign.Bottom)
    .justifyContent(FlexAlign.Center)
    .position({ top: this.titleBarHeight + this.titleBarHeight / 2 - 18 })
  }

  //#endregion

  private scroller: Scroller = new Scroller()
  onDidScroll: ScrollOnScrollCallback = () => {
    this.titleBarBorderVisible = this.scroller.currentOffset().yOffset > 0
  }

  build() {
    NavDestination() {
      Refresh({ refreshing: this.refreshing!!, builder: this.refreshContent }) {
        Scroll(this.scroller) {
          Column() {
            Title({ title: '今日' })
          }
          .width('100%')
          .height('100%')
          .padding({ top: this.titleBarHeight })
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .onDidScroll(this.onDidScroll)
      }
      .refreshOffset(this.titleBarHeight)
    }
    .title({ builder: this.titleBarBuilder, height: this.titleBarHeight },
      { barStyle: BarStyle.STACK, backgroundColor: Color.Transparent })
    .hideBackButton(true)
  }
}
