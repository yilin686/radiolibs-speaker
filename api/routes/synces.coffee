_ = require 'lodash'
express = require '../express'
Sync = require '../../core/models/sync'

module.exports = router = express.Router()

router.get '/:hw/sync.text', (req, res, next) ->
  #创建sync纪录并返回sync.text

router.patch '/:hw/sync-result', (req, res, next) ->
  Sync
    .update req.ctx.hardWare.id, result: req.body
    .then (sync) ->
      #其他操作
    .catch next

