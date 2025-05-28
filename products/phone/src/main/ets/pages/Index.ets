import { ZRouter } from '@hzw/zrouter'
import { CollectionPage } from 'collection'
import { ExplorePage } from 'explore'
import { HomePage } from 'home'
import { ProfilePage } from 'profile'
import { TextModifier } from 'styles'
import { AppStore } from 'utils'
import { AppStorageV2 } from '@kit.ArkUI'

interface TabBuilderOptions {
  title: string;
  index: number;
  icon: string;
  selectedIcon: string;
}

@Entry
@ComponentV2
struct Index {
  private tabsController: TabsController = new TabsController()
  private tabTextModifier: TextModifier = new TextModifier({ size: 'mini' })
  @Local currentTabIndex: number = 0
  @Local appStore: AppStore = AppStorageV2.connect(AppStore, () => new AppStore())!
  @Local bottomRectHeight: number = this.appStore.bottomRectHeight
  @Provider() appTabBarHeight: Length = 0

  @Monitor('appStore.bottomRectHeight')
  onBottomRectHeightChange() {
    this.bottomRectHeight = this.appStore.bottomRectHeight
  }

  @Builder
  TabBuilder(options: TabBuilderOptions) {
    Column() {
      Image($r(this.currentTabIndex === options.index ? options.selectedIcon : options.icon))
        .width(24)
      Text($r(options.title))
        .attributeModifier(this.tabTextModifier)
        .fontColor($r(this.currentTabIndex === options.index ? 'app.color.primary_900' : 'app.color.text_2'))
        .margin({ top: 2 })
    }
    .justifyContent(FlexAlign.Center)
    .padding({ top: 12, bottom: this.bottomRectHeight })
    .onClick(() => {
      this.tabsController.changeIndex(options.index)
    })
    .onAreaChange((oldValue, newValue) => {
      this.appTabBarHeight = newValue.height
    })
  }

  build() {
    Stack() {
      Navigation(ZRouter.getNavStack()) {
      }
      .height('100%')
      .width('100%')

      Tabs({ controller: this.tabsController }) {
        TabContent() {
          HomePage()
        }
        .tabBar(this.TabBuilder({
          title: 'app.string.index_tab_title_home',
          index: 0,
          icon: 'app.media.tab_home',
          selectedIcon: 'app.media.tab_home_fill',
        }))

        TabContent() {
          ExplorePage()
        }
        .tabBar(this.TabBuilder({
          title: 'app.string.index_tab_title_explore',
          index: 1,
          icon: 'app.media.tab_explore',
          selectedIcon: 'app.media.tab_explore_fill',
        }))

        TabContent() {
          CollectionPage()
        }
        .tabBar(this.TabBuilder({
          title: 'app.string.index_tab_title_collection',
          index: 2,
          icon: 'app.media.tab_collection',
          selectedIcon: 'app.media.tab_collection_fill',
        }))

        TabContent() {
          ProfilePage()
        }
        .tabBar(this.TabBuilder({
          title: 'app.string.index_tab_title_profile',
          index: 3,
          icon: 'app.media.tab_profile',
          selectedIcon: 'app.media.tab_profile_fill',
        }))
      }
      .width('100%')
      .height('100%')
      .barPosition(BarPosition.End)
      .barMode(BarMode.Fixed)
      .barOverlap(true)
      .barBackgroundColor($r('app.color.background_overlap'))
      .backgroundBlurStyle(BlurStyle.Regular)
      .divider({ strokeWidth: 1, color: $r('app.color.border') })
      .animationMode(AnimationMode.ACTION_FIRST)
      .barHeight('auto')
      .onAnimationStart((index, targetIndex) => {
        this.currentTabIndex = targetIndex
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.base'))
  }
}