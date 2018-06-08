import express from 'express'
import diagnosticsRoutes from './diagnostics'

const routes = express()

routes.use('/diagnostics', diagnosticsRoutes)

export default routes
