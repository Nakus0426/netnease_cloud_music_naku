import { Skeleton } from './Skeleton'
import { SongListItem, SongListItemProps } from './SongListItem'
import { Title } from './Title'

export namespace SongListItemGroupByTimeProps {
  export interface Data {
    type: 'song' | 'title'
    key: string
    title?: string
    data?: SongListItemProps.Data
  }

  export type onDidScroll = (scroller: Scroller) => void
}


@ComponentV2
export struct SongListGroupByTime {
  @Consumer('appTabBarHeight') appTabBarHeight: Length = 0
  //#region 数据
  @Param loading: boolean = false
  @Param data: Array<SongListItemGroupByTimeProps.Data> = []
  //#endregion

  //#region 下拉刷新
  @Local refreshing: boolean = false

  //#endregion

  //#region 骨架屏
  @Builder
  skeletonBuilder() {
    Column({ space: 16 }) {
      Repeat([0, 1])
        .each(() => {
          Skeleton({
            loading: true,
            round: true,
            skeletonWidth: 80,
            textSize: 'h4',
          })
          Repeat([0, 1, 2])
            .each(() => {
              Row({ space: 16 }) {
                Skeleton({
                  loading: true,
                  round: true,
                  type: 'rect',
                  skeletonWidth: 56,
                  skeletonHeight: 56,
                })
                Column({ space: 4 }) {
                  Skeleton({ loading: true, round: true, skeletonWidth: 128 })
                  Skeleton({ loading: true, round: true, skeletonWidth: 64 })
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Start)
              }
            })
        })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 24 })
    .transition(TransitionEffect.OPACITY.animation({ duration: 200, curve: Curve.Linear }))
  }

  //#endregion

  //#region 滚动
  @Event onDidScroll: SongListItemGroupByTimeProps.onDidScroll
  private scroller: Scroller = new Scroller()
  onListDidScroll: OnScrollCallback = () => {
    this.onDidScroll(this.scroller)
  }

  //#endregion

  build() {
    Refresh({ refreshing: this.refreshing!! }) {
      if (this.loading) {
        this.skeletonBuilder()
      } else {
        List({ scroller: this.scroller }) {
          Repeat(this.data)
            .key(item => item.key)
            .templateId(item => item.type)
            .virtualScroll({ totalCount: this.data.length })
            .each(item => {
              ListItem() {
                SongListItem({ data: item.item.data })
                  .padding({ left: 24, right: 24 })
                  .margin({ bottom: 16 })
              }
            })
            .template('song', item => {
              ListItem() {
                SongListItem({ data: item.item.data })
                  .padding({ left: 24, right: 24 })
                  .margin({ bottom: 16 })
              }
            }, { cachedCount: 2 })
            .template('title', item => {
              ListItem() {
                Title({ title: item.item.title })
              }
            })
        }
        .width('100%')
        .height('100%')
        .padding({ bottom: this.appTabBarHeight })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .onDidScroll(this.onListDidScroll)
        .cachedCount(3)
        .transition(TransitionEffect.OPACITY.animation({ duration: 200, curve: Curve.Linear }))
      }
    }

  }
}