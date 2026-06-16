create database cosmetics_store;
use cosmetics_store;
drop database cosmetics_store;
create table users (
    id int auto_increment primary key,
    fullname varchar(100) not null,
    email varchar(100) not null unique,
    password varchar(255) not null
);

create table products (
    id int auto_increment primary key,
    name varchar(100) not null,
    brand varchar(100),
    price decimal(10, 2) not null,
    imageurl varchar(400),
    description varchar(800)
);

create table orders (
    id int auto_increment primary key,
    userid int not null,
    orderdate datetime default current_timestamp,
    totalprice decimal(10, 2) not null,
    foreign key (userid) references users(id) on delete cascade
);

create table orderdetails (
    id int auto_increment primary key,
    orderid int not null,
    productid int not null,
    price decimal(10, 2) not null,
    quantity int not null default 1,
    foreign key (orderid) references orders(id) on delete cascade,
    foreign key (productid) references products(id) on delete restrict
);



insert into users (id, fullname, email, password) values
(1, 'SaraJamal', 'Sara.Jamal11@gmail.com', '11234511'),
(2, 'lamaHadi', 'Lama.Hadi22@gmail.com', '22134522'),
(3, 'LeenAhmad', 'Leen.Ahmad33@gmail.com', '33134533'),
(4, 'samakareem', 'Sama.Kareem44@gmail.com', '44134544');
select * from users;
select * from products;
insert into products (id, name, brand, price, imageurl, description) values
(1, 'Fit Me Matte Foundation', 'Maybelline', 15.00, '/imgs/maybelline_foundation.png', 'Matte + Poreless liquid foundation for oily skin'),
(2, 'Instant Age Rewind Concealer', 'Maybelline', 10.99, '/imgs/maybelline_concealer.png', 'Multi-use eraser dark circles treatment concealer'),
(3, 'Lash Sensational Mascara', 'Maybelline', 12.50, '/imgs/maybelline_mascara.png', 'Full fan effect waterproof volume mascara'),
(4, 'Fit Me Blush', 'Maybelline', 8.50, '/imgs/maybelline_blush.png', 'Lightweight powder blush for a natural glow'),
(5, 'The Nudes Eyeshadow Palette', 'Maybelline', 13.99, '/imgs/maybelline_liquid eyeshadow.png', '12-shade palette with matte and shimmer finishes'),
(6, 'SuperStay Matte Ink Lipstick', 'Maybelline', 11.49, '/imgs/maybelline_lipstick.png', 'Long-lasting saturated liquid matte lipstick'),
(7, 'All Hours Foundation', 'YSL', 62.00, '/imgs/ysl_foundation.png', 'Full coverage matte foundation with 24h wear'),
(8, 'Touche Éclat Radiant Concealer', 'YSL', 40.00, '/imgs/ysl_concealer.png', 'Iconic brightening pen concealer and highlighter'),
(9, 'Lash Clash Extreme Volume Mascara', 'YSL', 29.00, '/imgs/ysl_mascara.png', 'Oversized volumizing mascara with an intense black finish'),
(10, 'Nu Lip & Cheek Tint Blush', 'YSL', 28.00, '/imgs/ysl_blush.png', 'Creamy liquid blush for a flushed, dewy look'),
(11, 'Couture Clutch Eyeshadow Palette', 'YSL', 75.00, '/imgs/ysl_eyeshadow.png', 'Luxury eyeshadow palette with rich couture colors'),
(12, 'Rouge Pur Couture Lipstick', 'YSL', 45.00, '/imgs/ysl_lipstick.png', 'Satin finish hydrating lipstick with rich pigment'),
(13, 'FauxFilter Luminous Matte Foundation', 'Huda Beauty', 42.00, '/imgs/hudabeauty_foundation.png', 'Full coverage transfer-proof liquid foundation'),
(14, 'The Overachiever Concealer', 'Huda Beauty', 30.00, '/imgs/hudabeauty_concealer.png', 'High coverage creamy concealer to disguise dark circles'),
(15, '1 Coat Wow! Mascara', 'Huda Beauty', 23.00, '/imgs/hudabeauty_mascara.png', 'Instant extra volume and lifted curl mascara'),
(16, 'Cheeky Tint Blush Stick', 'Huda Beauty', 27.00, '/imgs/hudabeauty_blush.png', 'Buildable moisturizing cream blush stick'),
(17, 'Empowered Eyeshadow Palette', 'Huda Beauty', 69.00, '/imgs/hudabeauty_eyeshadow.png', 'Ultimate everyday palette with gold and earthy tones'),
(18, 'Liquid Matte Lipstick', 'Huda Beauty', 23.00, '/imgs/hudabeauty_lipstick.png', 'Comfortable, weightless and flake-free liquid lipstick');
