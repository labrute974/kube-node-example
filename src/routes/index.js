import express from 'express'
import diagnosticsRoutes from './diagnostics'

const routes = express()

routes.use('/diagnostics', diagnosticsRoutes)

routes.get('/', (req, res) => {
  res.json({ status: "OK" })
})

export default routes
