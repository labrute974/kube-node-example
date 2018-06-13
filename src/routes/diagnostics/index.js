import express from 'express'
import { COMMIT, VERSION } from '../../configs'

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
  res.json({
    "version": VERSION,
    "commit": COMMIT
  })
})

router.get('/fail', (req, res) => {
  e
})


export default router
