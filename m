Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWDHKP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWDHKP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDHKPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:15:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964861AbWDHKPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:15:23 -0400
Date: Sat, 8 Apr 2006 03:14:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc1-mm2
Message-Id: <20060408031405.5e5131da.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm2/



Changes since 2.6.17-rc1-mm1:


 git-acpi.patch
 git-agpgart.patch
 git-arm.patch
 git-audit-master.patch
 git-cfq.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-ia64.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas-jg.patch
 git-splice.patch
 git-watchdog.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-frv.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

-selinux-build-fix.patch
-dmi-move-dmi_scanc-from-arch-i386-to-drivers-firmware.patch
-drm_pci-needs-dma-mappingh.patch
-spi-update-to-pxa2xx-spi-driver.patch
-driver-core-driver_bind-attribute-returns-incorrect-value.patch
-bus_add_device-losing-an-error-return-from-the-probe-method.patch
-spi-whitespace-fixes.patch
-spi-bounce-buffer-has-a-minimum-length.patch
-spi-add-david-as-the-spi-subsystem-maintainer.patch
-spi-renamed-bitbang_transfer_setup-to-spi_bitbang_setup_transfer.patch
-spi-busnum-==-0-needs-to-work.patch
-spi-devices-can-require-lsb-first-encodings.patch
-driver-core-fix-unnecessary-null-check-in-drivers-base-classc.patch
-drm-fix-issue-reported-by-coverity-in-drivers-char-drm-via_irqc.patch
-w1-exports.patch
-ia64-update-hp-csr-space-discovery-via-acpi.patch
-for_each_possible_cpu-ia64.patch
-fix-sed-regexp-to-generate-asm-offseth.patch
-netfilter-fix-fragmentation-issues-with-bridge-netfilter.patch
-64-bit-resources-core-changes.patch
-64-bit-resources-drivers-pci-changes.patch
-64-bit-resources-drivers-pci-changes-sparc32-fix.patch
-64-bit-resources-drivers-ide-changes.patch
-64-bit-resources-drivers-ide-changes-fix.patch
-64-bit-resources-drivers-media-changes.patch
-64-bit-resources-drivers-net-changes.patch
-64-bit-resources-drivers-pcmcia-changes.patch
-64-bit-resources-drivers-others-changes.patch
-64-bit-resources-sound-changes.patch
-64-bit-resources-arch-changes.patch
-64-bit-resources-arch-powerpc-changes.patch
-64-bit-resources-more-drivers-others-changes.patch
-64-bit-resources-more-sound-changes.patch
-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code-fix.patch
-pci-legacy-i-o-port-free-driver-update-documentation-pcitxt.patch
-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
-hid-corec-fix-input-irq-status-32-received-for-silvercrest-usb-keyboard.patch
-pm-print-name-of-failed-suspend-function.patch
-remove-kernel-power-pmcpm_unregister.patch
-convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch
-memory_hotplugh-cleanup.patch
-missing-n-in-sc1200wdt-driver.patch

 Merged into mainline or a subsystem tree

+task-make-task-list-manipulations-rcu-safe-fix-fix.patch

 Fix task-make-task-list-manipulations-rcu-safe.patch

+md-make-sure-64bit-fields-in-version-1-metadata-are-64-bit-aligned.patch

 md fix

+git-arm-build-fix.patch

 Fix git-arm.patch

+gregkh-driver-driver-core-fix-unnecessary-null-check-in-drivers-base-class.c.patch
+gregkh-driver-driver-core-driver_bind-attribute-returns-incorrect-value.patch
+gregkh-driver-pm-print-name-of-failed-suspend-function.patch
+gregkh-driver-dmi-move-dmi_scan.c-from-arch-i386-to-drivers-firmware.patch
+gregkh-driver-driver-core-bus-device-event-delay.patch
+gregkh-driver-spi-spi-whitespace-fixes.patch
+gregkh-driver-spi-spi-bounce-buffer-has-a-minimum-length.patch
+gregkh-driver-spi-add-david-as-the-spi-subsystem-maintainer.patch
+gregkh-driver-spi-renamed-bitbang_transfer_setup-to-spi_bitbang_setup_transfer-and-export-it.patch
+gregkh-driver-spi-devices-can-require-lsb-first-encodings.patch
+gregkh-driver-spi-busnum-0-needs-to-work.patch
+gregkh-driver-spi-update-to-pxa2xx-spi-driver.patch

 Driver tree updates

