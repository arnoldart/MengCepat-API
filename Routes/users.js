const { default: fastify } = require("fastify");
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

module.exports = ( fastify, opts, done ) => {
  fastify.get('/user', async (req, res) => {
    const allUsers = await prisma.userAccount.findMany({
      include: {
        transactions: { include: { DestinationDetails: true} }
      }
    })
    
    res.code(200)
    res.send(allUsers)
  })

  fastify.post('/user', async (req, res) => {
    const { eCommerceAccount, eCommerceUsername, transactions } = req.body
    const { resi, DestinationDetails } = transactions
    const { CityId, CityName, Province, ProvinceId, type, PostalCode } = DestinationDetails

    const newUser = await prisma.userAccount.create({
      data: {
        eCommerceAccount,
        eCommerceUsername,
        transactions: {
          create: {
            resi,
            DestinationDetails: {
              create: {
                CityId,
                CityName,
                Province,
                ProvinceId,
                type,
                PostalCode
              }
            }
          }
        }
      }
    })

    res.code(200)
    res.send(newUser)

  })

  fastify.post('/user/:id', async (req, res) => {
    const { id } = req.params
    const { eCommerceAccount, eCommerceUsername, transactions } = req.body
    const { resi, DestinationDetails } = transactions
    const { CityId, CityName, Province, ProvinceId, type, PostalCode } = DestinationDetails

    const user = await prisma.userAccount.update({
      where: {
        id: parseInt(id)
      },
      data: {
        transactions: {
          connect: {
            id: parseInt(id)
          },
          create: {
            resi,
            DestinationDetails: {
              create: { 
                CityId,
                CityName,
                Province,
                ProvinceId,
                type,
                PostalCode
              }
            }
          }
        }
      }
    })

    res.status(200)
    res.send(user)

  })

  done()
}