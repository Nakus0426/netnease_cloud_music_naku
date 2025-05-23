import { harTasks } from '@ohos/hvigor-ohos-plugin'
import { routerRegisterPlugin } from 'router-register-plugin'

export default {
  system: harTasks,
  plugins: [routerRegisterPlugin({
    scanDirs: ['src/main/ets/pages'],
    logEnabled: true,
    viewNodeInfo: false,
    isAutoDeleteHistoryFiles: true
  })]
}
