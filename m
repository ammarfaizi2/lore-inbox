Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVKQTSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVKQTSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVKQTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:18:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964782AbVKQTS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:18:29 -0500
Date: Thu, 17 Nov 2005 11:18:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-mm1
Message-Id: <20051117111807.6d4b0535.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1

- reiser4 significantly updated




Changes since 2.6.14-mm2:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-drm.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-sas.patch
 git-cryptodev.patch

 Subsystem trees

-work-around-gcc-32x-cpp-bug.patch
-x86_64-fix-tss-limit.patch
-x86_64-two-timer-entries-in-sys.patch
-reorder-struct-files_struct.patch
-git-acpi-pciehprm_acpi-fix.patch
-speakup-is-busted-on-pc64.patch
-libatah-needs-dma-mappingh.patch
-sky2-needs-dma_mappingh.patch
-serial-dont-disable-xscale-serial-ports-after-autoconfig.patch
-gregkh-pci-pci_find_next_capability.patch
-gregkh-pci-pci-pciehp-01.patch
-gregkh-pci-pci-pciehp-02.patch
-gregkh-pci-pci-pciehp-03.patch
-gregkh-pci-pci-pciehp-04.patch
-gregkh-pci-pci-pciehp-05.patch
-gregkh-pci-pci-pciehp-06.patch
-gregkh-pci-pci-pciehp-07.patch
-gregkh-pci-pci-pciehp-08.patch
-gregkh-pci-pci-via-686-quirk-name-fix.patch
-gregkh-pci-pci-ncr-53c810-quirk.patch
-gregkh-pci-pci-driver-store_new_id-not-inline.patch
-gregkh-pci-pci_driver_auto_set_owner.patch
-gregkh-pci-pci-driver-owner-removal.patch
-gregkh-pci-dlpar-regression-for-ppc64-probe-change.patch
-gregkh-pci-pci_ids-cleanup-fix-two-additional-ids-in-bt87x.patch
-gregkh-pci-pci-drivers-pci-small-cleanups.patch
-gregkh-pci-pci-changing-msi-to-use-physical-delivery-mode-always.patch
-gregkh-pci-pci-fix-namespace-clashes.patch
-gregkh-pci-pci-fix-for-toshiba-ohci1394-quirk.patch
-gregkh-pci-pci-driver-owner-removal-fix-lpfc.patch
-gregkh-pci-pci-driver-owner-removal-fix-spider_net.patch
-pciehp_hpc-build-fix.patch
-shpchp_hpc-build-fix.patch
-kill-libata-scsi_wait_req-usage-make-libata-compile-in.patch
-display7seg-build-fix.patch
-gregkh-usb-usb-pxa27x-update-01.patch
-gregkh-usb-usb-pxa27x-update-02.patch
-gregkh-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
-gregkh-usb-usb-wacom-tablet-driver-update.patch
-gregkh-usb-usb-onetouch-doesn-t-suspend-yet.patch
-x86_64-defconfig-update.patch
-x86_64-dma32.patch
-x86_64-dma32-ia64-compat.patch
-x86_64-dma32-srat32.patch
-x86_64-pagealloc-cpu-up-cancel.patch
-x86_64-vm-holes-reserved.patch
-x86_64-hpet-regs.patch
-x86_64-mce-thresh.patch
-x86_64-vect-share.patch
-x86_64-pfn-valid-comment.patch
-x86_64-page-flags-cleanup.patch
-x86_64-dma32-iommu.patch
-x86_64-cpuinit-duplicate.patch
-x86_64-extend-model-for-family6.patch
-x86_64-aper-warn.patch
-x86_64-faster-numa-node-id.patch
-x86_64-zap-low.patch
-x86_64-physical-mask.patch
-x86_64-sections-include.patch
-x86_64-pda-extern.patch
-x86_64-swiotlb-extern.patch
-x86_64-mm-clarification.patch
-x86_64-largespinlock.patch
-x86_64-hotplug-cpus.patch
-x86_64-signal-code-segment.patch
-x86_64-numa-hash-opt.patch
-x86_64-agp-new-bridges.patch
-x86_64-agp-amd64-unsupported.patch
-x86_64-agp-gart-iterator.patch
-x86_64-intel-cpuid-fixup.patch
-x86_64-aout-module.patch
-x86_64-process-indent.patch
-x86_64-reboot-irq.patch
-x86_64-numa-hash-debug.patch
-x86_64-intel-multi-core.patch
-x86_64-intel-cache.patch
-x86_64-reboot-loop.patch
-x86_64-remove-stepping-b-opts.patch
-x86_64-remove-rwsem.patch
-x86_64-max-alignment.patch
-x86_64-time64.patch
-x86_64-numa-kconfig.patch
-x86_64-mce-intel.patch
-x86_64-node-range.patch
-x86_64-remove-checking.patch
-x86_64-max-apics.patch
-x86_64-sparse-fix.patch
-dma32-change-zones_shift-back-to-2.patch
-dma32-change-zones_shift-back-to-2-gfp_zonemask-too.patch
-mm-__gfp_nofail-fix.patch
-mm-zap_block-causes-redundant-work.patch
-mm-zap_block-causes-redundant-work-warning-fix.patch
-mm-__alloc_pages-cleanup.patch
-mm-__alloc_pages-cleanup-tidy.patch
-mm-highmem-watermarks.patch
-mm-dont-print-per-cpu-vm-stats-for-offline-cpus.patch
-fix-sparse-warning-in-horizon-atm-driver.patch
-ppc-add-support-for-new-powerbooks.patch
-ppc32-add-support-for-handling-pci-interrupts-on-mpc834x.patch
-powerpc-check_for_initrd-fix.patch
-powerpc-xmon-build-fix.patch
-arch-i386-mm-initc-small-cleanups.patch
-i386-nmi-pointer-comparison-fix.patch
-move-pm_register-etc-to-config_pm_legacy-pm_legacyh.patch
-m68k-introduce-task_thread_info.patch
-m68k-introduce-setup_thread_stack-end_of_stack.patch
-m68k-thread_info-header-cleanup.patch
-m68k-m68k-specific-thread_info-changes.patch
-m68k-convert-thread-flags-to-use-bit-fields.patch
-add-stack-field-to-task_struct.patch
-rename-allocfree_thread_info-to-allocfree_thread_stack.patch
-rename-allocfree_thread_info-to-allocfree_thread_stack-powerpc-fix.patch
-use-end_of_stack.patch
-change-thread_info-access-to-stack.patch
-use-task_thread_info.patch
-new-omnikey-cardman-4040-driver.patch
-new-omnikey-cardman-4000-driver.patch
-signal-handling-revert-sigkill-priority-fix.patch
-ext3-journal-handling-on-error-path-in-ext3_journalled_writepage.patch
-synclink-update-to-use-dma-mapping-api.patch
-fix-sparse-warning-in-proc-task_mmuc.patch
-shut-up-per_cpu_ptr-on-up.patch
-pktcdvd-remove-subscribers-only-list.patch
-rcutorture-renice-to-low-priority.patch
-i386-generic-cmpxchg.patch
-i386-generic-cmpxchg-tidy.patch
-atomic-cmpxchg.patch
-atomic-cmpxchg-tidy.patch
-atomic-inc_not_zero.patch
-atomic-inc_not_zero-tidy.patch
-arch-mips-au1000-common-usbdevc-dont-concatenate-__function__-with-strings.patch
-stop_machine-vs-synchronous-ipi-send-deadlock.patch
-aio-remove-kioctx-from-mm_struct.patch
-aio-replace-locking-comments-with-assert_spin_locked.patch
-aio-dont-ref-kioctx-after-decref-in-put_ioctx.patch
-relayfs-add-support-for-non-relay-files.patch
-relayfs-documentation-for-non-relay-file-support.patch
-relayfs-make-exported-relay-fileops-useful.patch
-relayfs-documentation-for-exported-relay-fileops.patch
-ext2-remove-duplicate-newlines-in-ext2_fill_super.patch
-accth-needs-jiffies-h.patch
-hdaps-convert-to-dynamic-input_dev-allocation.patch
-v4l-9261-added-compiling-options-for-wm8775-and.patch
-v4l-930-alsa-fixes-and-improvements.patch
-v4l-943-added-secam-l-video-standard.patch
-v4l-935-moved-common-ir-stuff-to-ir-commonc.patch
-v4l-936-support-for-sabrent-bt848-version.patch
-v4l-937-included-missing-interrupth-at.patch
-v4l-939-support-for-nebula-rc5-based-gpio-remote.patch
-v4l-944-added-driver-for-saa7127-video.patch
-v4l-944-added-driver-for-saa7127-video-tidy.patch
-v4l-945-adds-a-new-include-for-internal.patch
-v4l-946-adds-support-for-cx25840-video.patch
-v4l-949-added-support-for-secam-l.patch
-v4l-950-added-compiler-options-for-cx25840-saa7115.patch
-v4l-951-make-saa7134-oss-as-a-stand-alone-module.patch
-v4l-958-make-cx25840-use-firmware-image-named.patch
-v4l-962-added-new-saa7134-card-msi-tv-anywhere.patch
-v4l-963-em28xx-ir-fixup.patch
-v4l-9631-hybrid-v4l-dvb-remove-duplicated-code.patch
-v4l-948-adds-support-for-saa7115-video.patch
-v4l-966-authorship-fixes-for-new-modules.patch
-v4l-9661-removes-obsoleted-i2c-compath-from.patch
-v4l-prevent-saa7134-alsa-undefined-warnings.patch
-v4l-saa711x-driver-doesnt-need-segmenth.patch
-make-vesafb-build-without-config_mtrr.patch
-docbook-allow-to-mark-structure-members-private.patch
-docbook-include-printk-documentation.patch
-docbook-comment-about-paper-type.patch
-docbook-revert-xmlto-use-for-ps-and-pdf-documentation.patch

 Merged

