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

package main

import (
    "fmt"
    "bitpack.io/onboarding/api1"
    "bitpack.io/onboarding/config"
    "bitpack.io/onboarding/model"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
)

var err error

func main() {

    config.DB, err = gorm.Open(postgres.Open(config.GetDBURL(
        config.GetDBConfig())), &gorm.Config{})

    if err != nil {
        fmt.Println("status: ", err)
    }

    config.DB.AutoMigrate(&model.People{})

    api1 := api1.SetupRouter()
    api1.Run()
}
