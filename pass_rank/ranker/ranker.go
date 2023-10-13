package ranker

import (
	"sort"

	"github.com/magnickolas/alfred_pass/pass_rank/scorer"
)

type Ranker struct {
	Scorer scorer.Scorer
}

func (ranker Ranker) Rank(items []string) []string {
	var rankedItems []string

	if len(ranker.Scorer.Query) > 0 {
		type itemRatio struct {
			item  string
			ratio int
		}

		var itemRatioPairs []itemRatio

		for _, item := range items {
			itemRatioPairs = append(itemRatioPairs, itemRatio{item, ranker.Scorer.Score(item)})
		}

		sort.Slice(itemRatioPairs, func(i, j int) bool {
			return itemRatioPairs[i].ratio > itemRatioPairs[j].ratio
		})

		for _, itemRatioPair := range itemRatioPairs {
			rankedItems = append(rankedItems, itemRatioPair.item)
		}
	}

	return rankedItems
}
