Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWAGNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWAGNWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWAGNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:22:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932725AbWAGNWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:22:38 -0500
Date: Sat, 7 Jan 2006 05:22:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm2
Message-Id: <20060107052221.61d0b600.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/

This should be somewhat less buggy than 2.6.15-mm1.


Changes since 2.6.15-mm1:

 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-audit.patch
 git-infiniband.patch
 git-input.patch
 git-libata-all.patch
 git-mmc.patch
 git-netdev-all.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-sas-jg.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 Subsystem trees

+revert-mm-page_state-fixes.patch

 This was a deoptimisation

+asm-generic-atomich-needs-typesh.patch

 Build fix

+md-support-check-without-repair-of-raid10-arrays.patch

 Linus seemed to drop this, and I'm not sure it's right any more.  Waiting
 for Neil to return.

-hfsplus-oops-fix.patch
-nbd-fix-tx-rx-race-condition.patch
-nbd-fix-tx-rx-race-condition-update.patch
-knfsd-fix-hash-function-for-ip-addresses-on-64bit-little-endian-machines.patch
-alpha-dma_map_page-fix.patch
-gregkh-i2c-i2c-i801-explicitly-set-smbauxctl.patch
-gregkh-i2c-i2c-ds1337-init.patch
-gregkh-i2c-hwmon-adm1025-adm1026-remove-deprecated-symbols.patch
-gregkh-i2c-hwmon-lm85-adt7463-vrm-10.patch
-gregkh-i2c-hwmon-w83627thf-fix-vrm-and-vid.patch
-gregkh-i2c-hwmon-w83627thf-vid-documentation-update.patch
-gregkh-i2c-i2c-rtc8564-remove-duplicate-bcd-macros.patch
-gregkh-i2c-i2c-parport-barco-lpt-dvi.patch
-gregkh-i2c-hwmon-vt8231-new-driver.patch
-gregkh-i2c-i2c-drop-driver-flags-01-df-dummy.patch
-gregkh-i2c-i2c-drop-driver-flags-02-df-notify.patch
-gregkh-i2c-i2c-drop-driver-flags-03-flags.patch
-gregkh-i2c-i2c-client-use-01-drop-multiple-use-flag.patch
-gregkh-i2c-i2c-client-use-02-make-use-flag-default.patch
-gregkh-i2c-i2c-client-use-03-allow-multiple-use.patch
-gregkh-i2c-i2c-doc-porting-clients-update.patch
-gregkh-i2c-i2c-core-get-client-is-gone.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-01-core.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-02-chips.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-03-hwmon.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-04-macintosh.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-05-media.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-06-oss.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-07-ppc.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-08-acorn.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-09-video.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-10-arm.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-11-documentation.patch
-gregkh-i2c-i2c-drop-driver-owner-and-name-12-fix-debug.patch
-gregkh-i2c-i2c-driver-owner-cleanup-01.patch
-gregkh-i2c-i2c-driver-owner-cleanup-02.patch
-gregkh-i2c-i2c-driver-owner-cleanup-03.patch
-gregkh-i2c-i2c-dev-dynamic_class.patch
-gregkh-i2c-hwmon-w83792d-misc-cleanups.patch
-gregkh-i2c-hwmon-w83792d-simplify-in-low-bits.patch
-gregkh-i2c-hwmon-vrm-via.patch
-gregkh-i2c-hwmon-it87-vrm-fits-in-u8.patch
-gregkh-i2c-i2c-id-cleanups.patch
-gregkh-i2c-i2c-drop-useless-command-callbacks.patch
-gregkh-i2c-i2c-update-command-documentation.patch
-gregkh-i2c-i2c-drop-driver-flags-04-drop-outdated-comments.patch
-gregkh-i2c-i2c-ibm_iic-hwmon-class.patch
-gregkh-i2c-i2c-nforce2-support-nforce4-mcp04.patch
-gregkh-i2c-i2c-mv64xxx-abort-fix.patch
-i8042-add-oqo-zepto-to-noloop-dmi-table.patch
-remove-duplicated-pci-id.patch
-libata_suspend.patch
-libata_suspend-fix.patch
-swsusp-resume_store-retval-fix.patch
-netfilter-fix-handling-of-module-param-dcc_timeout-in-ip_conntrack_ircc.patch
-git-serial-build-fix.patch
-git-alsa-vs-git-pcmcia.patch
-mm-fix-__alloc_pages-cpuset-alloc_-flags.patch
-mm-gfp_atomic-comment.patch
-memhotplug-__add_section-remove-unused-pgdat-definition.patch
-memhotplug-register_-and-unregister_memory_notifier-should-be-global.patch
-memhotplug-register_memory-should-be-global.patch
-reiser4-truncate_inode_pages_range.patch
-madvise-remove-remove-pages-from-tmpfs-shm-backing-store.patch
-hugetlb-remove-duplicate-i_size-check.patch
-hugetlb-rename-find_lock_page-to.patch
-hugetlb-reorganize-hugetlb_fault-to-prepare-for-cow.patch
-hugetlb-copy-on-write-support.patch
-dequeue-a-huge-page-near-to-this-node.patch
-add-numa-policy-support-for-huge-pages.patch
-add-numa-policy-support-for-huge-pages-fix.patch
-add-numa-policy-support-for-huge-pages-fix-fix.patch
-remove-old-node-based-policy-interface-from-mempolicyc.patch
-hugepages-fold-find_or_alloc_pages-into-huge_no_page.patch
-mm-kvaddr_to_nid-not-used-in-common-code.patch
-mm-pfn_to_pgdat-not-used-in-common-code.patch
-mm-remove-arch-independent-nodes_span_other_nodes.patch
-shut-up-warnings-in-ipc-shmc.patch
-flatmem-split-out-memory-model.patch
-sparsemem-provide-pfn_to_nid.patch
-mm-free_pages_and_swap_cache-opt.patch
-mm-pagealloc-opt.patch
-mm-set_page_refs-opt.patch
-mm-microopt-conditions.patch
-mm-remove-bad_range.patch
-mm-remove-pcp-low.patch
-mm-page_state-fixes.patch
-mm-page_alloc-cleanups.patch
-mm-optimize-numa-policy-handling-in-slab-allocator.patch
-mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions.patch
-cleanup-bootmem-allocator-and-fix-alloc_bootmem_low.patch
-frv-clean-up-bootmem-allocators-page-freeing-algorithm.patch
-find_lock_page-call-__lock_page-directly.patch
-kill-last-zone_reclaim-bits.patch
-kill-last-zone_reclaim-bits-fix.patch
-mm-dma32-zone-statistics.patch
-mm-bad_page-opt.patch
-mm-rmap-opt.patch
-mm-pfault-opt.patch
-mm-pcp-drain-tweak.patch
-vmscan-balancing-fix.patch
-consolidate-lru_add_drain-and-lru_drain_cache.patch
-mm-add-populated_zone-helper.patch
-simplify-build_zonelists_node-by-removing-the-case.patch
-move-determination-of-policy_zone-into-page-allocator.patch
-fix-zone-policy-determination.patch
-build_zonelists_node-rename-args.patch
-atomic_long_t-include-asm-generic-atomich-v2.patch
-atomic_long_t-include-asm-generic-atomich-v2-fix.patch
-atomic_long_t-include-asm-generic-atomich-v2-fix-2.patch
-atomic_long_t-include-asm-generic-atomich-v2-fix-3.patch
-atomic_long_t-include-asm-generic-atomich-v2-fix-4.patch
-mm-page_state-opt.patch
-mm-page_state-opt-fix.patch
-mm-page_state-opt-docs.patch
-x25-fix-for-broken-x25-module.patch
-selinux-array_size-cleanups.patch
-selinux-more-array_size-cleanups.patch
-keys-remove-key-duplication.patch
-security-possible-cleanups.patch
-ppc32-remove-jumbo-member-from-ocp_func_emac_data.patch
-arch-ppc-kernel-idlec-dont-declare-cpu-variable-in-non-smp-kernels.patch
-macintosh-dont-store-i2c_add_driver-return-if-no-further-processing-done.patch
-ppc32-remove-useless-file-arch-ppc-platforms-mpc5200c.patch
-ppc32-serial-fix-compiler-errors-with-gcc-4x-in.patch
-ppc32-serial-change-mpc52xx_uartc-to-use-the-low.patch
-ppc32-fix-static-io-mapping-for-freescale-mpc52xx.patch
-ppc32-modify-freescale-mpc52xx-irq-mapping-to-_not_.patch
-ppc32-remove-__init-qualifier-from-mpc52xx-pci.patch
-ppc32-fix-mpc52xx-configuration-space-access.patch
-ppc32-fix-mpc52xx-pci-init-in-cas-the-bootloader.patch
-ppc32-allows-compilation-of-a-mpc52xx-kernel-without.patch
-ppc32-re-add-embed_configc-to-ml300-ep405.patch
-therm_adt746x-quiet-fan-speed-change-messages.patch
-nommu-provide-shared-writable-mmap-support-on-ramfs.patch
-nommu-provide-shared-writable-mmap-support-on-ramfs-tidy.patch
-nommu-make-sysv-ipc-shm-use-ramfs-facilities-on-nommu.patch
-frv-implement-futex-operations-for-frv.patch
-frv-make-futex-code-compilable-on-nommu.patch
-frv-fix-frv-signal-handling.patch
-frv-improve-signal-handling.patch
-remove-include-asm-mips-riscos-syscallh.patch
-x86-gdt-alignment-fix.patch
-i386-dont-blindly-enable-interrupts-in-die.patch
-i386-move-simd-initialization.patch
-i386-move-simd-initialization-fix.patch
-i386-fix-bound-check-idt-gate.patch
-x86-cr4-is-valid-on-some-486s.patch
-x86-pnp-segments-in-segment-h.patch
-x86-always-relax-segments.patch
-x86-apm-seg-in-gdt.patch
-x86-deprecate-obsolete-ldt-accessors.patch
-x86-pnp-byte-granularity.patch
-x86-fixed-pnp-bios-limits.patch
-x86-stop-deleting-nt.patch
-x86-apm-is-on-cpu-zero-only.patch
-x86-deprecate-useless-bug.patch
-x86-handle-wsign-compare-in-bitops.patch
-mark-rodata-section-read-only-generic-infrastructure.patch
-mark-rodata-section-read-only-x86-parts.patch
-mark-rodata-section-read-only-generic-x86-64-bugfix.patch
-mark-rodata-section-read-only-x86-64-support.patch
-mark-rodata-section-read-only-make-some-datastructures-const.patch
-debug-option-to-write-protect-rodata-x86-support-warning-fix.patch
-i386-sparsemem-for-single-node-systems.patch
-allow-flatmem-to-be-disabled-when-only-sparsemem-is-implemented.patch
-x86-convert-bigsmp-to-use-flat-physical-mode.patch
-x86-make-bigsmp-the-default-mode-if-config_hotplug_cpu.patch
-reboot-through-the-bios-on-newer-hp-laptops.patch
-x86-change-page-attr-fix.patch
-x86-change-page-attr-fix-fix.patch
-x86-change-page-attr-fix-fix-fix.patch
-x86-missing-printk-newline-in-apic-boot-option-parser.patch
-x86-fls-in-asm.patch
-arch-i386-kernel-msrc-removed-unused-variable.patch
-arch-i386-kernel-cpuidc-unused-variable.patch
-i386-gpio-driver-for-amd-cs5535-cs5536-fix.patch
-base-support-for-amd-geode-gx-lx-processors.patch
-base-support-for-amd-geode-gx-lx-processors-tidy.patch
-geode-lx-hw-rng-support.patch
-geode-lx-hw-rng-support-fix.patch
-apm-screen-blanking-fix.patch
-apm-screen-blanking-fix-tidy.patch
-fix-cpu-frequency-detection-in-arch-i386-kernel-timers-timer_tsccrecalibrate_cpu_khz.patch
-mpspec-remove-unneeded-packed-attribute.patch
-i386-ioapic-virtual-wire-mode-fix.patch
-i386-handle-hp-laptop-rebooting-properly.patch
-cpu-hotplug-x86_64-disable-interrupt-in-play_dead.patch
-alpha-convert-to-generic-irq-framework-generic-part.patch
-alpha-convert-to-generic-irq-framework-alpha-part.patch
-swsusp-remove-encryption.patch
-swsusp-introduce-the-swap-map-structure.patch
-swsusp-improve-freeing-of-memory.patch
-swsusp-improve-freeing-of-memory-fix.patch
-swsusp-fix-enough_free_mem.patch
-oss-remove-deprecated-pm-interface-from-ad1848-driver.patch
-oss-remove-deprecated-pm-interface-from-cs4281-driver.patch
-oss-remove-deprecated-pm-interface-from-cs46xx-driver.patch
-oss-remove-deprecated-pm-interface-from-maestro-driver.patch
-oss-remove-deprecated-pm-interface-from-nm256-driver.patch
-oss-remove-deprecated-pm-interface-from-opl3sa2-driver.patch
-swsusp-drop-duplicate-prototypes.patch
-swsusp-limit-image-size.patch
-swsusp-make-image-size-limit-tunable.patch
-mm-add-a-new-function-needed-for-swap-suspend.patch
-swsusp-improve-handling-of-swap-partitions.patch
-swsusp-save-image-header-first.patch
-dont-freeze-firewire-on-suspend.patch
-m32r-trivial-fix-to-remove-unused-instructions.patch
-m32r-support-m32104ut-target-platform.patch
-m32r-update-syscall-macros-for-mmu-less.patch
-m32r-update-_port2addr-to-use.patch
-m32r-fix-m32104-cache-flushing-routines.patch
-m32r-remove-unnecessary-icu_data_t.patch
-m68knommu-enable_irq-disable_irq.patch
-m68knommu-remove-enable_irq_nosync.patch
-cris-kgdb-remove-double_this.patch
-uml-use-kstrdup.patch
-uml-non-void-functions-should-return-something.patch
-uml-formatting-changes.patch
-uml-use-array_size.patch
-uml-remove-unneeded-structure-field.patch
-uml-move-mconsole-support-out-of-generic-code.patch
-uml-add-static-initializations-and-declarations.patch
-uml-line_setup-interface-change.patch
-uml-move-console-configuration.patch
-uml-simplify-console-opening-closing-and-irq-registration.patch
-uml-fix-flip_buf-full-handling.patch
-uml-add-throttling-to-console-driver.patch
-uml-separate-libc-dependent-umid-code.patch
-uml-umid-cleanup.patch
-uml-sigwinch-handling-cleanup.patch
-uml-better-diagnostics-for-broken-configs.patch
-uml-add-mconsole_reply-variant-with-length-param.patch
-uml-capture-printk-output-for-mconsole-stack.patch
-uml-capture-printk-output-for-mconsole-sysrq.patch
-uml-fix-whitespace-in-mconsole-driver.patch
-uml-free-network-irq-correctly.patch
-s390-atomic-primitives.patch
-s390-cms-volume-label-definitions.patch
-s390-uaccess-warnings.patch
-s390-rt_sigreturn-fix.patch
-s390-update-default-configuration.patch
-s390-cputime_t-fixes.patch
-s390-re-activated-path-detection.patch
-s390-move-s390_root_dev_-out-of-the-cio-layer.patch
-s390-biodasdprrd-ioctl-return-code.patch
-s390-dasd-failfast-support.patch
-s390-add-oprofile-callgraph-support.patch
-s390-in-kernel-crypto-rename.patch
-s390-sha256-support.patch
-s390-aes-support.patch
-s390-in-kernel-crypto-test-vectors.patch
-s390-qdio-v=v-pass-through.patch
-s390-introduce-struct-subchannel_id.patch
-s390-introduce-for_each_subchannel.patch
-s390-introduce-struct-channel_subsystem.patch
-s390-convert-proc-cio_ignore.patch
-s390-multiple-subchannel-sets-support.patch
-s390-add-support-for-cex2a-crypto-cards.patch
-s390-fix-missing-release-function-and-cosmetic-changes.patch
-s390-fix-invalid-return-code-in-sclp_cpi.patch
-s390-cleanup-kconfig.patch
-mmci-kunmap_atomic-unmaps-virtual-address-not-page.patch
-protect-remove_proc_entry.patch
-add-udev-support-to-parport_pc.patch
-add-udev-support-to-parport_pc-tidy.patch
-i2o-changed-i2o-api-to-create-i2o-messages-in-kernel.patch
-i2o-changed-i2o-api-to-create-i2o-messages-in-kernel-fix.patch
-i2o-sparc-fixes.patch
-i2o-remove-wrong-i2o-device-class.patch
-i2o-bugfixes.patch
-i2o-beautifying.patch
-i2o-optimizing.patch
-i2o-lindent-run.patch
-fuse-clean-up-fuse_lookup.patch
-fuse-clean-up-page-offset-calculation.patch
-fuse-bump-interface-version.patch
-fuse-add-frsize-to-statfs-reply.patch
-fuse-support-caching-negative-dentries.patch
-fuse-add-code-documentation.patch
-fuse-fail-file-operations-on-bad-inode.patch
-fuse-clean-up-request-size-limit-checking.patch
-fuse-make-maximum-write-data-configurable.patch
-fuse-ensure-progress-in-read-and-write.patch
-fuse-check-file-type-in-lookup.patch
-parport-buffer-overflow-fix.patch
-parport-phase-fixes.patch
-parport-daisy-chain-end-detection-fix.patch
-parport-daisy-chain-device-id-reading-fix.patch
-parport-daisy-chain-device-id-reading-fix-2.patch
-parport-use-complete-slab-buffer.patch
-parport-constification.patch
-parport-constification-fix.patch
-parport-debug_parport-build-fix.patch
-parport-kconfig-dependency-fixes.patch
-parport-include-fixes.patch
-parport-export-parport_get_port.patch
-simplify-parport_pc_pcmcia-dependencies.patch
-include-linux-parport_pch-extern-inline-static-inline.patch
-ipmi-use-refcount-in-message-handler-avoid-list_for_each_safe_rcu.patch
-kernel-modulec-removed-dead-code.patch
-jbd-split-checkpoint-lists.patch
-keep-nfsd-from-exiting-when-seeing-recv-errors.patch
-knfsd-check-error-status-from-vfs_getattr-and-i_op-fsync.patch
-knfsd-reduce-stack-consumption.patch
-device-mapper-add-dm_find_md.patch
-device-mapper-add-dm_get_md.patch
-device-mapper-ioctl-event-on-rename.patch
-device-mapper-snapshot-metadata-reading-separation.patch
-device-mapper-remove-unused-definition.patch
-device-mapper-scanf-sector-format-change.patch
-device-mapper-raid1-add-default-mirror.patch
-device-mapper-rename-frozen_bdev.patch
-device-mapper-make-lock_fs-optional.patch
-device-mapper-ioctl-add-skip-lock_fs-flag.patch
-drivers-md-kcopydc-if-0-kcopyd_cancel.patch
-dm-crypt-zero-key-before-freeing-it.patch
-make-dm-mirror-not-issue-invalid-resync-requests.patch
-md-improve-raid1-io-barrier-concept.patch
-md-improve-raid10-io-barrier-concept.patch
-md-small-cleanups-for-raid5.patch
-md-allow-dirty-raid-arrays-to-be-started-at-boot.patch
-md-move-bitmap_create-to-after-md-array-has-been-initialised.patch
-md-write-intent-bitmap-support-for-raid10.patch
-md-fix-raid6-resync-check-repair-code.patch
-md-improve-handing-of-read-errors-with-raid6.patch
-md-attempt-to-auto-correct-read-errors-in-raid1.patch
-md-tidyup-some-issues-with-raid1-resync-and-prepare-for-catching-read-errors.patch
-md-better-handling-for-read-error-in-raid1-during-resync.patch
-md-handle-errors-when-read-only.patch
-md-fix-up-some-rdev-rcu-locking-in-raid5-6.patch
-md-support-check-without-repair-of-raid10-arrays.patch
-md-allow-raid1-to-check-consistency.patch
-md-make-sure-read-error-on-last-working-drive-of-raid1-actually-returns-failure.patch
-md-auto-correct-correctable-read-errors-in-raid10.patch
-md-raid10-read-error-handling-resync-and-read-only.patch
-md-make-proc-mdstat-pollable.patch
-md-clean-up-page-related-names-in-md.patch
-md-convert-md-to-use-kzalloc-throughout.patch
-md-tidy-up-raid5-6-hash-table-code.patch
-md-convert-various-kmap-calls-to-kmap_atomic.patch
-md-convert-recently-exported-symbol-to-gpl.patch
-md-break-out-of-a-loop-that-doesnt-need-to-run-to-completion.patch
-md-remove-personality-numbering-from-md.patch
-md-fix-possible-problem-in-raid1-raid10-error-overwriting.patch
-md-remove-inappropriate-limits-in-md-bitmap-configuration.patch
-md-define-and-use-safe_put_page-for-md.patch
-md-helper-function-to-match-commands-written-to-sysfs-files.patch
-md-fix-typo-in-comment.patch
-md-make-a-couple-of-names-in-mdc-static.patch
-md-make-a-couple-of-names-in-mdc-static-fix.patch
-md-make-sure-bitmap-updates-are-visible-through-filesystem.patch
-md-fix-rdev-pending-counts-in-raid1.patch
-md-allow-chunk_size-to-be-settable-through-sysfs.patch
-md-allow-md-array-component-size-to-be-accessed-and-set-via-sysfs.patch
-md-expose-md-metadata-format-in-sysfs.patch
-md-allow-array-level-to-be-set-textually-via-sysfs.patch
-md-count-corrected-read-errors-per-drive.patch
-md-allow-md-raid_disks-to-be-settable.patch
-md-keep-better-track-of-dev-array-size-when-assembling-md-arrays.patch
-md-expose-device-slot-information-via-sysfs.patch
-md-export-rdev-data_offset-via-sysfs.patch
-md-export-rdev-data_offset-via-sysfs-fix.patch
-md-allow-available-size-of-component-devices-to-be-set-via-sysfs.patch
-md-allow-available-size-of-component-devices-to-be-set-via-sysfs-fix.patch
-md-support-adding-new-devices-to-md-arrays-via-sysfs.patch
-md-allow-sync-speed-to-be-controlled-per-device.patch
-decrease-number-of-pointer-derefs-in-nfnetlink_queuec.patch
-decrease-number-of-pointer-derefs-in-nf_conntrack_corec.patch

 Merged

