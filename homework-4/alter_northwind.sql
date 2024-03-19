-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
alter table products add constraint chk_unit_price check(unit_price > 0);


-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
alter table products add constraint chk_discontinued check (discontinued in (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
create table discontinued_products as
select * from products where discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

-- removing fk
ALTER TABLE order_details DROP FOREIGN KEY fk_order_details_products;

-- deleting
DELETE FROM products WHERE discontinued = 1;

-- restoring fk
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products(product_id)
ON DELETE SET NULL;

--Может лучше сделать вот так? Не понадобится удалять и восстанавливать ограничение, и удаленные товары можно просто фильтровать

ALTER TABLE products ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;
UPDATE products SET is_deleted = TRUE WHERE discontinued = 1;

SELECT * FROM products WHERE is_deleted <> TRUE OR discontinued = 0;
