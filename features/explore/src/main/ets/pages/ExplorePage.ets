@ComponentV2
export struct ExplorePage {
  @Local arr: Color[] =
    [Color.Blue, Color.Brown, Color.Gray, Color.Green, Color.Orange, Color.Pink, Color.Red, Color.Yellow]

  build() {
    Column() {
      List({ initialIndex: 0, space: 20 }) {
        ForEach(this.arr, (item: Color) => {
          ListItem() {
            Rect({ width: '100%', height: 100 })
              .fill(item)
          }
        })
      }
    }
    .height('100%')
  }
}
