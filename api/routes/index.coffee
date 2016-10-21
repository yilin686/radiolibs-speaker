express = require '../express'
middlewares = require './middlewares'

module.exports = router = express.Router()

# 统一处理参数
router.use '/speaker/:hw', middlewares.parseHardWare

# 路由
router.use '/speaker', require './hardWares'
router.use '/speaker', require './synces'
