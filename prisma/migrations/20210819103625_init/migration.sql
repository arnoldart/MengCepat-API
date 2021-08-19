-- DropForeignKey
ALTER TABLE `Track` DROP FOREIGN KEY `Track_ibfk_1`;

-- AddForeignKey
ALTER TABLE `Track` ADD FOREIGN KEY (`TransactionId`) REFERENCES `transactions`(`TransactionId`) ON DELETE CASCADE ON UPDATE CASCADE;
