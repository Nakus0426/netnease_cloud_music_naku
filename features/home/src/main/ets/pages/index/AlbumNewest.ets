import { ImageKnifeComponentV2 } from '@ohos/imageknife'
import { getAlbumNewest } from 'apis'
import { Title } from 'components'
import { TextModifier } from 'styles'

interface TopSongData {
  imgUrl: string
  name: string
  artistName: string
}

@ComponentV2
export struct AlbumNewest {
  @Local albumNewestList: Array<TopSongData> = []

  aboutToAppear() {
    this.init()
  }

  async init() {
    const res = await getAlbumNewest()
    this.albumNewestList =
      res.albums.map<TopSongData>(item => ({
        imgUrl: item.picUrl,
        name: item.name,
        artistName: item.artists[0].name,
      }))
  }

  build() {
    Column() {
      Title({ title: '最新专辑' })
      List() {
        Repeat(this.albumNewestList)
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
                  .aspectRatio(1)
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
              .margin({ right: item.index === this.albumNewestList.length - 1 ? 0 : 16 })
            }
          })
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