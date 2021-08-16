-- CreateTable
CREATE TABLE `UserAccount` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `eCommerceAccount` VARCHAR(191),
    `eCommerceUsername` VARCHAR(191),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transactions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `resi` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `transactionId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DestinationDetails` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `CityId` INTEGER NOT NULL,
    `ProvinceId` INTEGER NOT NULL,
    `Province` VARCHAR(191),
    `type` VARCHAR(191),
    `CityName` VARCHAR(191),
    `PostalCode` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`userId`) REFERENCES `UserAccount`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactions` ADD FOREIGN KEY (`transactionId`) REFERENCES `DestinationDetails`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
