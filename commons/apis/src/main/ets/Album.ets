import { rcpClient, Response } from '../../../Index'
import { GetTopSongResponse } from './Top'

export namespace GetAlbumNewestResponse {
  export interface Data extends Response {
    albums: Array<Album>
  }

  export interface Album {
    name: string
    id: number
    type: string
    size: number
    picId: number
    blurPicUrl: string
    companyId: number
    pic: number
    picUrl: string
    publishTime: number
    description: string
    tags: string
    company: string
    briefDesc: string
    artist: GetTopSongResponse.Artist
    songs: null
    alias: Array<string>
    status: number
    copyrightId: number
    commentThreadId: string
    artists: Array<GetTopSongResponse.Artist>
    paid: boolean
    onSale: boolean
    picId_str: string
  }
}

export function getAlbumNewest(): Promise<GetAlbumNewestResponse.Data> {
  return rcpClient.get<GetAlbumNewestResponse.Data>('album/newest')
}