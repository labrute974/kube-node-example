import winston from 'winston'
import { APP_NAME, ENVIRONMENT, PROJECT } from '../configs'

const winstonLogger = winston.createLogger({
  format: winston.format.json(),
  exitOnError: false,
  handleExceptions: true,
  transports: [
    new (winston.transports.Console)({ level: 'info' })
  ],
})

const log = (message, { level, request, ...obj } = {}) => {
  let formatted = { level, message, ...obj, }

  if (request) {
    const {
      path,
      body,
      query,
      params,
    } = request;

    formatted = {
      ...formatted,
      request: {
        path,
        body,
        query,
        params,
      },
    }
  }

  formatted = {
    ...formatted,
    level,
    project: PROJECT,
    application: APP_NAME,
    environment: ENVIRONMENT,
    datetime: (new Date()).toISOString(),
  }

  winstonLogger.log(formatted)
}

export const info = (message, obj) => log(message, {
  level: 'info',
  ...obj,
})

export const error = (message, obj) => log(message, {
  level: 'error',
  ...obj,
})

export default { info, error }
