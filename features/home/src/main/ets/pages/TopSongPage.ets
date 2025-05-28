import { Route } from '@hzw/zrouter'
import { Routes } from 'utils'

@ComponentV2
@Route({ name: Routes.HOME_TOP_SONG })
export struct TopSongPage {
  build() {
    NavDestination() {
      Text('NewSongPage')
    }
  }
}
