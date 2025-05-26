import { rcpClient, Response } from './RCPClient'

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

export interface GetBannerResponse extends Response {
  banners: Array<Banner>
}

export function getBanner(): Promise<GetBannerResponse> {
  return rcpClient.get<GetBannerResponse>('banner')
}