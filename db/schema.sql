create extension if not exists "uuid-ossp";

CREATE TABLE base_table (
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);
CREATE TABLE users (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
) INHERITS (base_table);
CREATE TABLE items (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    notes TEXT,
    seller_id uuid,
    FOREIGN KEY (seller_id) REFERENCES users (id) ON DELETE CASCADE,
    price INTEGER
) INHERITS (base_table);
CREATE TABLE purchases (
    id uuid PRIMARY KEY default uuid_generate_v4(),
    buyer_id uuid,
    FOREIGN KEY (buyer_id) REFERENCES users (id),
    item_id uuid,
    FOREIGN KEY (item_id) REFERENCES items (id),
    price INTEGER,
    title VARCHAR(255) NOT NULL
) INHERITS (base_table);