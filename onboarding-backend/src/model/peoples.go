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

package model

import (
	"fmt"
        "bitpack.io/onboarding/config"
)

func Get(people *[]People) (err error) {
	if err = config.DB.Find(people).Error; err != nil {
		return err
	}
	return nil
}

func Create(people *People) (err error) {
	if err = config.DB.Create(people).Error; err != nil {
		return err
	}
	return nil
}

func Read(people *People, id string) (err error) {
	if err := config.DB.Where("id = ?", id).First(people).Error; err != nil {
		return err
	}
	return nil
}

func Update(people *People, id string) (err error) {
	fmt.Println(people)
	config.DB.Save(people)
	return nil
}

func Delete(people *People, id string) (err error) {
	config.DB.Where("id = ?", id).Delete(people)
	return nil
}
