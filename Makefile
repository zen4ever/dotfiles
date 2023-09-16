DOT_FILES = .gitconfig .tmux.conf .vimrc .vim

all: init $(foreach f, $(DOT_FILES), link-dot-file-$(f))
  
.PHONY: clean init

clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))

init:
	git submodule update --init
  

link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<
