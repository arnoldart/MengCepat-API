/*
  Warnings:

  - You are about to drop the column `transactionId` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `transactions` table. All the data in the column will be lost.
  - Made the column `Province` on table `DestinationDetails` required. This step will fail if there are existing NULL values in that column.
  - Made the column `type` on table `DestinationDetails` required. This step will fail if there are existing NULL values in that column.
  - Made the column `CityName` on table `DestinationDetails` required. This step will fail if there are existing NULL values in that column.
  - Made the column `eCommerceAccount` on table `UserAccount` required. This step will fail if there are existing NULL values in that column.
  - Made the column `eCommerceUsername` on table `UserAccount` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `TransactionId` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `UserId` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `transactions` DROP FOREIGN KEY `transactions_ibfk_2`;

-- DropForeignKey
ALTER TABLE `transactions` DROP FOREIGN KEY `transactions_ibfk_1`;

-- AlterTable
ALTER TABLE `DestinationDetails` MODIFY `Province` VARCHAR(191) NOT NULL,
    MODIFY `type` VARCHAR(191) NOT NULL,
    MODIFY `CityName` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `UserAccount` MODIFY `eCommerceAccount` VARCHAR(191) NOT NULL,
    MODIFY `eCommerceUsername` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `transactions` DROP COLUMN `transactionId`,
    DROP COLUMN `userId`,
    ADD COLUMN `TransactionId` INTEGER NOT NULL,
    ADD COLUMN `UserId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `SenderProfile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `PhoneNumber` INTEGER,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RecipientProfiles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `PhoneNumber` INTEGER,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Track` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `UserId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`UserId`) REFERENCES `UserAccount`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`TransactionId`) REFERENCES `DestinationDetails`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`TransactionId`) REFERENCES `SenderProfile`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`TransactionId`) REFERENCES `RecipientProfiles`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Track` ADD FOREIGN KEY (`UserId`) REFERENCES `transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
