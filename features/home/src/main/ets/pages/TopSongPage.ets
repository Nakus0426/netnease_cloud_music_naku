import { Route } from '@hzw/zrouter'

@ComponentV2
@Route({ name: 'home_top_song' })
export struct TopSongPage {
  build() {
    NavDestination() {
      Text('NewSongPage')
    }
  }
}
