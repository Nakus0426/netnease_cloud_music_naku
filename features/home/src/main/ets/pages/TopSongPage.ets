import { Route } from '@hzw/zrouter'
import { Routes } from 'utils'
import { SongListItem, SongListItemProps, Title, TitleBar } from 'components'
import { getTopSong } from 'apis'
import dayjs from 'dayjs'

interface Data {
  type: 'song' | 'title'
  key: string
  title?: string
  data?: SongListItemProps.Data
}

@ComponentV2
@Route({ name: Routes.HOME_TOP_SONG })
export struct TopSongPage {
  @Consumer('appTabBarHeight') appTabBarHeight: Length = 0
  //#region 初始化数据
  @Local loading: boolean = false
  @Local data: Array<Data> = []

  async initData() {
    try {
      this.loading = true
      const res = await getTopSong()
      const today: Array<Data> = []
      const yesterday: Array<Data> = []
      const lastWeek: Array<Data> = []
      const earlier: Array<Data> = []
      const now = dayjs()
      const todayStart = now.startOf('day')
      const yesterdayStart = now.subtract(1, 'day').startOf('day')
      const lastWeekStart = now.subtract(7, 'day').startOf('day')
      res.data.forEach(item => {
        const time = dayjs(item.album.publishTime)
        const value: SongListItemProps.Data = {
          imgUrl: item.album.picUrl,
          name: item.name,
          artistName: item.artists.map(artist => artist.name).join(','),
          id: item.id,
        }
        const key = value.id.toString()
        if (time.isSame(todayStart, 'day')) {
          today.push({ type: 'song', data: value, key })
        } else if (time.isSame(yesterdayStart, 'day')) {
          yesterday.push({ type: 'song', data: value, key })
        } else if (time.isAfter(lastWeekStart)) {
          lastWeek.push({ type: 'song', data: value, key })
        } else {
          earlier.push({ type: 'song', data: value, key })
        }
      })
      const value: Array<Data> = []
      value.push({ type: 'title', title: '今日', key: '今日' })
      value.push(...today)
      value.push({ type: 'title', title: '昨日', key: '昨日' })
      value.push(...yesterday)
      value.push({ type: 'title', title: '上周', key: '上周' })
      value.push(...lastWeek)
      value.push({ type: 'title', title: '更早', key: '更早' })
      value.push(...earlier)
      this.data = value
    } finally {
      this.loading = false
    }
  }

  //#endregion

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
  //#endregion

  //#region 滚动
  private scroller: Scroller = new Scroller()
  onDidScroll: OnScrollCallback = () => {
    this.titleBarBorderVisible = this.scroller.currentOffset().yOffset > 0
  }

  //#endregion

  aboutToAppear() {
    this.initData()
  }

  build() {
    NavDestination() {
      Refresh({ refreshing: this.refreshing!! }) {
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
              Title({ title: item.item.title })
            })
        }
        .width('100%')
        .height('100%')
        .padding({ bottom: this.appTabBarHeight })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .onDidScroll(this.onDidScroll)
        .cachedCount(3)
      }
    }
    .title({ builder: this.titleBarBuilder, height: this.titleBarHeight },
      { backgroundColor: Color.Transparent })
    .hideBackButton(true)
    .backgroundColor($r('app.color.base'))
  }
}