+git-acpi-memhotplug-build-fix.patch

 Fix git-acpi.patch

+git-blkdev-fixup.patch

 Fix rejects in git-blkdev.patch

+git-cfq-fixup.patch

 Fix rejects in git-cfq.patch

+git-libata-all-fixup.patch

 Fix rejects in git-libata-all.patch

+git-libata-all-pata_amd-build-fix.patch

 Fix git-libata-all.patch

+fix-sys-class-net-if-wireless-without-dev-get_wireless_stats.patch
+fix-sys-class-net-if-wireless-without-dev-get_wireless_stats-fix.patch

 Bring back a /sys file needed by userspace wireless control apps.

+bonding-sparse-warnings-fix.patch

 Bonding fixlet

+pass-proper-device-from-buslogic-to-scsi-layer.patch

 Buslogic driver fix

+areca-raid-driver-arcmsr-cleanups.patch

 Clean up areca-raid-linux-scsi-driver.patch

+gregkh-usb-usb-remove-usb_audio-and-usb_midi-drivers.patch
+gregkh-usb-usb-drivers-usb-core-message.c-make-usb_get_string-static.patch

 USB tree updates

+arm-netwinder-watchdog-wdt977-update.patch

 Netwinder driver fix

-x86_64-cpu-pda-cleanup.patch
-x86_64-remove-kdb-vector.patch
+x86_64-cpu-pda-cleanup.patch
+x86_64-remove-kdb-vector.patch
+x86_64-sparse-warnings-fix.patch
+x86_64-invalid-operand-name.patch
+x86_64-allow-setting-rf-in-eflags.patch
+x86_64-io-apic-memorize.patch
+x86_64-cleanup-enter_lazy_tlb.patch

 x86_64 tree updates