+drivers-media-video-bt866c-small-fixes.patch
+drivers-media-video-bt866c-small-fixes-2.patch
+drivers-media-video-ks0127c-code-cleanup.patch

 Fixes for avermedia-6-eyes-avs6eyes-support.patch

+gregkh-i2c-w1-make-w1-connector-notifications-depend-on-connector.patch
+gregkh-i2c-w1-use-mutexes-instead-of-semaphores.patch
+gregkh-i2c-w1-exports.patch
+gregkh-i2c-w1-cleanups.patch

 I2C tree updates

+ia64-always-map-vga-framebuffer-uc-even-if-it-supports-wb.patch

 VGA io mapping fixes

+pci-error-recovery-e100-network-device-driver.patch

 PCI error recovery in the e100 driver

+remove-drivers-net-hydrah.patch
+via-rhine-execute-bounce-buffers-code-on-rhine-i-only.patch
+e100-disable-interrupts-at-boot.patch

 netdev fixes

+remove-broken-and-unmaintained-sangoma-drivers.patch

 Remove dead WAN drivers

+powerpc-pseries-bugfix-balance-calls-to-pci_device_put.patch
+powerpc-pseries-clear-pci-failure-counter-if-no-new-failures.patch

 powerpc fixes

+serial-fix-uart_bug_txen-test.patch

 Serial fix

+gregkh-pci-dma-doc-updates.patch
+gregkh-pci-remove-kernel-power-pm.c-pm_unregister.patch
+gregkh-pci-pci-hotplug-tollhouse-hp-sgi-hotplug-driver-changes.patch
+gregkh-pci-acpiphp-configure-_prt-v3.patch
+gregkh-pci-acpiphp-hotplug-slot-hotplug.patch
+gregkh-pci-acpiphp-host-and-p2p-hotplug.patch
+gregkh-pci-acpiphp-turn-off-slot-power-at-error-case.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
+gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
+gregkh-pci-pci-64-bit-resources-core-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-pci-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-ide-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-media-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-net-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-pcmcia-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-others-changes.patch
+gregkh-pci-pci-64-bit-resources-sound-changes.patch
+gregkh-pci-pci-64-bit-resources-arch-changes.patch
+gregkh-pci-pci-64-bit-resources-arch-powerpc-changes.patch
+gregkh-pci-pci-64-bit-resources-more-drivers-others-changes.patch
+gregkh-pci-pci-64-bit-resources-more-sound-changes.patch
+gregkh-pci-pci-64-bit-resources-drivers-pci-changes-sparc32-fix.patch

 PCI tree updates

+fix-pciehp-driver-on-non-acpi-systems.patch

 PCI hotplug driver build fix

+pcmcia-remove-unneeded-forward-declarations.patch

 PCMCIA cleanup

+areca-raid-linux-scsi-driver-update5.patch

 Update areca-raid-linux-scsi-driver.patch

+git-splice-fixup.patch
+splice-warning-fix.patch

 Fix git-splice.patch

+gregkh-usb-usb-input-remove-kconfig-entries-of-old-touchscreen-drivers-in-favour-of-usbtouchscreen.patch
+gregkh-usb-usb-drivers-usb-core-remove-unused-exports.patch
+gregkh-usb-usb-ueagle-cosmetic.patch
+gregkh-usb-usb-ueagle-support-geode.patch
+gregkh-usb-usb-ueagle-null-pointer-dereference-fix.patch
+gregkh-usb-usb-ueagle-memory-leack-fix.patch
+gregkh-usb-usb-otg-hub-support-is-optional.patch
+gregkh-usb-usb-fix-gadget_is_musbhdrc.patch
+gregkh-usb-usb-net2280-short-rx-status-fix.patch
+gregkh-usb-usb-rndis_host-whitespace-comment-updates.patch
+gregkh-usb-usb-gadgetfs-highspeed-bugfix.patch
+gregkh-usb-usb-gadget-zero-poisons-out-buffers.patch
+gregkh-usb-usb-at91-usb-driver-supend-resume-fixes.patch
+gregkh-usb-usb-usbtest-scatterlist-out-data-pattern-testing.patch
+gregkh-usb-usb-g_ether-highspeed-conformance-fix.patch
+gregkh-usb-usb-linux-usb-net2280.h-common-definitions.patch
+gregkh-usb-usb-rename-ax8817x_func-to-asix_func-and-add-utility-functions-to-reduce-bloat.patch
+gregkh-usb-usb-keyspan-remote-bugfix.patch
+gregkh-usb-usb-uhci-don-t-track-suspended-ports.patch
+gregkh-usb-hid-core.c-fix-input-irq-status-32-received-for-silvercrest-usb-keyboard.patch
+gregkh-usb-usb-s3c2410-use-clk_enable-to-ensure-48mhz-to-ohci-core.patch
+gregkh-usb-usb-convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch

 USB tree updates

