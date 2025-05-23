import { ZRouter } from '@hzw/zrouter'
import { CollectionPage } from 'collection'
import { ExplorePage } from 'explore'
import { HomePage } from 'home'
import { ProfilePage } from 'profile'
import { TextModifier } from 'styles'
import { AppStorageKey } from '../commons/constants'

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0
  private tabsController: TabsController = new TabsController()
  private tabTextModifier: TextModifier = new TextModifier('small')
  @StorageProp(AppStorageKey.TOP_RECT_HEIGHT)
  topRectHeight: number = 0

  @Builder
  TabBuilder(title: string, index: number, icon: string, selectedIcon: string) {
    Column() {
      Image($r(this.currentTabIndex === index ? selectedIcon : icon))
        .width(24)
      Text($r(title))
        .fontColor($r(this.currentTabIndex === index ? 'app.color.primary_900' : 'app.color.text_2'))
        .attributeModifier(this.tabTextModifier)
        .margin({ top: 2 })
    }
    .height(64)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.tabsController.changeIndex(index)
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
        .tabBar(this.TabBuilder('app.string.index_tab_title_home', 0, 'app.media.tab_home', 'app.media.tab_home_fill'))


        TabContent() {
          ExplorePage()
        }
        .tabBar(this.TabBuilder('app.string.index_tab_title_explore', 1, 'app.media.tab_explore',
          'app.media.tab_explore_fill'))

        TabContent() {
          CollectionPage()
        }
        .tabBar(this.TabBuilder('app.string.index_tab_title_collection', 2, 'app.media.tab_collection',
          'app.media.tab_collection_fill'))

        TabContent() {
          ProfilePage()
        }
        .tabBar(this.TabBuilder('app.string.index_tab_title_profile', 3, 'app.media.tab_profile',
          'app.media.tab_profile_fill'))
      }
      .width('100%')
      .height('100%')
      .barPosition(BarPosition.End)
      .barMode(BarMode.Fixed)
      .barOverlap(true)
      .barBackgroundColor($r('app.color.background_color_overlap'))
      .backgroundBlurStyle(BlurStyle.Regular)
      .divider({ strokeWidth: 1, color: $r('app.color.border') })
      .animationMode(AnimationMode.ACTION_FIRST)
      .onAnimationStart((index, targetIndex) => {
        this.currentTabIndex = targetIndex
      })
    }
    .width('100%')
    .height('100%')
  }
}