+e1000-fix-for-dhcp-issue.patch

 e1000 fix

+fix-copy-paste-bug-in-ohci-ppc-socc.patch

 ppc driver fix.

+add-success-failure-indication-to-rcu-torture-test.patch

 Update to the RCU correctness tests.

+export-clear_page_dirty_for_io.patch

 Re-export an ill-advised un-export.

+ipmi-missing-null-test-for-kthread.patch

 IPMI fix.

+ppc32-added-missing-define-for-fs_enet-ethernet-driver.patch

 ppc32 net driver fix

+tpm-use-flush_scheduled_work.patch
+tpm-use-ioread8-and-iowrite8.patch

 TPM driver updates.

+md-dont-pass-null-file-into-prepare_write.patch
+md-fix-is_mddev_idle-calculation-now-that-disk-sector-accounting-happens-when-request-completes.patch

 md fixes

+cifs-build-fix.patch

 Fix git-cifs.patch.

+cpufreq-documentation-for-ondemand-and-conservative.patch
+cpufreq-silence-warning-for-up.patch

 Cpufreq fixes.

+gregkh-driver-move-pnpbios-usermod_helper.patch
+gregkh-driver-remove-KOBJECT_UEVENT.patch
+gregkh-driver-add-uevent_helper.patch
+gregkh-driver-remove-mount-events.patch
+gregkh-driver-merge-hotplug-and-uevent.patch

 Updates to the driver tree.