+pl2303-added-support-for-otis-dku-5-clone-cable.patch

 USB device support

+bcm43xx_phyc-fix-a-memory-leak.patch
+orinoco-remove-useless-cis-validation.patch
+orinoco-remove-pcmcia-audio-support-its-useless-for-wireless-cards.patch
+orinoco-remove-underscores-from-little-endian-field-names.patch
+orinoco-fix-truncating-commsquality-rid-with-the-latest-symbol-firmware.patch
+orinoco-remove-tracing-code-its-unused.patch
+orinoco-remove-debug-buffer-code-and-userspace-include-support.patch
+orinoco-symbol-card-supported-by-spectrum_cs-is-la4137-not-la4100.patch
+orinoco-optimize-tx-exception-handling-in-orinoco.patch
+orinoco-orinoco_xmit-should-only-return-valid-symbolic-constants.patch
+orinoco-replace-hermes_write_words-with-hermes_write_bytes.patch
+orinoco-dont-use-any-padding-for-tx-frames.patch
+orinoco-refactor-and-clean-up-tx-error-handling.patch
+orinoco-simplify-8023-encapsulation-code.patch
+orinoco-fix-bap0-offset-error-after-several-days-of-operation.patch
+orinoco-delay-fid-allocation-after-firmware-initialization.patch
+orinoco_pci-disable-device-and-free-irq-when-suspending.patch
+orinoco_pci-use-pci_iomap-for-resources.patch
+orinoco-support-pci-suspend-resume-for-nortel-plx-and-tmd-adaptors.patch
+orinoco-reduce-differences-between-pci-drivers-create-orinoco_pcih.patch
+orinoco-further-comment-cleanup-in-the-pci-drivers.patch
+orinoco-bump-version-to-015.patch

 Wireless driver updates

-mm-posix-memory-lock.patch

 Buggy, dropped.

+memory_hotplugh-cleanup.patch
+some-page-migration-fixups.patch
+page-migration-make-do_swap_page-redo-the-fault.patch
+slab-extract-cache_free_alien-from-__cache_free.patch
+overcommit-add-calculate_totalreserve_pages.patch
+overcommit-use-totalreserve_pages.patch
+overcomit-use-totalreserve_pages-for-nommu.patch
+page-flags-add-commentry-regarding-field-reservation.patch
+pg_uncached-is-ia64-only.patch
+mm-migratec-dont-export-a-static-function.patch

 Memory management updates

-x86-clean-up-subarch-definitions.patch

 Dropped - it broke UML.

+mpparse-prevent-table-index-out-of-bounds.patch
+mptspec-remove-duplicate-include.patch
+i386-move-smp-option-above-subarch-selection.patch

 x86 updates

+alpha-smp-boot-fixes.patch

 Alpha fix

+m32r-fix-cpu_possible_map-and.patch
+m32r-security-fix-of-getput_user-macros.patch
+remove-unused-prepare_to_switch-macro.patch
+m32r-remove-symbols-exported-twice.patch

 m32r updates

