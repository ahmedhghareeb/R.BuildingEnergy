test = function(bldgs, usage) {
  bldg.ID = bldgs[,"BuildingID"]
  bldg.Usage = usage[usage$BuildingID==bldg.ID[1],]
  return(bldg.Usage)
}