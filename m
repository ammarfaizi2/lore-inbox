Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVLEHWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVLEHWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLEHWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 02:22:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751096AbVLEHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 02:22:07 -0500
Date: Sun, 4 Dec 2005 23:21:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5-mm1
Message-Id: <20051204232153.258cd554.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/


 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-audit.patch
 git-ia64.patch
 git-ieee1394.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-alsa-vs-git-pcmcia.patch
 git-scsi-misc-fixup.patch
 git-sas-jg.patch
 git-xfs.patch
 git-cryptodev.patch

 Subsystem trees

-ehci-hang-fix.patch -e1000-fix-for-dhcp-issue.patch
-acpi-fix-passive-thermal-management.patch
-acpi-leave-thermal-passive-cooling-when-machine-cooled-down.patch
-acpi-fix-null-deref-in-video-lcd-brightness.patch
-acpi-scan-revert-acpi_bus_find_driver-return-value-check.patch
-process-events-connector-uid_t-gid_t-size-issues.patch
-fix-crash-when-ptrace-poking-hugepage-areas.patch
-fix-rebooting-on-hp-nc6120-laptop.patch
-fix-swsusp-on-machines-not-supporting-s4.patch
pfnmap-fix-2615-rc3-driver-breakage.patch
-ppc-fix-floating-point-register-corruption.patch
-reiserfs-handle-cnode-allocation-failure-gracefully.patch
-hfsplus-dont-modify-journaled-volume.patch
-setting-irq-affinity-is-broken-in-ia32-with-msi-enabled.patch
-fbdev-cirrusfb-driver-cleanup-and-bug-fixes.patch
-fbdev-cg3fb-kconfig-fix.patch -git-acpi-build-fix-3.patch
-acpi-handle-fadt-20-xpmtmr-address-0-case.patch
-acpi-should-depend-on-not-select-pci.patch
-set-ibm-thinkpad-extras-to-default-n-in-kconfig.patch
-git-acpi-update-8250_acpi.patch -cpufreq-nforce2c-fix-u320-test.patch
-cpufreq-documentation-for-ondemand-and-conservative.patch
-cpufreq_conservative-ondemand-invert-meaning-of-ignore-nice.patch
-gregkh-driver-merge-hotplug-and-uevent-vio-fix.patch
-gregkh-driver-merge-hotplug-and-uevent-macio_asic-fix.patch
-kobject_uevent-config_netn-fix.patch
-broken-kref-counting-in-find-functions.patch
-gregkh-driver-kill-hotplug-word-from-driver-core-memory-fix.patch
-b44-missing-netif_wake_queue-in-b44_open.patch
-git-net-selinux-xfrmc-build-fix.patch
-b44-missing-netif_wake_queue-in-b44_open.patch
-git-net-selinux-xfrmc-build-fix.patch
-kill-libata-scsi_wait_req-usage-make-libata-compile-in-fix.patch
-mptfusion-bad-scsi-performance-fix.patch
-gregkh-pci-pci-driver-owner-removal-fix-aic94xx_init.patch
-aic94xx_init-needs-dma-mappingh.patch
-sas_task-needs-timerh.patch
-sas_event-needs-schedh.patch
-gregkh-usb-usb-documentation-update.patch
-gregkh-usb-additional-device-id-for-conexant-accessrunner-usb-driver.patch
-gregkh-usb-usb-fix-usb-suspend-resume-crasher.patch
-ipw2200-kzalloc-conversion-and-kconfig-dependency-fix.patch
-duplicate-ipw_debug-option-for-ipw2100-and-2200.patch
-ppc32-fix-incorrect-pci-frequency-value.patch
-ppc32-fix-treeboot-image-entrypoint.patch
-apm_emuc-fix-a-missing-check-on-misc_register-return-code.patch
-i386-x86_64-remove-preempt-disable-calls-in-lowlevel-ipi.patch
-x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is-fix.patch
-x86_64-fix-page-fault-from-show_trace.patch
-x86_64-fix-single-step-handling-for-32bit-processes.patch
-arm-sema_count-removal.patch
-arm-ixdp425-setup-bug.patch
-nfs-work-correctly-with-single-page-writepage-calls.patch

 Merged

