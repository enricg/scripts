# script
#!/bin/bash
######################################################################
#Copyright (C) 2025  Kris Occhipinti
#https://filmsbykris.com

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation version 3 of the License.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
######################################################################

for i in *.jpg; do
  gps="$(exiftool -c "%.6f" -location:all "$i" | grep "GPS Position" | cut -d\: -f2)"
  [[ $gps ]] || continue
  url="https://nominatim.openstreetmap.org/search?q=${gps}&format=json&polygon=1&addressdetails=1"
  location="$(wget -qO- "$url" | jq -r '.[]|.display_name + "|" + .lat + "," + .lon' | head -n 1)"
  echo "$i|$location"
  sleep 1
done | tee photo_location.csv
