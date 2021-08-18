/*
  Warnings:

  - You are about to drop the `TrackDetail` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `Location` to the `Track` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Oclock` to the `Track` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Track` DROP FOREIGN KEY `Track_ibfk_2`;

-- AlterTable
ALTER TABLE `Track` ADD COLUMN `Location` VARCHAR(191) NOT NULL,
    ADD COLUMN `Oclock` INTEGER NOT NULL;

-- DropTable
DROP TABLE `TrackDetail`;