+gregkh-i2c-hwmon-w83627hf-missing-in0-limit-check.patch
+gregkh-i2c-hwmon-lm78-fix-vid.patch

 Updates to the i2c tree.

+input-attempt-to-re-synchronize-mouse-every-5-seconds.patch

 Try to fix glitches with ps/2 mice and KVMs

+blkmtd-use-clear_page_dirty.patch

 blkmtd fixes

+gregkh-pci-pci-trivial-printk-updates-in-common.c.patch
+gregkh-pci-pci-express-hotplug-clear-sticky-power-fault-bit.patch

 PCI tree updates

+git-pcmcia-validate_mem-fix.patch

 git-pcmcia fix

+gregkh-usb-usb-fix-dummy_hcd-breakage.patch
+gregkh-usb-usb-serial-history-not-old.patch
+gregkh-usb-add-new-wacom-devices-to-usb-hid-core-list.patch
+gregkh-usb-usb-wacom-tablet-driver-update.patch
+gregkh-usb-usb-onetouch-doesn-t-suspend-yet.patch
+gregkh-usb-usb-pl2303-adds-new-ids.patch
+gregkh-usb-usb-pl2303-updates-pl2303_update_line_status.patch
+gregkh-usb-usb-adapt-microtek-driver-to-new-scsi-features.patch
+gregkh-usb-usb-storage-fix-detection-of-kodak-flash-readers-in-shuttle_usbat-driver.patch
+gregkh-usb-usb-fix-race-in-kaweth-disconnect.patch
+gregkh-usb-usb-devio-warning-fix.patch
+gregkh-usb-usb-maxtor-onetouch-button-support-for-older-drives.patch
+gregkh-usb-usb-ohci-lh7a404-platform-device-conversion-fixup.patch
+gregkh-usb-pxa27x-ohci-separate-platform-code-from-main-driver.patch
+gregkh-usb-add-pxa27x-ohci-pm-functions.patch
+gregkh-usb-usb-file-storage-gadget-add-reference-count-for-children.patch
+gregkh-usb-usb-net-removes-redundant-return.patch
+gregkh-usb-usb-net-new-device-id-passed-through-module-parameter.patch
+gregkh-usb-usb-dummy_hcd-rename-variables.patch
+gregkh-usb-usbcore-central-handling-for-host-controllers-that-were-reset-during-suspend-resume.patch

 USB tree updates

