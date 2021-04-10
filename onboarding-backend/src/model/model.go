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

type People struct {
	ID uint            `json:"id"`
	BoatID uint `json:"boatid"`
	Gender string `json:"gender"`
	Scabies uint `json:"scabies"`
	NeedsProtection uint `json:"needs_protection"`
	MedicalCase uint `json:"medical_case"`
	Nationality string `json:"nationality"`
	Age uint `json:"age"`
	AloneTravelingWoman uint `json:"alone_traveling_woman"`
	UnaccompaniedMinor uint `json:"unaccompanied_minor"`
	PregnantWoman uint `json:"pregnant_woman"`
	Temperature uint `json:"temperature"`
}

func (b *People) TableName() string {
	return "people"
}
