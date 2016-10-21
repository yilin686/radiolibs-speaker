joi = require 'joi'
_ = require 'lodash'
express = require '../express'
validate = require '../../utils/validate'
HardWare = require '../../core/models/hardWare'

module.exports = router = express.Router()

router.get '/:hw/channels.txt', (req, res) ->
  #获取channels文件

router.get '/:hw/config.txt', (req, res) ->
  #获取config文件

router.patch '/:hw/status', (req, res, next) ->
  #更新硬件status属性值
  HardWare
    .update req.ctx.hardWare.id, status: req.body
    .then (hardWare) ->
      #其他操作
    .catch next

router.patch '/:hw/ls', (req, res, next) ->
  #更新硬件ls属性值
  HardWare
    .update req.ctx.hardWare.id, ls: req.body
    .then (hardWare) ->
      #其他操作
    .catch next
