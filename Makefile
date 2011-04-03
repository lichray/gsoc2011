all: proposal.html

proposal.html : proposal.rst
	rst2html -d proposal.rst proposal.html
