include $(PQ_FACTORY)/factory.mk

pq_part_branch := 4.10.2.2614
pq_part_name   := squeak-vm-$(pq_part_branch)
pq_part_src    := Squeak-$(pq_part_branch)-src
pq_part_file   := $(pq_part_src).tar.gz

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_src)/bld
	$(MAKE) -C $(pq_part_src)/bld install DESTDIR=$(stage_dir)
	gzip -dc $(source_dir)/SqueakV41.sources.gz > $(stage_dir)/$(part_dir)/lib/squeak/4.10.2-2614/SqueakV41.sources
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_src) && \
	mkdir -p bld && \
	cd bld && \
	../unix/cmake/configure --prefix=$(part_dir)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar zxf $(source_dir)/$(pq_part_file)
	touch $@

