library(regimens)

validdrugs <- regimens::loadDrugs()
regimens <- regimens::loadRegimens(condition = "all")
regGroups <- regimens::loadGroups()

# Table with regimens
head(regimens)
