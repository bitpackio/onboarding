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
    "os"
    "log"
    "fmt"
    "bufio"
    "strings"
    "strconv"
    "bitpack.io/onboarding/api1"
    "bitpack.io/onboarding/config"
    "bitpack.io/onboarding/model"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
)

var err error

func main() {

    file, err := os.Open("/etc/onboarding/app.env")
    if err != nil {
        log.Fatalf("error while opening file: %s", err)
    }

    scanner := bufio.NewScanner(file)
    scanner.Split(bufio.ScanLines)
    var env []string

    for scanner.Scan() {
        env = append(env, scanner.Text())
    }

    file.Close()

    dbConfig := config.GetDBConfig()
    appConfig := config.GetAppConfig()

    for _, e := range env {

	if strings.HasPrefix(e, "#") {
	    continue
	}

        element := strings.Split(string(e), "=")
        option, value := element[0], element[1]
        //fmt.Println(option + ": " + value)

	switch {
        case option == "POSTGRES_USER":
            dbConfig.User = value
        case option == "POSTGRES_PASSWORD":
            dbConfig.Password = value
        case option == "POSTGRES_DB":
            dbConfig.DBName = value
        case option == "POSTGRES_HOST":
            dbConfig.Host = value
        case option == "POSTGRES_PORT":
	    intValue, err := strconv.Atoi(value)
            if err != nil {
                fmt.Println(err)
                os.Exit(2)
            }
            dbConfig.Port = intValue
        case option == "APP_ADDRESS":
            appConfig.Address = value
        case option == "APP_PORT":
            appConfig.Port = value
        case option == "APP_MODE":
            appConfig.Mode = value
        }
    }

    config.DB, err = gorm.Open(postgres.Open(config.GetDBURL(
        config.GetDBConfig())), &gorm.Config{})

    if err != nil {
        fmt.Println("status: ", err)
    }

    config.DB.AutoMigrate(&model.People{})

    api1 := api1.SetupRouter(appConfig.Mode)
    api1.Run(appConfig.Address + ":" + appConfig.Port)
}