+i386-io_apic-use-correct-index-variable-when-computing-the.patch

 x86 io-apic fix

+fix-compilation-with-config_memory_hotplug=y-and-gcc41.patch

 Build fix

+swap-migration-v5-sys_migrate_pages-interface-x86_64-fix.patch

 Fix the swap migration patch

+oom-kill-of-current-task.patch

 Optimise oom-killing of current task

+acx-driver-update.patch

 Update acx wireless driver

+xfrm-sparse-warning-fix.patch

 Sparse fix

+frv-suppress-configuration-of-certain-features-for-frv.patch
+frv-drop-8-16-bit-xchg-and-cmpxchg.patch
+frv-drop-unsupported-debugging-features.patch
+frv-implement-and-export-various-things-required-by-modules.patch
+frv-support-module-exception-tables.patch
+frv-supply-various-missing-i-o-access-primitives.patch
+frv-add-module-support-stubs.patch
+frv-add-pci_iomap.patch
+frv-fix-pcmcia-configuration.patch
+frv-force-serial-driver-inclusion.patch
+frv-make-get_user-macro-cast-pointers.patch
+frv-miscellaneous-changes.patch
+frv-fix-uninitialised-variable-in-atm-nicstar-driver.patch
+frv-fix-uninitialised-variable-in-serverworks-driver.patch

 FRV updates

