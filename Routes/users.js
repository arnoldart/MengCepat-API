const { default: fastify } = require("fastify");
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

module.exports = ( fastify, opts, done ) => {
  fastify.get('/user', async (req, res) => {
    const allUsers = await prisma.userAccount.findMany({
      include: {
        transactions: { 
          include: { 
            DestinationDetails: true,
            SenderProfile: true,
            RecipientProfiles: true,
            Track: true
          } 
        }
      }
    })
    
    res.code(200)
    res.send(allUsers)
  })

  fastify.post('/user', async (req, res) => {
    const { eCommerceAccount, eCommerceUsername, transactions } = req.body
    const { resi, DestinationDetails, SenderProfile, RecipientProfiles, Track } = transactions
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
            },
            SenderProfile: {
              create: {
                name: "asdadads",
                address: "aoidjaoisdj",
                PhoneNumber: 203942304
              }
            },
            RecipientProfiles: {
              create: {
                name: "iosdfijsoi",
                PhoneNumber: 2039847
              }
            },
            Track: {
              create: {
                Oclock: 12.00,
                Location: "Jakarta"
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
    const { resi, DestinationDetails, SenderProfile, RecipientProfiles, Track } = transactions
    const { CityId, CityName, Province, ProvinceId, type, PostalCode } = DestinationDetails
    const { name, address, PhoneNumber } = SenderProfile
    const { Oclock, Location } = Track

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
            },
            SenderProfile: {
              create: {
                name,
                address,
                PhoneNumber
              }
            },
            RecipientProfiles: {
              create: {
                name: RecipientProfiles.name,
                PhoneNumber: RecipientProfiles.PhoneNumber
              }
            },
            Track: {
              create: {
                Oclock,
                Location
              }
            }
          }
        }
      }
    })

    res.status(200)
    res.send(user)

  })

  fastify.post('/user/track/:id', async (req, res) => {
    const { id } = req.params
    const { eCommerceAccount, eCommerceUsername, transactions } = req.body
    const { resi, DestinationDetails, SenderProfile, RecipientProfiles, Track } = transactions
    const { CityId, CityName, Province, ProvinceId, type, PostalCode } = DestinationDetails
    const { name, address, PhoneNumber } = SenderProfile
    const { Oclock, Location } = Track
    
    const UpdateTrack = await prisma.transactions.update({
      where: {
        id: parseInt(id)
      },
      data: {
        Track: {
          connect: {
            id: parseInt(id)
          },
          create: {
            Oclock,
            Location
          }
        }
      }
    })

    res.status(200)
    res.send(UpdateTrack)

  })

  done()
}