+kprobes-reference-count-the-modules-when-probed-on-it.patch

 kprobes fix

+x86-fix-nmi-with-cpu-hotplug.patch

 x86 NMI fix

+kbuild-fixes.patch

 build system fixes

+ext3-fix-mount-options-documentation.patch

 ext3 documentation

+i386-x86-64-implement-fallback-for-pci-mmconfig-to-type1.patch
+x86_64-i386-correct-for-broken-mcfg-tables-on-k8-systems.patch
+i386-x86-64-fix-iounmap-lock-ordering.patch

 x86_64 update

+gregkh-driver-klist-fix-broken-kref-counting-in-find-functions.patch
+gregkh-driver-allow-overlapping-resources-for-platform-devices.patch
+gregkh-driver-kobject_uevent-config_net-n-fix.patch

 Driver tree updates

+gregkh-i2c-hwmon-lm85-adt7463-vrm-10.patch
+gregkh-i2c-hwmon-w83627thf-fix-vrm-and-vid.patch
+gregkh-i2c-hwmon-w83627thf-vid-documentation-update.patch
+gregkh-i2c-i2c-rtc8564-remove-duplicate-bcd-macros.patch
+gregkh-i2c-i2c-parport-barco-ltp-dvi.patch
+gregkh-i2c-hwmon-vt8231-new-driver.patch
+gregkh-i2c-i2c-drop-driver-flags-01-df-dummy.patch
+gregkh-i2c-i2c-drop-driver-flags-02-df-notify.patch
+gregkh-i2c-i2c-drop-driver-flags-03-flags.patch
+gregkh-i2c-i2c-client-use-01-drop-multiple-use-flag.patch
+gregkh-i2c-i2c-client-use-02-make-use-flag-default.patch
+gregkh-i2c-i2c-client-use-03-allow-multiple-use.patch
+gregkh-i2c-i2c-doc-porting-clients-update.patch
+gregkh-i2c-i2c-core-get-client-is-gone.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-01-core.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-02-chips.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-03-hwmon.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-04-macintosh.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-05-media.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-06-oss.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-07-ppc.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-08-acorn.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-09-video.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-10-arm.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-11-documentation.patch
+gregkh-i2c-i2c-drop-driver-owner-and-name-12-fix-debug.patch
+gregkh-i2c-i2c-dev-dynamic_class.patch

 i2c tree

+ieee1394-write-broadcast_channel-only-to-select-nodes.patch

 1394 fix

+git-libata-all-stat_sil-build-fix.patch

 Fix git-libata-all.patch

+mtd-onenand-genericc-needs-platform_deviceh-and-use-flash_platform_data.patch

 MTD fix

+gregkh-pci-shpchp-replace-pci_find_slot-with-pci_get_slot.patch
+gregkh-pci-shpchp-fix-improper-reference-to-slot-avail-regsister.patch
+gregkh-pci-shpchp-fix-improper-reference-to-mode-1-ecc-capability-bit.patch
+gregkh-pci-shpchp-fix-improper-mmio-mapping.patch
+gregkh-pci-shpchp-fix-improper-write-to-command-completion-detect-bit.patch
+gregkh-pci-shpchp-fix-improper-wait-for-command-completion.patch
+gregkh-pci-pci-irq.c-trivial-printk-and-dbg-updates.patch

 PCI tree updates

+arch-replace-pci_module_init-with-pci_register_driver.patch
+drivers-block-replace-pci_module_init-with-pci_register_driver.patch
+drivers-net-replace-pci_module_init-with-pci_register_driver.patch
+drivers-scsi-replace-pci_module_init-with-pci_register_driver.patch
+drivers-rest-replace-pci_module_init-with-pci_register_driver.patch

 PCI API cleanups

+git-alsa-vs-git-pcmcia.patch

 Try to fix clash between two subsystem trees

