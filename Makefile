AMPY := ampy

DIRECTORIES = \
	uslackclient \
	$(NULL)

SOURCES = \
	uslackclient/__init__.py \
	uslackclient/channel.py \
	uslackclient/client.py \
	uslackclient/exceptions.py \
	uslackclient/im.py \
	uslackclient/server.py \
	uslackclient/slackrequest.py \
	uslackclient/user.py \
	uslackclient/util.py \
	uslackclient/version.py \
	$(NULL)

__mkdir__/% : %
	@ampy ls | grep $< || ampy mkdir $<

__deploy__/%.py: %.py
	@mkdir -p $(dir $@)
	$(AMPY) put $< $<
	@cp $< $@

__remove_dir__/% : %
	$(AMPY) rmdir $< || echo 'Already deleted'
	@rm -r __deploy__/$<

deploy: $(addprefix __mkdir__/, $(DIRECTORIES)) $(addprefix __deploy__/, $(SOURCES))

.PHONY: clean
clean: $(addprefix __remove_dir__/, $(DIRECTORIES))
