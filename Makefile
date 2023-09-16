DOT_FILES = .gitconfig .tmux.conf .vimrc .vim

all: init $(foreach f, $(DOT_FILES), link-dot-file-$(f)) init.vim
  
.PHONY: clean init init.vim

clean: $(foreach f, $(DOT_FILES), unlink-dot-file-$(f))

init:
	git submodule update --init

init.vim:
	mkdir -p $(HOME)/.config/nvim
	ln $(CURDIR)/init.vim $(HOME)/.config/nvim/init.vim
  

link-dot-file-%: %
	@echo "Create Symlink $< => $(HOME)/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

unlink-dot-file-%: %
	@echo "Remove Symlink $(HOME)/$<"
	@$(RM) $(HOME)/$<
