package scorer

import (
	"strings"

	"github.com/ktr0731/go-fuzzyfinder/scoring"
)

type Scorer struct {
	Query string
}

func (scorer Scorer) calcSmithWatermanScore(item string) (score int) {
	if len(scorer.Query) <= len(item) {
		score, _ = scoring.Calculate(item, scorer.Query)
	}
	return
}

func (scorer Scorer) containsQueryBoost(item string) (boost float32) {
	index := strings.Index(item, scorer.Query)
	boost = 1.0
	if index == 0 {
		boost = 2.0
	} else if index > 0 {
		boost = 1.5
	}
	return
}

func (scorer Scorer) Score(item string) (score int) {
	score = scorer.calcSmithWatermanScore(item)
	score = int(float32(score) * scorer.containsQueryBoost(item))
	return score
}
