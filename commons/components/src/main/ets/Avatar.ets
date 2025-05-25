
@ComponentV2
export struct Avatar {
  build() {
    Image($r('app.media.avatar'))
      .aspectRatio(1)
      .borderRadius('50%')
      .clip(true)
      .draggable(false)
  }
}