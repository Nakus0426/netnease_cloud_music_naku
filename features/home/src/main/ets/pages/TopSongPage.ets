import { Route } from '@hzw/zrouter'
import { groupByTime, Routes } from 'utils'
import { SongListGroupByTime, SongListItemGroupByTimeProps, TitleBar } from 'components'
import { getTopSong, GetTopSongResponse } from 'apis'

@ComponentV2
@Route({ name: Routes.HOME_TOP_SONG })
export struct TopSongPage {
  //#region 初始化数据
  @Local loading: boolean = false
  @Local data: Array<SongListItemGroupByTimeProps.Data> = []

  async initData() {
    try {
      this.loading = true
      const res = await getTopSong()
      const group = groupByTime<GetTopSongResponse.TopSong>(res.data, 'album.publishTime')
      const value: Array<SongListItemGroupByTimeProps.Data> = []
      const formatData = (data: GetTopSongResponse.TopSong): SongListItemGroupByTimeProps.Data => ({
        type: 'song',
        key: data.id.toString(),
        data: {
          imgUrl: data.album.picUrl,
          name: data.name,
          artistName: data.artists.map(artist => artist.name).join(','),
          id: data.id,
        },
      })
      if (group.today.length > 0) {
        value.push({ type: 'title', key: 'today', title: '今日' })
        value.push(...group.today.map(formatData))
      }
      if (group.yesterday.length > 0) {
        value.push({ type: 'title', key: 'yesterday', title: '昨日' })
        value.push(...group.yesterday.map(formatData))
      }
      if (group.lastWeek.length > 0) {
        value.push({ type: 'title', key: 'lastWeek', title: '上周' })
        value.push(...group.lastWeek.map(formatData))
      }
      if (group.earlier.length > 0) {
        value.push({ type: 'title', key: 'earlier', title: '更早之前' })
        value.push(...group.earlier.map(formatData))
      }
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

  //#region 滚动
  onDidScroll: SongListItemGroupByTimeProps.onDidScroll = (scroller) => {
    this.titleBarBorderVisible = scroller.currentOffset().yOffset > 0
  }
  //#endregion

  aboutToAppear() {
    this.initData()
  }

  build() {
    NavDestination() {
      SongListGroupByTime({ loading: this.loading, data: this.data, onDidScroll: this.onDidScroll })
    }
    .title({ builder: this.titleBarBuilder, height: this.titleBarHeight },
      { backgroundColor: Color.Transparent })
    .hideBackButton(true)
    .backgroundColor($r('app.color.base'))
  }
}
