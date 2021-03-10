DIAGRAMS_SRC := $(wildcard diagrams/*.puml)
DIAGRAMS_PNG := $(addsuffix .png, $(basename $(DIAGRAMS_SRC)))

# Default target first; build PNGs, probably what we want most of the time
png: clean $(DIAGRAMS_PNG)

# Clone repositories
update:
	git submodule update --remote --recursive
# clean up compiled files
clean:
	rm -f $(DIAGRAMS_PNG)

# Each PNG output depends on its corresponding .puml file
diagrams/%.png: diagrams/%.puml
	plantuml -DRELATIVE_INCLUDE="../C4-PlantUML" -tpng $^

# Quirk of GNU Make: https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: png update clean
