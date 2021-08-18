-- CreateTable
CREATE TABLE `TrackDetail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Oclock` INTEGER NOT NULL,
    `Location` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Track` ADD FOREIGN KEY (`UserId`) REFERENCES `TrackDetail`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
