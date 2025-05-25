import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { AppStorageV2, window } from '@kit.ArkUI'
import { ZRouter } from '@hzw/zrouter'
import BuildProfile from 'BuildProfile'
import { AppStore } from 'utils'
import { AppUtil, WindowUtil } from '@pura/harmony-utils'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
    AppUtil.init(this.context)
    ZRouter.initialize(config => {
      config.isLoggingEnabled = BuildProfile.DEBUG
    })
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', () => {
      WindowUtil.setWindowLayoutFullScreen(true)
      const systemAvoidArea = WindowUtil.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      const navigationIndicatorAvoidArea =
        WindowUtil.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      const appStore = AppStorageV2.connect(AppStore, () => new AppStore())!
      appStore.topRectHeight = px2vp(systemAvoidArea.topRect.height)
      appStore.bottomRectHeight = px2vp(navigationIndicatorAvoidArea.bottomRect.height)
      AppUtil.getMainWindow().on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
          appStore.topRectHeight = px2vp(data.area.topRect.height)
        } else if (data.type ===
        window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
          appStore.bottomRectHeight = px2vp(data.area.bottomRect.height)
        }
      })
    })
  }
}