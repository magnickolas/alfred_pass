package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/magnickolas/alfred_pass/pass_rank/config"
	"github.com/magnickolas/alfred_pass/pass_rank/fs"
	"github.com/magnickolas/alfred_pass/pass_rank/ranker"
	"github.com/magnickolas/alfred_pass/pass_rank/scorer"
	"github.com/magnickolas/alfred_pass/pass_rank/utils"
)

func main() {
	query := strings.ToLower(os.Args[1])
	passwords := fs.FindPasswords(config.PREFIX)
	ranker := ranker.Ranker{Scorer: scorer.Scorer{Query: query}}
	fmt.Print(utils.SerializeItemsList(ranker.Rank(passwords)))
}
