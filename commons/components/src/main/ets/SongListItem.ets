import { ImageKnifeComponentV2 } from '@ohos/imageknife'
import { TextModifier } from 'styles'

export namespace SongListItemProps {
  export interface Data {
    id: number
    imgUrl: string
    name: string
    artistName: string
  }
}

@ComponentV2
export struct SongListItem {
  @Param data: SongListItemProps.Data = {} as SongListItemProps.Data

  build() {
    Row() {
      ImageKnifeComponentV2({
        imageKnifeOption: {
          loadSrc: this.data.imgUrl,
          border: { radius: 8 },
          placeholderSrc: $r('app.media.image_placeholder'),
          placeholderObjectFit: ImageFit.Cover,
        },
      })
        .width(56)
        .height(56)

      Column({ space: 4 }) {
        Text(this.data.name)
          .attributeModifier(new TextModifier({ size: 'medium', depth: 1 }))
          .fontWeight(FontWeight.Bold)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.data.artistName)
          .attributeModifier(new TextModifier({ size: 'small', depth: 3 }))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .flexGrow(1)
      .flexShrink(1)
      .flexBasis('0%')
      .alignItems(HorizontalAlign.Start)
      .padding({ right: 10, left: 16 })

      Image($r('app.media.more'))
        .width(24)
        .height(24)
        .fillColor($r('app.color.text_1'))
    }
    .width('100%')
  }
}