import { rcpClient, Response } from './RCPClient'

namespace GetBannerResponse {
  export interface Data extends Response {
    banners: Array<Banner>
  }

  export interface Banner {
    imageUrl: string
    targetId: number
    adid: string
    targetType: number
    titleColor: string
    typeTitle: string
    url: string
    exclusive: boolean
    monitorImpress: string
    monitorClick: string
    monitorType: string
    monitorImpressList: boolean
    monitorClickList: boolean
    monitorBlackList: boolean
    extMonitor: string
    extMonitorInfo: string
    adSource: string
    adLocation: string
    adDispatchJson: boolean
    encodeId: string
    program: string
    event: string
    video: string
    song: string
    scm: string
    bannerBizType: string
  }
}

export function getBanner(): Promise<GetBannerResponse.Data> {
  return rcpClient.get<GetBannerResponse.Data>('banner')
}