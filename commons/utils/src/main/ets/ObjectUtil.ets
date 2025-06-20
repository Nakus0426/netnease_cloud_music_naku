/**
 * 从对象中根据路径获取值
 * @param object 要查询的对象
 * @param path 访问路径，可以是字符串(用'.'分隔)或路径数组
 * @param defaultValue 如果路径不存在时返回的默认值
 * @returns 路径对应的值或默认值
 */
export function get<T>(object: object, path: string | Array<string>, defaultValue?: T): T {
  if (object === null) {
    return defaultValue as T
  }
  if (typeof path === 'string') {
    return get(object, path.split('.'), defaultValue)
  }
  if (Array.isArray(path)) {
    if (path.length === 0) {
      return object as T
    }
    const currentKey = path.shift() as string
    if (Reflect.has(object, currentKey)) {
      return get(Reflect.get(object, currentKey), path, defaultValue)
    }
  }
  return defaultValue as T
}