+ia64-use-i386-dmi_scanc.patch

 ia64 uses some of ia32's DMI code.

+uml-move-libc-dependent-code-from-signal_userc.patch
+uml-move-libc-dependent-code-from-trap_userc.patch
+uml-merge-trap_userc-and-trap_kernc.patch
+uml-whitespace-cleanup.patch
+uml-prevent-mode_skas=n-and-mode_tt=n.patch

 UML updates

+consolidate-asm-futexh.patch

 Cleanup

-support-for-preadv-pwritev.patch
-support-for-preadv-pwritev-fix.patch

 Dropped these - they might come back if we have a good reason, but they
 touch the syscall tables and cause me grief.

+parport_pc-arm-build-fix.patch
+parport-bring-back-an-unused-phase-for-ppdev-ioctl.patch

 parport fixes

+simplify-k_getrusage.patch
+avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage.patch
+avoid-taking-global-tasklist_lock-for-single-threadedprocess-at-getrusage-tidy.patch

 SMP optimisation

+drivers-isdn-add-missing-includes.patch
+drivers-isdn-hardware-eicon-os_4bric-correct-the-xdiloadfile-signature.patch

 ISDN fixes

+dump_thread-cleanup.patch

 Code consolidation

+cciss-avoid-defining-useless-major_nr-macro.patch

 Cleanup

