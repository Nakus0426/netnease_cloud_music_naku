import { textLineHeightMap, TextSize } from 'styles'

type SkeletonType = 'text' | 'circle' | 'rect'

@ComponentV2
export struct Skeleton {
  @Param round: boolean = true
  @Param type: SkeletonType = 'text'
  @Param textSize: TextSize = 'medium'
  @Param loading: boolean = false
  @Param skeletonWidth: Length = '100%'
  @Param skeletonHeight: Length = '100%'
  @Param skeletonPadding: Length | Padding | LocalizedPadding = 0
  @Param skeletonMargin: Length | Padding | LocalizedPadding = 0
  @BuilderParam defaultBuilder: CustomBuilder
  @Local positionX: string = '-100%'

  build() {
    if (this.loading) {
      Row() {
        Rect()
          .width('100%')
          .height('100%')
          .fill(Color.Transparent)
          .translate({ x: this.positionX })
          .animation({
            duration: 1400,
            iterations: -1,
            curve: Curve.EaseInOut,
          })
          .linearGradient({
            angle: 90,
            colors: [
              [$r('app.color.skeleton_background'), 0],
              [$r('app.color.skeleton_background_animation'), 0.5],
              [$r('app.color.skeleton_background'), 1],
            ],
          })
      }
      .width(this.skeletonWidth)
      .height(this.type === 'text' ? textLineHeightMap.get(this.textSize) : this.skeletonHeight)
      .backgroundColor($r('app.color.skeleton_background'))
      .borderRadius(this.type === 'circle' ? '50%' : this.round ? 15 : 0)
      .margin(this.skeletonPadding)
      .margin(this.skeletonMargin)
      .clip(true)
      .onAppear(() => (this.positionX = '100%'))
      .transition(TransitionEffect.OPACITY.animation({ duration: 200, curve: Curve.EaseInOut }))
    } else if (this.defaultBuilder) {
      this.defaultBuilder()
    }
  }
}