+x86_64-amd-constant-tsc.patch
+x86_64-config-unwind-info.patch
+x86_64-bound-gate.patch
+x86_64-remove-die-if-kernel.patch
+x86_64-die-trap-info.patch
+x86_64-doublefault-cleanup.patch
+x86_64-iret-handling.patch
+x86_64-pagefault-vmalloc.patch

 x86_64 tree updates

+mm-fix-__alloc_pages-cpuset-alloc_-flags.patch
+mm-simplify-__alloc_pages-cpuset-alloc_-flags.patch
+mm-rationalize-__alloc_pages-alloc_-flag-names.patch
+mm-simplify-__alloc_pages-cpuset-hardwall-logic.patch
+mm-gfp_atomic-comment.patch
+memhotplug-__add_section-remove-unused-pgdat-definition.patch
+memhotplug-register_-and-unregister_memory_notifier-should-be-global.patch
+memhotplug-register_memory-should-be-global.patch
+memhotplug-memory_hotplug_name-should-be-const.patch
+mm-redo-alloc_-flag-names-again.patch

 Memory management updates

+madvise-remove-remove-pages-from-tmpfs-shm-backing-store.patch
+madvise-remove-remove-pages-from-tmpfs-shm-backing-store-tidy.patch
+madvise-remove-remove-pages-from-tmpfs-shm-backing-store-fix.patch

 Weird feature to shoot down shm pages

+dequeue-a-huge-page-near-to-this-node.patch
+add-numa-policy-support-for-huge-pages.patch
+add-numa-policy-support-for-huge-pages-fix.patch
+add-numa-policy-support-for-huge-pages-fix-fix.patch
+remove-old-node-based-policy-interface-from-mempolicyc.patch
+hugepages-fold-find_or_alloc_pages-into-huge_no_page.patch

 NUMA updates

+mm-kvaddr_to_nid-not-used-in-common-code.patch
+mm-pfn_to_pgdat-not-used-in-common-code.patch
+mm-sparse-provide-pfn_to_nid.patch

 MM cleanups

