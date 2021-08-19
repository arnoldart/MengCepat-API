/*
  Warnings:

  - You are about to drop the column `UserId` on the `Track` table. All the data in the column will be lost.
  - You are about to drop the column `UserId` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `TransactionId` to the `Track` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Track` DROP FOREIGN KEY `Track_ibfk_1`;

-- DropForeignKey
ALTER TABLE `transactions` DROP FOREIGN KEY `transactions_ibfk_1`;

-- AlterTable
ALTER TABLE `Track` DROP COLUMN `UserId`,
    ADD COLUMN `TransactionId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `transactions` DROP COLUMN `UserId`;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`TransactionId`) REFERENCES `UserAccount`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Track` ADD FOREIGN KEY (`TransactionId`) REFERENCES `transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
