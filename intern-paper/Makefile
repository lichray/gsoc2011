TEX := xelatex

name := intern-paper

all : pdf

pdf : $(name).pdf
$(name).pdf : $(name).tex
	$(TEX) $(name).tex

ahead : $(name).tex $(name).aux $(name).out
	$(TEX) $(name).tex
test : pdf
	xpdf $(name).pdf

clean :
	rm -f $(name).pdf $(name).aux $(name).log $(name).out
