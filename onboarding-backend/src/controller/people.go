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

package controller

import (
	"fmt"
	"net/http"
	//"model"
        "github.com/bitpackio/onboarding/model"
	"github.com/gin-gonic/gin"
)

func Get(c *gin.Context) {
	var people []model.People
	err := model.Get(&people)
	fmt.Println(people)
	if err != nil {
		c.AbortWithStatus(http.StatusNotFound)
	} else {
		c.JSON(http.StatusOK, people)
	}
}

func Create(c *gin.Context) {
	var people model.People
	c.BindJSON(&people)
	err := model.Create(&people)
	fmt.Println(people)
	if err != nil {
		c.AbortWithStatus(http.StatusNotFound)
	} else {
		c.JSON(http.StatusOK, people)
	}
}

func Read(c *gin.Context) {
	id := c.Params.ByName("id")
	var people model.People
	err := model.Read(&people, id)
	if err != nil {
		c.AbortWithStatus(http.StatusNotFound)
	} else {
		c.JSON(http.StatusOK, people)
	}
}

func Update(c *gin.Context) {
	var people model.People
	id := c.Params.ByName("id")
	err := model.Read(&people, id)
	if err != nil {
		c.JSON(http.StatusNotFound, people)
	}
	c.BindJSON(&people)
	err = model.Update(&people, id)
	if err != nil {
		c.AbortWithStatus(http.StatusNotFound)
	} else {
		c.JSON(http.StatusOK, people)
	}
}

func Delete(c *gin.Context) {
	var people model.People
	id := c.Params.ByName("id")
	err := model.Delete(&people, id)
	if err != nil {
		c.AbortWithStatus(http.StatusNotFound)
	} else {
		c.JSON(http.StatusOK, gin.H{"id:" + id: "deleted"})
	}
}
