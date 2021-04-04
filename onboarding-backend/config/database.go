//
// Copyright (C) 2021 bitpack.io <hello@bitpack.io>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License at <http://www.gnu.org/licenses/> for
// more details.
//
// See LICENSE.txt for detailed license information.

package config

import (
    "fmt"
    "gorm.io/gorm"
)

var DB *gorm.DB

type DBConfig struct {
    Host     string
    Port     int
    User     string
    DBName   string
    Password string
}

func GetDBConfig() *DBConfig {
    db := DBConfig{
    Host:     "127.0.0.1",
    Port:     5432,
    User:     "postgres",
    DBName:   "app-onboarding-1",
    Password: "postgres",
    }
    return &db
}

func GetDBURL(db *DBConfig) string {
    return fmt.Sprintf(
        "host=%s user=%s password=%s port=%d dbname=%s sslmode=disable TimeZone=Europe/Berlin",
        db.Host,
        db.User,
        db.Password,
        db.Port,
        db.DBName,
    )
}

