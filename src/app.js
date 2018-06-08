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

  /* log incoming queries */
  app.use( (req, res, next) => {
  	req.context = {
  		userId: req.headers["x-bct-user-id"],
  		requestId: req.headers["x-bct-request-id"]
  	}

  	log.info("start_request", { context: {} })
  	next()
  })

  app.use('/', routes)

  app.use( (req, res, next) => {
    log.info("end_request", { context: {} })
    next()
  })

  app.use( (err, req, res, next) => {
    log.error(err, { context: {} })
    res.status(500).json({ code: "UNEXPECTED_ERROR" })
  })

  app.get('*', (req, res) => {
    res.status(404).json({ code: "NOT_FOUND" });
  })

  return app
}