+add-gfp_nowait.patch
+uml-memory-hotplug-cleanups.patch
+uml-make-64-bit-cow-files-compatible-with-32-bit-ones.patch
+uml-safe-migration-path-to-the-correct-v3-cow-format.patch
+uml-fix-2-harmless-cast-warnings-for-64-bit.patch
+uml-request-format-warnings-to-gcc-for-appropriate-functions.patch
+uml-fix-format-errors.patch
+uml-fix-some-double-export-warnings.patch
+uml-fix-extern-vs-static-proto-conflict-in-tls-code.patch
+uml-prepare-fixing-compilation-output.patch
+uml-fix-critical-typo-for-tt-mode.patch
+uml-support-sparse-for-userspace-files.patch
+uml-move-outside-spinlock-call-not-needing-it.patch
+uml-fix-hang-on-run_helper-failure-on-uml_net.patch
+uml-fix-failure-path-after-conversion.patch
+uml-fix-big-stack-user.patch
+uml-local_irq_save-not-local_save_flags.patch
+uml-fix-parallel-make-early-failure-on-clean-tree.patch
+uml-avoid-warnings-for-diffent-names-for-an-unsigned-quadword.patch

 UML updates

+unify-pxm_to_node-and-node_to_pxm-update.patch

 Fix unify-pxm_to_node-and-node_to_pxm.patch

+fix-dcache-race-during-umount-fix.patch

 Fix fix-dcache-race-during-umount.patch

+sys_kexec_load-naming-fixups.patch
+process-accounting-take-original-leaders-start_time-in-non-leader-exec.patch
+remove-blkmtd.patch
+ptmx-fix-duplicate-idr_remove.patch
+tty-release_dev-remove-dead-code.patch
+mpbl0010-driver-sysfs-permissions-wide-open.patch
+last-dma_xbit_mask-cleanups.patch
+last-dma_xbit_mask-cleanups-fix.patch
+docs-laptop-modetxt-source-file-build.patch
+doc-fix-mtrr-userspace-programs-to-build-cleanly.patch
+fix-memory-barrier-docs-wrt-atomic-ops.patch
+fix-memory-barrier-docs-wrt-atomic-ops-update.patch
+improve-data-dependency-memory-barrier-example-in-documentation.patch
+update-contact-info-for-geert-uytterhoeven.patch
+keys-improve-usage-of-memory-barriers-and-remove-irq-disablement.patch
+kexec-update-maintainers.patch
+vgacon-make-vga_map_mem-take-size-remove-extra-use.patch
+parport-remove-duplicate-entry-for-netmos_9835.patch
+writeback-fix-range-handling.patch
+module-support-record-in-vermagic-ability-to-unload-a-module.patch
+#zlib_inflate-upgrade-library-code-to-a-recent-version.patch
+initramfs-cpio-unpacking-fix.patch
+kdump-enable-config_proc_vmcore-by-default.patch
+fix-cdrom-being-confused-on-using-kdump.patch
+fix-cdrom-being-confused-on-using-kdump-tweaks.patch
+inotify-check-for-null-inode-in-inotify_d_instantiate.patch
+kconfigdebug-set-debug_mutex-to-off-by-default.patch
+ipmi-fix-event-queue-limit.patch

 Misc

+drivers-isdn-gigaset-commonc-small-cleanups.patch
+isdn-gigaset-commonc-fix-a-memory-leak.patch
+isdn_drv_gigaset-should-select-not-depend-on-crc_ccitt.patch

 ISDN fixlets

+knfsd-locks-flag-nfsv4-owned-locks-cleanup.patch

 Fix knfsd-locks-flag-nfsv4-owned-locks.patch

+sched-improve-smpnice-load-balancing-when-load-per-task.patch

 smpnice fix

+sched_domain-handle-kmalloc-failure-fix.patch

 Fix sched_domain-handle-kmalloc-failure.patch

+coredump-optimize-mm-users-traversal.patch
+coredump-speedup-sigkill-sending.patch
+coredump-kill-ptrace-related-stuff.patch
+coredump-dont-take-tasklist_lock.patch

 Core dumping speedups and cleanups

+reiser4-have-get_exclusive_access-restart-transaction.patch
+reiser4-writeback-fix-range-handling.patch

 reiser4 updates

+video-aty-atyfb_basec-fix-an-off-by-one-error.patch
+atyfb-is-bust-on-sparc32.patch
+sparc32-vga-support.patch

 fbdev updates

+x86-kmap_atomic-debugging.patch

 Using KM_IRQ0 or KM_IRQ1 with local IRQs enabled is a bug: check for it.




All 692 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm2/patch-list