+gregkh-usb-usbserial-adds-missing-checks-and-bug-fix.patch
+gregkh-usb-usbserial-race-condition-fix.patch
+gregkh-usb-usb-input-touchkitusb-handle-multiple-packets.patch
+gregkh-usb-usb-don-t-allocate-dma-pools-for-pio-hcds.patch
+gregkh-usb-usb-gadget-file_storage-remove-volatile-declarations.patch
+gregkh-usb-usb-gadget-dummy_hcd-updates-to-hcd-state.patch
+gregkh-usb-usb-don-t-assume-root-hub-resume-succeeds.patch
+gregkh-usb-drivers-usb-misc-sisusbvga-sisusb.c-remove-dead-code.patch
+gregkh-usb-usb-mark-various-usb-tables-const.patch
+gregkh-usb-correct-ohci-pxa27x-suspend-resume-struct-confusion.patch
+gregkh-usb-usb-storage-add-unusual_devs-entry-for-nikon-coolpix-2000.patch
+gregkh-usb-usb-pl2303_update_line_status-data-length-fix.patch
+gregkh-usb-usb-ati_remote-use-time_before-and-friends.patch
+gregkh-usb-uhci-change-uhci_explen-macro.patch
 gregkh-usb-usb-gotemp.patch
+gregkh-usb-usbip.patch

 USB tree updates

+force-starget-scsi_level-in-usb-storage-scsigluec.patch
+usb-storage-add-debug-entry-for-report-luns.patch

 USB fixes

+x86_64-dma32-fix-mask.patch
+x86_64-shrink-additional-cpus.patch
+x86_64-hotplug-cpu-doc.patch
+x86_64-remove-hlt-counter.patch
+x86_64-constant-tsc-update.patch
+x86_64-cpufreq-constant-tsc.patch
+x86_64-hpet-fallback.patch
+x86_64-amd-cpuid-update.patch
+x86_64-check-ioapic.patch
+x86_64-apic-cmdline.patch
+x86_64-debug-stack.patch
+x86_64-hpet-overflow.patch
+x86_64-another-mb-for-smpbootc.patch
+x86_64-increase-MCE-bank-counts.patch
+x86_64-Remove-preempt-disable-calls-in-lowlevel-IPI.patch
+x86_64-Dont-IPI-to-offline-cpus-on-shutdown.patch
+x86_64-disable-LAPIC-completely-for-offline-CPU.patch
+x86_64-fix-single-step-handling-for-32bit-processes.patch
+x86_64-fix-page-fault-from-show_trace.patch
+x86_64-fls-in-asm-for-x86_64.patch

 x86_64 tree

+x86_64-cpufreq-constant-tsc-fix.patch
+x86_64-hpet-overflow-fix.patch

 Fix it

+slab-remove-nested-ifdef-config_numa.patch

 cleanup

+mm-bad_page-opt.patch
+mm-rmap-opt.patch
+mm-pfault-opt.patch
+mm-pcp-drain-tweak.patch
+drop-pagecache.patch
+vmscan-balancing-fix.patch

 MM tuneups

-the-second-param-of-addrconf_ifdown-in-function-addrconf_notify.patch

 Dropped - wrong.

+add-mips-dependency-for-dm9000-driver.patch
+ieee80211_crypt_tkip-depends-on-net_radio.patch

 netdev fixes

+keys-remove-key-duplication.patch

 mey management cleanup

+ppc32-remove-jumbo-member-from-ocp_func_emac_data.patch
+arch-ppc-kernel-idlec-dont-declare-cpu-variable-in-non-smp-kernels.patch
+ppc32-remove-unused-variables.patch

 ppc32 updates

+x86-missing-printk-newline-in-apic-boot-option-parser.patch
+i386-support-for-the-geode-cs5535-companion-chip.patch
+i386-support-for-the-geode-cs5535-companion-chip-tidy.patch
+cpu-frequency-display-in-proc-cpuinfo.patch
+x86-fls-in-asm.patch
+arch-i386-kernel-msrc-removed-unused-variable.patch

 x86 updates

