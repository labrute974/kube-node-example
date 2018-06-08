import express from 'express'
import compression from 'compression'
import cors from 'cors'
import body_parser from 'body-parser'
import log from './utils/logger'

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

  	log.info({ context: req.context, message: "start_request" })
  	next()
  })

  app.use( (req, res, next) => {
    log.info({ message: "end_request" })
  })

  app.use( (err, req, res, next) => {
    log.error({ message: "" })
    res.status(500).json({ message: "Server Error" })
  })

  return app
}
