import express from 'express'
import compression from 'compression'
import cors from 'cors'
import body_parser from 'body-parser'
import log from './utils/logger'
import routes from './routes'

export default () => {
  const app = express()

  app.use( cors() )
  app.use( compression() )
  app.use( body_parser.json({ limit: '50mb' }) )

  app.use('/', routes)

  app.use( (err, req, res, next) => {
    log.error("UNEXPECTED_ERROR", { error: { message: err.message, name: err.name, stack: er.stack } })
    res.status(500).json({ code: "UNEXPECTED_ERROR" })
  })

  app.get('*', (req, res) => {
    res.status(404).json({ code: "NOT_FOUND" });
  })

  return app
}