+remove-set_fs-in-stop_machine.patch

 Remove unneeded code

+kdump-documentation-update.patch

 Documentation

-unshare-system-call-system-call-handler-function.patch
-unshare-system-call-system-call-registration-for-i386.patch
-unshare-system-call-system-call-registration-for-powerpc.patch
-unshare-system-call-system-call-registration-for-ppc.patch
-unshare-system-call-system-call-registration-for-x86_64.patch
-unshare-system-call-allow-unsharing-of-filesystem.patch
-unshare-system-call-allow-unsharing-of-namespace.patch
-unshare-system-call-allow-unsharing-of-vm.patch
-unshare-system-call-allow-unsharing-of-files.patch

 These caused an oops - dropped.

+mutex-subsystem-add-atomic_xchg-to-all-arches.patch
+mutex-subsystem-add-typecheck_fntype-function.patch
+mutex-subsystem-add-asm-generic-mutex-h-implementations.patch
+mutex-subsystem-memory-ordering-fixes.patch
+mutex-subsystem-add-include-asm-i386-mutexh.patch
+mutex-subsystem-add-include-asm-x86_64-mutexh.patch
+mutex-subsystem-add-include-asm-arm-mutexh.patch
+mutex-subsystem-add-include-asm-arm-mutexh-fix.patch
+mutex-subsystem-add-default-include-asm-mutexh-files.patch
+mutex-subsystem-core.patch
+mutex-subsystem-documentation.patch
+mutex-subsystem-debugging-code.patch
+mutex-subsystem-more-debugging-code.patch
+mutex-subsystem-synchro-test-module.patch
+mutex-subsystem-semaphore-to-mutex-xfs.patch
+mutex-subsystem-semaphore-to-mutex-vfs-i_sem.patch
+mutex-subsystem-semaphore-to-mutex-vfs-i_sem-more.patch
+mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes.patch
+mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes-2.patch
+mutex-subsystem-semaphore-to-mutex-vfs-i_sem-fixes-3.patch
+mutex-subsystem-semaphore-to-mutex-vfs-sb-s_lock.patch
+mutex-subsystem-semaphore-to-completion-sx8.patch
+mutex-subsystem-semaphore-to-completion-cpu3wdt.patch
+mutex-subsystem-semaphore-to-completion-ide-gendev_rel_sem.patch
+mutex-subsystem-semaphore-to-completion-drivers-block-loopc.patch
+reiser4-i_sem-mutex-switch.patch

 mutex stuff

