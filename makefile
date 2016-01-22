include $(PQ_FACTORY)/factory.mk

pq_part_branch := 4.10.2.2614
pq_part_name   := squeak-vm-$(pq_part_branch)
pq_part_file   := Squeak-$(pq_part_branch)-src.tar.gz

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name)
	$(MAKE) -C $(pq_part_name) install DESTDIR=$(stage_dir)
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure --prefix=$(part_dir) --with-gmp=$(pq-gmp-dir)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar zxf $(source_dir)/$(pq_part_file)
	touch $@

