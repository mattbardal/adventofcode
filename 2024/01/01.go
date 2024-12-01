package main

import (
	"fmt"
	"math"
	"slices"
	"strconv"
	"strings"
)

func splitLists(data string) ([]string, []string) {

	l := []string{}
	r := []string{}

	for _, line := range strings.Split(data, "\n") {
		if line == "" {
			continue
		}
		coords := strings.Split(line, "   ")
		l = append(l, coords[0])
		r = append(r, coords[1])
	}

	return l, r
}

func p1(data string) int {
	distance := 0

	l, r := splitLists(data)

	slices.Sort(l)
	slices.Sort(r)

	for i := 0; i < len(l); i++ {
		l_v, _ := strconv.Atoi(l[i])
		r_v, _ := strconv.Atoi(r[i])
		distance += int(math.Abs(float64(l_v - r_v)))
	}

	return distance
}

func p2(data string) int {
	similarity := 0

	l, r := splitLists(data)

	for i := 0; i < len(l); i++ {
		for j := 0; j < len(l); j++ {
			count := 0
			val, _ := strconv.Atoi(l[i])
			if l[i] == r[j] {
				count++
			}
			similarity += count * val
		}
	}

	return similarity
}

func main() {
	// fileName := "../inputs/01.txt"
	// data, _ := os.ReadFile(fileName)
	// dataStr := string(data)
	dataStr := "3   4\n4   3\n2   5\n1   3\n3   9\n3   3"

	fmt.Printf("%d\n", p1(dataStr))
	fmt.Printf("%d\n", p2(dataStr))
}