-x86_64-div-by-zero-fix.patch

 Dropped - fixed by other means.

+swsusp-improve-freeing-of-memory-fix.patch
+swsusp-fix-enough_free_mem.patch

 software suspend fixes

-ext3_readdir-use-generic-readahead-fixes.patch

 Folded into ext3_readdir-use-generic-readahead.patch

-cpuset-change-marker-for-relative-numbering.patch

 Dropped by request

-dont-include-schedh-from-moduleh.patch

 Dropped - stuff broke

+rcu-file-use-atomic-primitives-fix.patch

 Fix rcu-file-use-atomic-primitives.patch

-writeback_control-flag-writepages.patch

 Dropped, but it'll come back.

+move-swiotlb-header-file-into-common-code-fix-2.patch

 Fix move-swiotlb-header-file-into-common-code.patch some more.

+printk-levels-for-spinlock-debug.patch
+printk-levels-for-i386-oops-code.patch
+drivers-connector-cn_procc-typos.patch
+aoe-type-cleanups.patch
+aoe-skb_check-cleanup.patch
+drivers-mfd-header-included-twice.patch
+documentation-small-applying-patchestxt-update.patch
+fs-remove-s_old_blocksize-from-struct-super_block.patch
+remove-unused-blkp-field-in-percpu_data.patch

 Little tweaks

+fix-handling-of-elf-segments-with-zero-filesize.patch

 ELF fix

+add-tainting-for-proprietary-helper-modules.patch

 Special-base ndiswrapper and driverloader: make them taint the kernel.

-mtd-dataflash-driver-spi-framework.patch
+mtd-dataflash-driver-spi-framework-2.patch

 New version

+spi-add-spi_driver-to-spi-framework.patch
+spi-ads7836-uses-spi_driver.patch
+spi-add-spi_bitbang-driver.patch
+spi-add-spi_bitbang-driver-fix.patch

 SPI update

-perfmon2-reserve-system-calls.patch

 Dropped - needs some review and discussion before we can proceed.

-ktimers-kt2.patch
-ktimers-kt2-export-mktime.patch
-ktimers-rounding-fix.patch
-ktimers-timespec-off-by-one.patch
+ktimers-move-div_long_long_rem-out-of-jiffiesh.patch
+ktimers-remove-duplicate-div_long_long_rem-implementation.patch
+ktimers-deinline-mktime-and-set_normalized_timespec.patch
+ktimers-clean-up-mktime-and-add-const-modifiers.patch
+ktimers-export-deinlined-mktime.patch
+ktimers-remove-unused-clock-constants.patch
+ktimers-cleanup-clock-constants-coding-style.patch
+ktimers-coding-style-and-whitespace-cleanup-timeh.patch
+ktimers-make-clock-selectors-in-posix-timers-const.patch
+ktimers-coding-style-and-white-space-cleanup-posix-timerh.patch
+ktimers-create-timespec_valid-macro.patch
+ktimers-check-user-space-timespec-in-do_sys_settimeofday.patch
+ktimers-introduce-nsec_t-type-and-conversion-functions.patch
+ktimers-introduce-ktime_t-time-format.patch
+ktimers-ktimer-core-code.patch
+ktimers-ktimer-documentation.patch
+ktimers-switch-itimers-to-ktimer.patch
+ktimers-remove-now-unnecessary-includes.patch
+ktimers-introduce-ktimer_nanosleep-apis.patch
+ktimers-convert-sys_nanosleep-to-ktimer_nanosleep.patch
+ktimers-switch-clock_nanosleep-to-ktimer-nanosleep-api.patch
+ktimers-convert-posix-interval-timers-to-use-ktimers.patch
+ktimers-simplify-ktimers-rearm-code.patch
+ktimers-split-timeout-code-into-kernel-ktimeoutc.patch
+ktimers-create-ktimeouth-and-move-timerh-code-into-it.patch
+ktimers-rename-struct-timer_list-to-struct-ktimeout.patch
+ktimers-convert-timer_list-users-to-ktimeout.patch
+ktimers-convert-ktimeouth-and-create-wrappers.patch
+ktimers-convert-ktimeoutc-to-ktimeout-struct-and-apis.patch
+ktimers-ktimeout-documentation.patch
+ktimers-rename-init_ktimeout-to-ktimeout_init.patch
+ktimers-rename-setup_ktimeout-to-ktimeout_setup.patch
+ktimers-rename-add_ktimeout_on-to-ktimeout_add_on.patch
+ktimers-rename-del_ktimeout-to-ktimeout_del.patch
+ktimers-rename-__mod_ktimeout-to-__mod_ktimeout.patch
+ktimers-rename-mod_ktimeout-to-ktimeout_mod.patch
+ktimers-rename-next_ktimeout_interrupt-to.patch
+ktimers-rename-add_ktimeout-to-ktimeout_add.patch
+ktimers-rename-try_to_del_ktimeout_sync-to.patch
+ktimers-rename-del_ktimeout_sync-to-del_ktimeout_sync.patch
+ktimers-rename-del_singleshot_ktimeout_sync-to.patch
+ktimers-rename-timer_softirq-to-timeout_softirq.patch
+ktimers-ktimeout-code-style-cleanups.patch
+ktimers-ktimeout-code-style-cleanups-fix.patch

 ktimer update.  I stil have no clue why it was necessary to rename timer_list to ktimeout.

