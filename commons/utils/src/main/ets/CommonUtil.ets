import dayjs from 'dayjs'
import { get } from './ObjectUtil'

export interface GroupByTimeReturn<T> {
  today: Array<T>
  yesterday: Array<T>
  lastWeek: Array<T>
  earlier: Array<T>
}

/**
 * 按照时间将数据分组
 * @param data 要分组的数据数组
 * @param timePath 数据项中时间字段的路径，可以是字符串或字符串数组
 * @returns {GroupByTimeReturn<T>} 返回分组后的对象，包含以下属性:
 *   - today: 今天的数据项数组
 *   - yesterday: 昨天的数据项数组
 *   - lastWeek: 上周(过去7天内)的数据项数组
 *   - earlier: 更早之前的数据项数组
 */
export function groupByTime<T>(data: Array<T>, timePath: string | Array<string>) {
  const today: Array<T> = []
  const yesterday: Array<T> = []
  const lastWeek: Array<T> = []
  const earlier: Array<T> = []
  const now = dayjs()
  const todayStart = now.startOf('day')
  const yesterdayStart = now.subtract(1, 'day').startOf('day')
  const lastWeekStart = now.subtract(7, 'day').startOf('day')
  data.forEach(item => {
    const time = dayjs(get(item as object, timePath))
    if (time.isSame(todayStart, 'day')) {
      today.push(item)
    } else if (time.isSame(yesterdayStart, 'day')) {
      yesterday.push(item)
    } else if (time.isAfter(lastWeekStart)) {
      lastWeek.push(item)
    } else {
      earlier.push(item)
    }
  })
  return {
    today,
    yesterday,
    lastWeek,
    earlier,
  } as GroupByTimeReturn<T>
}