import { ImageKnifeComponentV2 } from '@ohos/imageknife'
import { getBanner } from 'apis'
import uiEffect from '@ohos.graphics.uiEffect'

@ComponentV2
export struct Banner {
  @Local banners: Array<string> = []
  @Local opacityList: Array<number> = []
  @Local scaleList: Array<number> = []
  @Local translateList: Array<number> = []
  @Local zIndexList: Array<number> = []
  private swiperController = new SwiperController()
  private indicatorController = new IndicatorComponentController()
  private MIN_SCALE = 0.75
  private DISPLAY_COUNT = 1

  aboutToAppear() {
    this.init()
  }

  async init() {
    const res = await getBanner()
    this.banners = res.banners.map(item => item.imageUrl)
    this.banners.forEach(() => {
      this.opacityList.push(1.0)
      this.scaleList.push(1.0)
      this.translateList.push(0.0)
      this.zIndexList.push(0)
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        Rect()
          .width(290)
          .height(10)
          .fill($r('app.color.primary_900'))
          .opacity(0.45)
          .foregroundFilter(uiEffect.createFilter().blur(60))

        Swiper(this.swiperController) {
          ForEach(this.banners, (item: string, index) => {
            ImageKnifeComponentV2({
              imageKnifeOption: {
                loadSrc: item,
                border: { radius: 15 },
                placeholderSrc: $r('app.media.image_placeholder'),
                placeholderObjectFit: ImageFit.Cover,
              },
            })
              .width('100%')
              .margin({ left: 24, right: 24 })
              .opacity(this.opacityList[index])
              .scale({ x: this.scaleList[index], y: this.scaleList[index] })
              .translate({ x: this.translateList[index] })
              .zIndex(this.zIndexList[index])
          })
        }
        .width('100%')
        .height(130)
        .indicator(this.indicatorController)
        .autoPlay(true)
        .interval(10000)
        .customContentTransition({
          timeout: 1000,
          transition: (proxy: SwiperContentTransitionProxy) => {
            if (proxy.position <= proxy.index % this.DISPLAY_COUNT ||
              proxy.position >= this.DISPLAY_COUNT + proxy.index % this.DISPLAY_COUNT) {
              this.opacityList[proxy.index] = 1.0
              this.scaleList[proxy.index] = 1.0
              this.translateList[proxy.index] = 0.0
              this.zIndexList[proxy.index] = 0
            } else {
              if (proxy.index % this.DISPLAY_COUNT === 0) {
                this.opacityList[proxy.index] = 1 - proxy.position / this.DISPLAY_COUNT
                this.scaleList[proxy.index] =
                  this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - proxy.position / this.DISPLAY_COUNT)
                this.translateList[proxy.index] =
                  -proxy.position * proxy.mainAxisLength +
                    (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
              } else {
                this.opacityList[proxy.index] = 1 - (proxy.position - 1) / this.DISPLAY_COUNT
                this.scaleList[proxy.index] =
                  this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - (proxy.position - 1) / this.DISPLAY_COUNT)
                this.translateList[proxy.index] = -(proxy.position - 1) * proxy.mainAxisLength -
                  (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
              }
              this.zIndexList[proxy.index] = -1
            }
          },
        })
      }

      IndicatorComponent(this.indicatorController)
        .style(new DotIndicator()
          .itemWidth(8)
          .itemHeight(8)
          .selectedItemWidth(8)
          .selectedItemHeight(8)
          .color($r('app.color.primary_500'))
          .selectedColor($r('app.color.primary_900')),
        )
    }
    .padding({ bottom: 10 })
  }
}