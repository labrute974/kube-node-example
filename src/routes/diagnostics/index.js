import express from 'express'
import { COMMIT, DEPLOYED_AT } from '../../configs'
import log from '../../utils/logger'

const router = express.Router()

router.get('/quickhealth', (req, res) => {
  res.json({ status: "OK" })
})

router.get('/health', (req, res) => {
  res.status(500).json({
    status: "ERROR",
    services: {
      "service-1": "UP",
      "service-2": "fake_error"
    }
  })
})

router.get('/version', (req, res) => {
  log.info(COMMIT)
  res.json({
    "version": DEPLOYED_AT,
    "commit": COMMIT
  })
})

router.get('/fail', (req, res) => {
  e
})


export default router
