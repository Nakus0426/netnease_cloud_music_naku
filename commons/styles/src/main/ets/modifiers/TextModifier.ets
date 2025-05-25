type Size = 'mini' | 'small' | 'medium' | 'large' | 'h1' | 'h2' | 'h3' | 'h4'
type Depth = 1 | 2 | 3

interface Options {
  size?: Size,
  depth?: Depth
}

export class TextModifier implements AttributeModifier<TextAttribute> {
  private size: Size = 'medium'
  private depth: Depth = 2
  private readonly fontSizeMap: Map<Size, Resource> = new Map([
    ['mini', $r('app.string.font_size_mini')],
    ['small', $r('app.string.font_size_small')],
    ['medium', $r('app.string.font_size_medium')],
    ['large', $r('app.string.font_size_large')],
    ['h1', $r('app.string.font_size_h1')],
    ['h2', $r('app.string.font_size_h2')],
    ['h3', $r('app.string.font_size_h3')],
    ['h4', $r('app.string.font_size_h4')],
  ])
  private readonly lineHeightMap: Map<Size, Resource> = new Map([
    ['small', $r('app.string.line_height_small')],
    ['medium', $r('app.string.line_height_medium')],
    ['large', $r('app.string.line_height_large')],
    ['h1', $r('app.string.line_height_h1')],
    ['h2', $r('app.string.line_height_h2')],
    ['h3', $r('app.string.line_height_h3')],
    ['h4', $r('app.string.line_height_h4')]
  ])
  private readonly depthMap: Map<Depth, Resource> = new Map([
    [1, $r('app.color.text_1')],
    [2, $r('app.color.text_2')],
    [3, $r('app.color.text_3')]
  ])

  constructor(options: Options) {
    this.size = options.size || 'medium'
    this.depth = options.depth || 2
  }

  applyNormalAttribute(instance: TextAttribute) {
    instance.fontSize(this.fontSizeMap.get(this.size))
    instance.lineHeight(this.lineHeightMap.get(this.size))
    instance.fontColor(this.depthMap.get(this.depth))
    instance.fontWeight(this.size.startsWith('h') ? FontWeight.Bold : FontWeight.Normal)
  }
}