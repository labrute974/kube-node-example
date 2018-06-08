import express from 'express'

const router = express.Router()

router.get('/quickhealth', (req, res) => {
  res.json({ status: "OK" })
})

router.get('/health', (req, res) => {
  res.json({ status: "OK" })
})

export default router