+scheduler-cache-hot-autodetect-less-verbose.patch
+scheduler-cache-hot-autodetect-docs.patch

 Document and quieten scheduler-cache-hot-autodetect.patch

+ide-modalias-support-for-autoloading-of-ide-cd-ide-disk.patch

 IDE module aliases

+fbdev-sstfb-driver-cleanups.patch

 fbdev cleanup

+md-support-check-without-repair-of-raid10-arrays.patch
+md-allow-raid1-to-check-consistency.patch
+md-make-sure-read-error-on-last-working-drive-of-raid1-actually-returns-failure.patch
+md-auto-correct-correctable-read-errors-in-raid10.patch
+md-raid10-read-error-handling-resync-and-read-only.patch
+md-make-proc-mdstat-pollable.patch
+md-clean-up-page-related-names-in-md.patch
+md-convert-md-to-use-kzalloc-throughout.patch
+md-tidy-up-raid5-6-hash-table-code.patch
+md-convert-various-kmap-calls-to-kmap_atomic.patch
+md-convert-recently-exported-symbol-to-gpl.patch
+md-break-out-of-a-loop-that-doesnt-need-to-run-to-completion.patch
+md-remove-personality-numbering-from-md.patch
+md-fix-possible-problem-in-raid1-raid10-error-overwriting.patch
+md-change-case-of-raid-level-reported-in-sys-mdx-md-level.patch
+md-remove-inappropriate-limits-in-md-bitmap-configuration.patch

 RAID update

+docbook-add-gitignore-file.patch
+add-git-tree-for-docbook.patch
+net-make-function-pointer-argument-parseable-by-kernel-doc.patch
+docbook-fix-kernel-doc-comments.patch
+docbook-warn-for-missing-macro-parameters.patch

 docbook updates

-preempt-tracing.patch

 This broke.

+drivers-block-use-time_after-and-friends.patch
+nvidia-agp-use-time_before_eq.patch
+ide-tape-use-time_after-time_after_eq.patch
+drivers-net-use-time_after-and-friends.patch
+drivers-scsi-use-time_after-and-friends.patch

 jiffy haldning cleanups

+tty-layer-buffering-revamp-jsm-is-broken.patch

 Mark the JSM driver as broken - it needs redoing for the tty buffering revamp.

+drivers-replace-pci_module_init-with-pci_register_driver-in-mm.patch
+sound-replace-pci_module_init-with-pci_register_driver-in-mm.patch
+pci-schedule-removal-of-pci_module_init-was-re-patch.patch

 PCI API cleanups


All 950 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/patch-list

