import rcp from '@hms.collaboration.rcp'
import { BusinessError } from '@kit.BasicServicesKit'
import { ToastUtil } from '@pura/harmony-utils'

interface RequestConfig {
  url: rcp.URLOrString
  method: rcp.HttpMethod
  headers?: rcp.RequestHeaders
  param?: object
  data?: rcp.RequestContent
  configuration?: rcp.Configuration
}

interface GetConfig {
  configuration?: rcp.Configuration
}

interface PostConfig extends GetConfig {
  param?: object
}

export interface Response {
  code: number
}

class RCPClient {
  private session: rcp.Session | undefined
  private static instance: RCPClient

  private constructor() {
  }

  create(config: rcp.SessionConfiguration) {
    config.interceptors = [new Interceptor()]
    if (this.session) {
      this.session.close()
      this.session = undefined
    }
    this.session = rcp.createSession(config)
  }

  static getInstance(): RCPClient {
    if (!RCPClient.instance) {
      RCPClient.instance = new RCPClient()
    }
    return RCPClient.instance
  }

  request<T>(config: RequestConfig): Promise<T> {
    return new Promise((resolve, reject) => {
      const url = encodeURIComponent(`${config.url}${config.param ? this.objectToUrlParams(config.param) : ''}`)
      const request =
        new rcp.Request(url, config.method, config.headers, config.data, undefined, undefined,
          config.configuration)
      this.session!.fetch(request).then(res => {
        resolve(res.toJSON() as T)
      }).catch((err: BusinessError) => {
        reject(err)
      })
    })
  }

  get<T>(url: rcp.URLOrString, param?: object, config?: GetConfig) {
    return this.request<T>({
      url,
      method: 'GET',
      param,
      configuration: config?.configuration,
      headers: { 'content-type': 'application/json' },
    })
  }

  post<T>(url: rcp.URLOrString, data: rcp.RequestContent, config?: PostConfig) {
    return this.request<T>({
      url,
      method: 'POST',
      data,
      param: config?.param,
      configuration: config?.configuration,
      headers: { 'content-type': 'application/json' },
    })
  }

  private objectToUrlParams(params: object) {
    const parts: Array<string> = []
    Object.entries(params).forEach((entry: [string, object]) => {
      parts.push(`${entry[0]}=${entry[1]}`)
    })
    return parts.join('&')
  }
}

class Interceptor implements rcp.Interceptor {
  async intercept(context: rcp.RequestContext, next: rcp.RequestHandler) {
    const res = await next.handle(context)
    const jsonRes = res.toJSON() as Response
    if (jsonRes.code !== 200 || res.statusCode !== 200) {
      ToastUtil.showToast('请求失败')
    }
    return res
  }
}

export const rcpClient = RCPClient.getInstance()