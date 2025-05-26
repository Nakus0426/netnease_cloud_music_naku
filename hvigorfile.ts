import { appTasks } from '@ohos/hvigor-ohos-plugin'
import * as sign from './sign.json'

export default {
  system: appTasks,
  plugins: [],
  ohos: {
    overrides: {
      signingConfig: getSigningConfig(), //签名配置对象
      appOpt: {
        versionCode: getVersionCode(),
        versionName: getVersionName(),
      }
    }
  }
}

function getSigningConfig() {
  return {
    type: 'HarmonyOS',
    material: {
      certpath: sign.certpath,
      storePassword: sign.storePassword,
      keyAlias: sign.keyAlias,
      keyPassword: sign.keyPassword,
      profile: sign.profile,
      signAlg: sign.signAlg,
      storeFile: sign.storeFile
    }
  }
}

function getVersionCode() {
  return 100000
}

function getVersionName() {
  return '1'
}