+preserve-irq-status-in-release_pages-__pagevec_lru_add.patch

 The swap-based migration patches need extra interrupt coverage

-swap-migration-v5-lru-operations-tweaks.patch
-swap-migration-v5-lru-operations-fix.patch

 Folded into swap-migration-v5-lru-operations.patch

+swap-migration-v5-lru-operations-inline-shrinkage.patch

 Reduce inlining bloat

+swap-migration-v5-migrate_pages-function-tweak.patch

 Against swap-migration-v5-migrate_pages-function.patch

+swap-migration-add-config_migration-for-page-migration-support-tweaks.patch

 Against swap-migration-add-config_migration-for-page-migration-support.patch

+swap-migration-v5-mpol_mf_move-interface-tweaks.patch

 Against  swap-migration-v5-mpol_mf_move-interface.patch

-swap-migration-v5-sys_migrate_pages-interface-update.patch

 Folded into swap-migration-v5-sys_migrate_pages-interface.patch

+mm-make-hugepages-obey-cpusets.patch

 cpuset control of hugepages

+fix-ifenslave-to-not-fail-on-lack-of-ip-information.patch

 Fix the ifenslave sample app

+r8169-printk_ratelimit-fix.patch
+ipw2200-disallow-direct-scanning-when-device-is-down.patch
+drivers-net-wireless-tiacx-add-missing-include-linux-vmallocha.patch

 netdev fixes

+ppc32-fix-incorrect-pci-frequency-value.patch

 ppc32 update

+remove-include-asm-mips-riscos-syscallh.patch

 MIPS cleanup

+x86-handle-wsign-compare-in-bitops.patch

 Signedness fix

+i386-sparsemem-for-single-node-systems.patch
+allow-flatmem-to-be-disabled-when-only-sparsemem-is-implemented.patch

 x86 mm updates

+arm-ixdp425-setup-bug.patch

 ARM fix.

+m68knommu-enable_irq-disable_irq.patch
+m68knommu-remove-enable_irq_nosync.patch

 m68knommu updates

+cpuset-document-additional-features.patch

 cupsets documentation

+fix-missing-includes-for-2615-rc1.patch

 More preparatory work for header file untangling

-gregkh-pci-pci-driver-owner-removal-synclink_gt-fix.patch
+new-char-driver-synclink_gt-fix.patch

 Updated synclink_gt driver

+relayfs-decouple-buffer-creation-from-inode-creation.patch
+relayfs-export-relayfs_create_file-with-fileops-param.patch
+relayfs-add-relayfs_remove_file.patch
+relayfs-use-generic_ip-for-private-data.patch
+relayfs-remove-unused-alloc-destroy_inode.patch
+relayfs-add-documention-for-non-relay-files.patch
+relayfs-add-support-for-relay-files-in-other-filesystems.patch
+relayfs-add-documentation-on-relay-files-in-other-filesystems.patch
+relayfs-add-support-for-global-relay-buffers.patch
+relayfs-add-documentation-on-global-relay-buffers.patch
+relayfs-cleanup-change-relayfs_file_-to-relay_file_.patch
+relayfs-documentation-cleanup-remove-obsolete-info.patch

 relayfs updates

+use-ptrace_get_task_struct-in-various-places-2.patch
+use-ptrace_get_task_struct-in-various-places-2-powerpc-fix.patch
+use-ptrace_get_task_struct-in-various-places-2-x86_64-fix.patch

 ptrace cleanup

+udf-remove-bogus-inode-==-null-check-in-inode_bmap.patch

 UDF fixlet

+vgacon-fix-doublescan-mode.patch
+vgacon-workaround-for-resize-bug-in-some-chipsets.patch

 VGA console fixes

+fix-sysfs-access-to-module-parameters-with-config_modules=n.patch

 Make module parameters in sysfs work with CONFIG_MODULES=n

