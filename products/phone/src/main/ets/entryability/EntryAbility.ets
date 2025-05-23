import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'
import { ZRouter } from '@hzw/zrouter'
import BuildProfile from 'BuildProfile'
import { AppStorageKey } from '../commons/constants'

const DOMAIN = 0x0000

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
    ZRouter.initialize(config => {
      config.isLoggingEnabled = BuildProfile.DEBUG
    })
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', () => {
      const mainWindow = windowStage.getMainWindowSync()
      mainWindow.setWindowLayoutFullScreen(true)
      const systemAvoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      const navigationIndicatorAvoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      AppStorage.setOrCreate(AppStorageKey.TOP_RECT_HEIGHT, systemAvoidArea.topRect.height)
      AppStorage.setOrCreate(AppStorageKey.BOTTOM_RECT_HEIGHT, navigationIndicatorAvoidArea.bottomRect.height)
      mainWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
          AppStorage.setOrCreate(AppStorageKey.TOP_RECT_HEIGHT, data.area.topRect.height)
        } else if (data.type ===
        window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
          AppStorage.setOrCreate(AppStorageKey.BOTTOM_RECT_HEIGHT, data.area.bottomRect.height)
        }
      })
    })
  }
}