-time-i386-conversion-part-2-move-timer_tscc-to-tscc.patch
-time-i386-conversion-part-3-rework-tsc-support.patch
-time-i386-conversion-part-4-acpi-pm-variable-renaming-and-config-change.patch
-time-i386-conversion-part-5-enable-generic-timekeeping.patch
-time-i386-conversion-part-6-remove-old-code.patch
+time-i386-conversion-part-2-rework-tsc-support.patch
+time-i386-conversion-part-3-enable-generic-timekeeping.patch
+time-i386-conversion-part-4-remove-old-timer_opts-code.patch
+time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
+time-fix-cpu-frequency-detection.patch

 New version of the time patches.

+kprobes-conversion-from-kcalloc-to-kzalloc.patch

 kzalloc conversion

+drivers-media-conversions-from-kmallocmemset-to-kzcalloc.patch

 kzalloc conversion

-ide-compat_semaphore-to-completion.patch

 Dropped - is in the mutex patches

+fbcon-dont-call-set_par-in-fbcon_init-if-vc_mode==kd_graphics.patch

 Fix loading of fbcon drivers while in X.

+make-__always_inline-actually-force-always-inlining.patch
+kbuild-call-gcc_version-earlier.patch
+enable-unit-at-a-time-optimisations-for-gcc4.patch
+mark-several-functions-__always_inline.patch
+mark-some-key-vfs-functions-as-__always_inline.patch
+uninline-capable.patch
+unlinline-a-bunch-of-other-functions.patch
+pktcdvd-un-inline-some-functions.patch
+make-inline-no-longer-mandatory-for-gcc-4x.patch

 Futz with inlining.

