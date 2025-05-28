import { ZRouter } from '@hzw/zrouter'
import { ImageKnifeComponentV2 } from '@ohos/imageknife'
import { getTopSong } from 'apis'
import { Title } from 'components'
import { TextModifier } from 'styles'
import { Routes } from 'utils'

interface TopSongData {
  imgUrl: string
  name: string
  artistName: string
}

@ComponentV2
export struct TopSong {
  @Local topSongs: Array<TopSongData> = []

  aboutToAppear() {
    this.init()
  }

  async init() {
    const res = await getTopSong()
    this.topSongs =
      res.data.slice(0, 10).map<TopSongData>(item => ({
        imgUrl: item.album.picUrl,
        name: item.name,
        artistName: item.artists[0].name,
      }))
  }

  build() {
    Column() {
      Title({
        title: '新歌速递', viewAll: true, onViewAllClick: () => {
          ZRouter.getInstance().push(Routes.HOME_TOP_SONG)
        },
      })
      List() {
        Repeat(this.topSongs)
          .each(item => {
            ListItem() {
              Column() {
                ImageKnifeComponentV2({
                  imageKnifeOption: {
                    loadSrc: item.item.imgUrl,
                    border: { radius: 15 },
                    placeholderSrc: $r('app.media.image_placeholder'),
                    placeholderObjectFit: ImageFit.Cover,
                  },
                })
                  .width('100%')
                  .height(140)
                Text(item.item.name)
                  .attributeModifier(new TextModifier({ size: 'medium', depth: 1 }))
                  .margin({ top: 8 })
                  .fontWeight(FontWeight.Bold)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(item.item.artistName)
                  .attributeModifier(new TextModifier({ size: 'small', depth: 3 }))
                  .margin({ top: 4 })
              }
              .width(140)
              .alignItems(HorizontalAlign.Start)
              .margin({ right: item.index === this.topSongs.length - 1 ? 0 : 16 })
            }
          })
          .virtualScroll({ totalCount: this.topSongs.length })
      }
      .width('100%')
      .height(212)
      .listDirection(Axis.Horizontal)
      .contentStartOffset(24)
      .contentEndOffset(24)
      .scrollBar(BarState.Off)
    }
    .margin({ bottom: 24 })
  }
}