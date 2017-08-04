stateinfo = read.csv("./stateData.csv")

state.subset = subset(stateinfo, state.region == 1)
state.subsetbkt = stateinfo[stateinfo$state.region == 1,]

state.subset == state.subsetbkt

head(state.subset)
dim(state.subset)
str(state.subset)

state.aboveAverageMurder = subset(stateinfo, murder > mean(stateinfo$murder))
