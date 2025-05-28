import { rcpClient, Response } from '../../../Index'

export namespace GetTopSongResponse {
  export interface Data extends Response {
    data: Array<TopSong>
  }

  export interface TopSong {
    starred: boolean
    popularity: number
    starredNum: number
    playedNum: number
    dayPlays: number
    hearTime: number
    albumData: null
    mp3Url: string
    rtUrls: null
    privilege: Privilege
    videoInfo: null
    relatedVideo: null
    st: number
    exclusive: boolean
    artists: Array<Artist>
    album: Album
    fee: number
    commentThreadId: string
    hMusic: Music
    mMusic: Music
    lMusic: Music
    mvid: number
    score: number
    rtype: number
    rurl: null
    copyrightId: number
    disc: string
    no: number
    ringtone: string
    crbt: null
    bMusic: Music
    audition: null
    copyFrom: string
    rtUrl: null
    ftype: number
    position: number
    duration: number
    status: number
    alias: Array<string>
    name: string
    id: number
  }

  export interface Privilege {
    id: number
    fee: number
    payed: number
    st: number
    pl: number
    dl: number
    sp: number
    cp: number
    subp: number
    cs: boolean
    maxbr: number
    fl: number
    toast: boolean
    flag: number
    preSell: boolean
    playMaxbr: number
    downloadMaxbr: number
    maxBrLevel: string
    playMaxBrLevel: string
    downloadMaxBrLevel: string
    plLevel: string
    dlLevel: string
    flLevel: string
    rscl: null
    freeTrialPrivilege: FreeTrialPrivilege
    rightSource: number
    chargeInfoList: Array<ChargeInfoList>
  }

  export interface FreeTrialPrivilege {
    resConsumable: boolean
    userConsumable: boolean
    listenType: number
    cannotListenReason: number
    playReason: null
  }

  export interface ChargeInfoList {
    rate: number
    chargeUrl: null
    chargeMessage: null
    chargeType: number
  }

  export interface Artist {
    img1v1Id: number
    topicPerson: number
    followed: boolean
    briefDesc: string
    picId: number
    picUrl: string
    musicSize: number
    albumSize: number
    img1v1Url: string
    trans: string
    alias: Array<string>
    name: string
    id: number
    img1v1Id_str: string
  }

  export interface Album {
    songs: null
    paid: boolean
    onSale: boolean
    artists: Array<Artist>
    briefDesc: string
    picId: number
    publishTime: number
    picUrl: string
    commentThreadId: string
    copyrightId: number
    artist: Artist
    company: string
    subType: string
    blurPicUrl: string
    companyId: number
    pic: number
    status: number
    description: string
    alias: Array<string>
    tags: string
    name: string
    id: number
    type: string
    size: number
    picId_str: string
  }

  export interface Music {
    volumeDelta: number
    playTime: number
    bitrate: number
    dfsId: number
    sr: number
    name: null
    id: number
    size: number
    extension: string
  }
}

export function getTopSong(type: 0 | 7 | 96 | 8 | 16 = 0): Promise<GetTopSongResponse.Data> {
  return rcpClient.get<GetTopSongResponse.Data>('top/song', new Object({ type }))
}