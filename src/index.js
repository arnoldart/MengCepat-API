const fastify = require('fastify') ({ logger: true })

fastify.get('/', async (req, res) => {
  res.send({ hello: 'world' })
})

fastify.register(require('../Routes/users'), { prefix: '/v1' })

const start = async () => {
  try {
    await fastify.listen(3000)
  } catch (err) {
    fastify.log.error(err)
    process.exit(1)
  }
}

start()