+permit-multiple-inclusion-of-linux-pagevech.patch

 include fix

+add-list_for_each_entry_safe_reverse.patch

 New list feature

+fix-some-problems-with-truncate-and-mtime-semantics.patch

 inode timestamping fixes

+fix-overflow-tests-for-compat_sys_fcntl64-locking.patch

 fcntl compat fix

+printk-return-value-fix-it.patch
+kmsg_write-dont-return-printk-return-value.patch

 Dink with the printk() return value

+writeback_control-flag-writepages.patch
+nfs-work-correctly-with-single-page-writepage-calls.patch

 NFS performance fix

+keys-permit-key-expiry-time-to-be-set.patch
+keys-discard-duplicate-keys-from-a-keyring-on-link.patch
+keys-permit-running-process-to-instantiate-keys.patch

 key management updates

+sigaction-should-clear-all-signals-on-sig_ign-not-just.patch

 Signal code fix

+spufs-the-spu-file-system-base.patch
+spufs-make-all-exports-gpl-only.patch
+spufs-switchable-spu-contexts.patch
+kernel-side-context-switch-code-for-spufs.patch
+spufs-add-spu-side-context-switch-code.patch
+spufs-cooperative-scheduler-support.patch

 Filesystem for accessing the POWER Cell processors

+perfmon2-reserve-system-calls.patch

 Reserve a bunch of syscalls for perfmon.

+tiny-add-bloat-o-meter-to-scripts.patch
+tiny-uninline-some-nameic-functions.patch
+tiny-uninline-some-openc-functions.patch
+tiny-uninline-some-inodec-functions.patch
+tiny-uninline-some-fslocksc-functions.patch
+tiny-trim-non-ipx-builds.patch
+tiny-make-x86-doublefault-handling-optional.patch
+tiny-make-id16-support-optional.patch
+tiny-configure-elf-core-dump-support.patch
+tiny-configurable-support-for-pci-serial-ports.patch

 A bunch of kernel footprint shrinking features.

+replace-inode_update_time-with-file_update_time-comments.patch

 Update replace-inode_update_time-with-file_update_time.patch

+add-compat_ioctl-methods-to-dasd-fix.patch

 Fix add-compat_ioctl-methods-to-dasd.patch

+parisc-remove-drm-compat-ioctls-handlers.patch
+parisc-implement-compat_ioctl-for-pa_perf.patch
+common-compat_sys_timer_create.patch

 More compat layer cleanups

-udf-fix-issues-reported-by-coverity-in-inodec.patch

 Obsolete

+keep-nfsd-from-exiting-when-seeing-recv-errors.patch

 knfsd fix

+scheduler-cache-hot-autodetect-fix.patch

 Fix CPU scheduler patch in -mm.

+reiser4-remove-rwx-perm-plugin.patch
+reiser4-fix-link_common.patch
+reiser4-fix-readlink.patch
+reiser4-add-crc-sendfile.patch
+reiser4-back-to-one-makefile.patch
+reiser4-rename-cluster-files.patch
+reiser4-crypt2cipher-rename.patch
+reiser4-lock-ordering-fix.patch
+reiser4-improved-comment.patch
+reiser4-try_capture_block-update.patch
+reiser4-fix-zeroing-in-crc-files.patch

 reiser4 updates

+cs5520-fix-return-value-of-cs5520_init_one.patch

 Fix a sound driver

+vesafb-drop-blank-hook.patch
+aty-remove-unnecessary-config_pci.patch

 fbdev fixes

-make-kmalloc-fail-for-swapped-size--gfp-flags.patch

 Dropped - we can detect this statically with sparse now

+slab-cache-shrinker-statistics-fix.patch

 Fix slab-cache-shrinker-statistics.patch

+mm-debug-dump-pageframes-on-bad_page.patch

 Extra memory management debugging

+turn-const-static-into-static-const.patch
+fix-sparse-using-plain-integer-as-null-pointer-warnings.patch

 Cleanups



All 598 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1/patch-list


