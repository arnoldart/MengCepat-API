const { default: fastify } = require("fastify");
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

module.exports = ( fastify, opts, done ) => {
  fastify.get('/user', (req, res) => {
    async function main() {
      // await prisma.userAccount.create({
      //   data: {
      //     eCommerceAccount: "arnold@gmail.com",
      //     eCommerceUsername: "arnold",
      //     transactions: {
      //       create: {
      //         resi: 9080928,
      //         DestinationDetails: {
      //           create: {
      //             CityId: 912837,
      //             CityName: 'Jogjakarta',
      //             Province: "Jogjakarta",
      //             ProvinceId: 123,
      //             type: "city",
      //             PostalCode: 14998,
      //           }
      //         }
      //       }
      //     }
      //   }
      // })
    
      const allUsers = await prisma.userAccount.findMany({
        include: {
          transactions: { include: { DestinationDetails: true} }
        }
      })
    
      res.send(allUsers)
    }
    
    main()
      .catch((e) => {
        throw e
      })
      .finally(async () => {
        await prisma.$disconnect
      })

  })
  done()
}