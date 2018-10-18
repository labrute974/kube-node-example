import express from 'express'
import diagnosticsRoutes from './diagnostics'

const routes = express()

routes.use('/diagnostics', diagnosticsRoutes)

routes.get('/', (req, res) => {
  res.json({ status: "OK" })
})

routes.get('/delay', (req, res) => {
  setTimeout( () => {
    res.json({ status: "OK", delayed: 500 })
  }, 500)
})

export default routes