+vfa-at-functions-core.patch
+vfs-at-functions-i386.patch
+vfs-at-functions-x86_64.patch

 Add new filesystem syscalls: these are like open() and friends except "The
 openat() function is identical to the open() function except that the path
 argument is interpreted relative to the starting point implied by the fd
 argument.  If the fd argument has the special value AT_FDCWD, a relative path
 argument will be resolved relative to the current working directory.  If the
 path argument is absolute, the fd argument is ignored."

+fix-some-f_ops-abuse-in-acpi.patch
+fix-input-layer-f_ops-abuse.patch
+fix-cifs-bugs-wrt-writing-to-f_ops.patch
+mark-f_ops-const-in-the-inode.patch

 Preparation for moving the file_operations tables into .rodata.

+docs-update-typos-corrections-and-additions-to-applying-patchestxt.patch
+docs-update-missing-files-and-descriptions-for-filesystems-00-index.patch
+docs-update-small-spelling-formating-etc-fixes-for-filesystems-ext3txt.patch
+docs-update-remove-obsolete-patch-from-lockstxt.patch
+docs-update-small-fixes-to-stable_kernel_rulestxt.patch

 Documentation fixes

+debug-shared-irqs-fix.patch

 Fix debug-shared-irqs.patch



All 1179 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/patch-list


