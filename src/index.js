import { PORT } from './configs'
import log from './utils/logger'
import createServer from './app'

const app = createServer()
app.listen(PORT, () => log.info(`API Server Running on port ${PORT}`))
