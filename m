Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbWBHGIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWBHGIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWBHGIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:08:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030551AbWBHGIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:08:07 -0500
Date: Tue, 7 Feb 2006 22:06:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc2-mm1
Message-Id: <20060207220627.345107c3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/


- Should also be available at:

	git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git

  browseable at:

	ftp://ftp.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git

  thanks to a script which Matthias Urlichs <smurf@smurf.noris.de> has
  prepared.  I haven't tried this, so please let us know how it goes.

- Patches were added and removed.  Nothing very exciting.




Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.


Changes since 2.6.16-rc1-mm5:


 linus.patch
 git-acpi.patch
 git-alsa.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cpufreq.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-serial.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 Git trees

-fix-rocketport-driver.patch
-cleanup-documentation-driver-model-overviewtxt.patch
-md-handle-overflow-of-mdu_array_info_t-size-better.patch
-md-assorted-little-md-fixes.patch
-md-make-sure-rdev-size-gets-set-for-version-1-superblocks.patch
-kernel-kprobesc-fix-a-warning-ifndef-arch_supports_kretprobes.patch
-kprobes-fix-deadlock-in-function-return-probes.patch
-fix-build-failure-in-recent-pm_prepare_-changes.patch
-documentation-updated-pci-error-recovery.patch
-fix-generic_fls64.patch
-fix-compilation-errors-in-maps-dc21285c.patch
-i386-cpu-hotplug-dont-access-freed-memory.patch
-drivers-acpi-hotkeyc-check-kmalloc-return-value.patch
-fix-ordering-on-requeued-request-drainage.patch
-block-request_queue-ordcolor-must-not-be-flipped-on-softbarrier.patch
-gregkh-driver-kobject_add-must-have-valid-name.patch
-gregkh-driver-kobject-don-t-oops-on-null-kobject.name.patch
-gregkh-driver-fix-compiler-warning-in-driver-core-for-config_hotplug-n.patch
-gregkh-driver-drivers-base-proper-prototypes.patch
-gregkh-driver-drm-classdev-cleanup.patch
-gregkh-driver-ib-sysfs-cleanup.patch
-gregkh-driver-fix-userspace-interface-breakage-in-power-state.patch
-gregkh-driver-spi-spi_butterfly-restore-lost-deltas.patch
-gregkh-driver-fix-uevent-buffer-overflow-in-input-layer.patch
-gregkh-driver-debugfs-trivial-comment-fix.patch
-gregkh-i2c-i2c-i801-i2c-patch-for-intel-ich8.patch
-gregkh-i2c-i2c-resurrect-i2c_smbus_write_i2c_block_data.patch
-gregkh-i2c-hwmon-lm77-negative-temp-fix.patch
-gregkh-i2c-i2c-sis96x-rename-documentation.patch
-gregkh-i2c-hwmon-w83792d-inline-register-access-functions.patch
-gregkh-i2c-i2c-algo-sibyte-module-param.patch
-gregkh-i2c-i2c-busses-use-array-size-macro.patch
-gregkh-i2c-hwmon-f71805f-add-documentation.patch
-gregkh-i2c-hwmon-f71805f-new-driver.patch
-gregkh-i2c-hwmon-it87-probe-i2c-0x2d-only.patch
-uli526x-warning-fix.patch
-kbuild-menu-hide-empty-netdevices-menu-when-net-is-disabled.patch
-sky2-fix-ethtool-ops.patch
-e100-remove-init_hw-call-to-fix-panic.patch
-8139too-fix-a-tx-timeout-watchdog-thread-against-napi-softirq-race.patch
-gianfar-fix-sparse-warnings.patch
-bonding-sparse-warnings-fix.patch
-dscc4-fix-dscc4_init_dummy_skb-check.patch
-remove-arch-ppc-syslib-ppc4xx_pmc.patch
-gregkh-pci-pci-hotplug-acpiphp-handle-dock-bridges.patch
-git-scsi-misc-fixup.patch
-drivers-scsi-qla2xxx-possible-cleanups.patch
-drivers-message-fusion-mptfcc-make-2-functions-static.patch
-gregkh-usb-usb-remove-the-obsolete-usb_midi-driver.patch
-gregkh-usb-usb-convert-a-bunch-of-usb-semaphores-to-mutexes-fix.patch
-uhci-hcd-fix-mistaken-usage-of-list_prepare_entry.patch
-gregkh-usb-usb-remove-usbcore-specific-wakeup-flags-fix.patch
-x86_64-defconfig-update.patch
-x86_64-config-unwind-info.patch
-x86_64-vsyscall-patch-xen.patch
-x86_64-nmi-kprobes.patch
-x86_64-pmtimer-variable-fallback.patch
-x86_64-apic-timer-only-with-cx.patch
-x86_64-apic-main-timer.patch
-x86_64-apic-main-timer-ati.patch
-x86_64-timer-resume.patch
-x86_64-swiotlb-dma32.patch
-x86_64-copy-memset-revert.patch
-x86_64-fix-the-node-cpumask-of-a-cpu-going-down.patch
-x86_64-remove-config-init-debug.patch
-x86_64-edac-default.patch
-x86_64-mempolicy-hpage.patch
-x86_64-srat-clear-node.patch
-x86_64-clock-compat.patch
-x86_64-garbage-values-in-file--proc-net-sockstat.patch
-x86_64-mark-two-routines-as-__cpuinit.patch
-x86_64-impossible-per-cpu-data-workaround.patch
-x86_64-even-more-cpuinit.patch
-x86_64-srat-check-size.patch
-x86_64-iommu-fallback.patch
-x86_64-switchto-no-kprobes.patch
-x86_64-apic-pmtimer-calibrate.patch
-x86_64-small-fix-for-cfi-annotations.patch
-x86_64-minor-odering-correction-to-dump_pagetable.patch
-x86_64-dont-record-local-apic-ids-when-they-are-disabled-in-madt.patch
-x86_64-bad-apic-ack.patch#X86_64-END
-remove-ms_noatime-mirroring-inside-xfs.patch
-i386-print-kernel-version-in-register.patch
-fix-value-computed-is-not-used-compile-warnings-with-gcc-41.patch
-s390-dasd-extended-error-reporting-module.patch
-s390-timer-interface-visibility.patch
-s390-compile-fix-missing-defines-in-asm-s390-ioh.patch
-s390-fix-compat-syscall-wrapper.patch
-s390-fix-to_channelpath-macro.patch
-jbd-fix-transaction-batching.patch
-tell-kallsyms_lookup_name-to-ignore-type-u-entries.patch
-include-asm-bitopsh-fix-more-0ul-size-typos.patch
-listh-dont-evaluate-macro-args-multiple-times.patch
-3c59x-collision-statistic-fix.patch
-sxc-warning-fixes.patch
-sbc-epx-does-not-check-claim-i-o-ports-it-uses-2nd-edition.patch
-sbc-epx-does-not-check-claim-i-o-ports-it-uses-2nd-edition-fix.patch
-parport-fix-printk-format-warning.patch
-dont-allow-users-to-set-config_broken=y.patch
-fix-i2o_scsi-oops-on-abort.patch
-someone-broke-reiserfs-v3-mount-options-this-fixes-it.patch
-parport_serial-printk-warning-fix.patch
-quota_v2-printk-warning-fixes.patch
-sxc-printk-warning-fixes.patch
-ufs-fix-oops-with-ufs1-type.patch
-ufs-fix-mount-time-hang.patch
-make-struct-d_cookie-dependable-on-config_profiling.patch
-rio-cleanups.patch
-fix-some-uclinux-breakage-from-the-tty-updates.patch
-oprofile-fixed-x86_64-incorrect-kernel-call-graphs.patch
-edac-config-cleanup.patch
-fix-char-vs-__s8-clash-in-ufs.patch
-fix-two-ext-uninitialized-warnings.patch
-umem-check-pci_set_dma_mask-return-value-correctly.patch
-drivers-isdn-sc-ioctlc-copy_from_user-size-fix.patch
-fs-jffs-intrepc-255-is-unsigned-char.patch
-parport-add-parallel-port-support-for-sgi-o2.patch
-v9fs-symlink-support-fixes.patch
-v9fs-v9fs_put_str-fix.patch
-v9fs-fix-corner-cases-when-flushing-request.patch
-normalize-timespec-for-negative-values-in-ns_to_timespec.patch
-parport-fix-documentation.patch
-parport-remove-dead-address-in-maintainers.patch
-cpuset-fix-sparse-warning.patch
-edac-use-c99-initializers-sparse-warnings.patch
-disable-per-cpu-intr-in-proc-stat.patch
-ext2-print-xip-mount-option-in-ext2_show_options.patch
-fix-o_direct-read-of-last-block-in-a-sparse-file.patch
-i2o-dont-disable-pci-device-if-it-is-enabled-before.patch
-i2o-fix-and-workaround-for-motorola-freescale-controller.patch
-fcntl-f_setfl-and-read-only-is_append-files.patch
-reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch
-reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix.patch
-txt-reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix-2.patch
-reduce-size-of-percpudata-and-make-sure-per_cpuobject-fix-3.patch
-jsm-update-for-tty-buffering-revamp.patch
-drivers-serial-jsm-cleanups.patch
-quota-remove-unused-sync_dquots_dev.patch
-lib-fix-bug-in-int_sqrt-for-64-bit-longs.patch
-ixj-fix-writing-silence-check.patch
-export-cpu-topology-by-sysfs.patch
-export-cpu-topology-by-sysfs-tidy.patch
-export-cpu-topology-by-sysfs-tidy-2.patch
-quota-fix-error-code-for-ext2_new_inode.patch
-fix-comment-to-synchronize_sched.patch
-compilation-of-kexec-kdump-broken-in-linux-2616-rc1.patch
-ipmi-mem_inout-=-intf_mem_inout.patch
-new-tty-buffering-locking-fix.patch
-uninline-__sigqueue_free.patch
-fat-replace-an-own-implementation-with-ll_rw_blockswrite.patch
-trivial-optimization-of-ll_rw_block.patch
-fat-fix-truncate-write-ordering.patch
-edac_mc-remove-include-of-versionh.patch
-fix-keyctl-usage-of-strnlen_user.patch
-ip2main-warning-fixes.patch
-i4l-warning-fixes.patch
-debugfs-hard-link-count-wrong.patch
-kconfig-detect-if-lintl-is-needed-when-linking-confmconf.patch
-kconfig-detect-if-lintl-is-needed-when-linking-confmconf-fix.patch
-vfs-ensure-lookup_continue-flag-is-preserved-by.patch
-coverity-udf-balloc-null-deref-fix.patch
-udf-fix-issues-reported-by-coverity-in-nameic.patch
-ipmi-fix-issues-reported-by-coverity-in-ipmi_msghandlerc.patch
-piix-ide-pata-patch-for-intel-ich8m.patch
-sem2mutex-drivers-ide.patch
-ia64-drop-arch-specific-ide-max_hwifs-definition.patch
-ide-kconfig-fixes.patch
-rocketpoint-1520-fails-clock-stabilization.patch
-stop-compactflash-devices-being-marked-as-removable.patch
-solve-false-positive-soft-lockup-messages-during-ide-init.patch
-ide-restore-support-for-aec6280m-cards-in-aec62xxc.patch
-quiet-ide-resource-reservation-messages.patch
-small-fixes-backported-to-old-ide-sis-driver.patch
-ide-disk-restore-missing-space-in-log-message.patch
-drivers-ide-ide-ioc-make-__ide_end_request-static.patch
-ide-set-latency-when-resetting-it821x-out-of-firmware-mode.patch
-always-enable-config_pdc202xx_force.patch
-sis5513-support-sis-965l.patch
-unshare-system-call-v5-documentation-file.patch
-unshare-system-call-v5-system-call-handler.patch
-unshare-system-call-v5-unshare-filesystem-info.patch
-unshare-system-call-v5-unshare-namespace.patch
-unshare-system-call-v5-unshare-vm.patch
-unshare-system-call-v5-unshare-files.patch
-unshare-system-call-v5-system-call-registration-for-i386.patch

 Merged

+8250-serial-console-update-uart_8250_port-ier.patch

 Serial fix

+alpha-pci-set-cache-line-size-for-cards-ignored.patch

 Alpha fix

+powerpc-fix-sound-driver-use-of-i2c.patch

 powerpc sound driver fix

+uml-define-jmpbuf-access-constants.patch

 Controversial UML patch.

+acpi-request-correct-fixed-hardware-resource-type-mmio-vs-i-o-port.patch
+acpi-add-acpi-to-motherboard-resources-in-proc-iomemport.patch
+acpi-update-asus_acpi-driver-registration.patch
+acpi-fix-sonypi-acpi-driver-registration.patch
+acpi-make-acpi_bus_register_driver-return-success-failure-not-device-count.patch
+acpi-simplify-scanc-coding.patch
+acpi-print-wakeup-device-list-on-same-line-as-label.patch
+acpi-fix-memory-hotplug-range-length-handling.patch
+hpet-fix-acpi-memory-range-length-handling.patch
+hpet-handle-multiple-acpi-extended_irq-resources.patch

 ACPI and HPET fixes

+gregkh-driver-kref-avoid-an-atomic-operation-in-kref_put.patch
+gregkh-driver-kobj_map-semaphore-to-mutex-conversion.patch
+gregkh-driver-aoe-support-multiple-aoe-listeners.patch
+gregkh-driver-aoe-don-t-request-ata-device-id-on-ata-error.patch
+gregkh-driver-aoe-update-version-to-22.patch

 Driver tree updates

-at76c651-dont-do-generic-__ilog2-on-mips.patch

 Dropped - this file is going away

+gregkh-i2c-hwmon-vt8231-temp-hyst.patch
+gregkh-i2c-hwmon-w83781d-real-time-alarms.patch
+gregkh-i2c-hwmon-w83627hf-document-reset-param.patch
+gregkh-i2c-it87-fix-oops-on-removal.patch
+gregkh-i2c-hwmon-vid-pentium-m.patch
+gregkh-i2c-hwmon-w83627ehf-use-attr-arrays.patch
+gregkh-i2c-hwmon-w83781d-document-alarm-bits.patch
+gregkh-i2c-hwmon-w83781d-no-reset-by-default.patch
+gregkh-i2c-i2c-core-optimize-mutex-use.patch
+gregkh-i2c-i2c-drop-frodo.patch
+gregkh-i2c-i2c-ite-name-init.patch
+gregkh-i2c-i2c-isp1301_omap-driver-cleanups.patch

 i2c tree updates

+add-logitech-mouse-type-99.patch

 Input device support

+drivers-net-tlanc-ifdef-config_pci-the-pci-specific-code.patch
+let-ipw21200-select-ieee80211.patch

 netdev fixes

+net-tipc-possible-cleanups.patch
+dev_put-dev_hold-cleanup.patch

 Net cleanups

+make-powerbook_sleep_grackle-static.patch

 cleanup

+serial-add-new-pci-serial-card-support.patch

 Serial device support

+gregkh-pci-acpiphp-handle-dock-stations.patch

 PCI tree update

+ib-dont-doublefree-pages-from-scatterlist.patch
+ipr-dont-doublefree-pages-from-scatterlist.patch
+osst-dont-doublefree-pages-from-scatterlist.patch

 scatter/gather list handling fixes

+drivers-scsi-flashpointc-remove-unused-things.patch
+drivers-scsi-flashpointc-remove-trivial-wrappers.patch
+drivers-scsi-flashpointc-remove-uchar.patch
+drivers-scsi-flashpointc-remove-ushort.patch
+drivers-scsi-flashpointc-remove-uint.patch
+drivers-scsi-flashpointc-remove-ulong.patch
+drivers-scsi-flashpointc-remove-ushort_ptr.patch
+drivers-scsi-flashpointc-use-standard-fixed-size-types.patch
+drivers-scsi-flashpointc-untypedef-struct-_sccb.patch
+drivers-scsi-flashpointc-untypedef-struct-sccbmgr_info.patch
+drivers-scsi-flashpointc-untypedef-struct-sccbmgr_tar_info.patch
+drivers-scsi-flashpointc-untypedef-struct-nvraminfo.patch
+drivers-scsi-flashpointc-untypedef-struct-sccbcard.patch
+drivers-scsi-flashpointc-lindent.patch
+drivers-scsi-flashpointc-dont-use-parenthesis-with-return.patch

 scsi driver cleanup

+gdth-add-execute-firmware-command-abstraction.patch

 scsi driver API modernisation

-areca-raid-linux-scsi-driver-updates.patch
-areca-raid-driver-arcmsr-cleanups.patch
-areca-raid-driver-arcmsr-update2.patch
-areca-raid-driver-arcmsr-update3-for-mm4.patch

 Folded into areca-raid-linux-scsi-driver.patch

+add-execute_in_process_context-api.patch

 Workqueue feature

+fix-wrong-context-bugs-in-scsi.patch

 Use it to fix scsi problems

+gregkh-usb-usb-add-new-device-ids-to-ldusb.patch
+gregkh-usb-usb-change-ldusb-s-experimental-state.patch
+gregkh-usb-usb-pl2303-leadtek-9531-gps-mouse.patch
+gregkh-usb-usb-sl811_cs-needs-platform_device-conversion-too.patch
+gregkh-usb-usb-storage-new-unusual_devs-entry.patch
+gregkh-usb-usb-storage-unusual_devs-entry.patch
+gregkh-usb-usb-add-zc0301-video4linux2-driver.patch
+gregkh-usb-usb-remove-obsolete_oss_usb_driver-drivers.patch
+gregkh-usb-usbhid-add-error-handling.patch
+gregkh-usb-usb-pegasus-linksys-usbvpn1-support-cleanup.patch
+gregkh-usb-usb-zero-driver-removed-duplicated-code.patch
+gregkh-usb-uhci-hcd-fix-mistaken-usage-of-list_prepare_entry.patch
+gregkh-usb-usbcore-fix-compile-error-with-config_usb_suspend-n.patch

 USB tree updates

+usb-zc0301-driver-updates.patch

 USB driver update

+x86_64-no_iommu-removal-in-pci-gartc.patch
+x86_64-gart-dma-merge.patch
+x86_64-gart-relax.patch
+x86_64-actively-synchronize-vmalloc-area-when-registering-certain-callbacks.patch
+x86_64-disable-sibling-calls.patch

 x86_64 tree updates

+slab-extract-setup_cpu_cache.patch
+slab-extract-setup_cpu_cache-tidy.patch
+slab-extract-setup_cpu_cache-tidy-tidy2.patch
+slab-cleanup.patch
+slab-remove-cachep-spinlock.patch
+thin-out-scan_control-remove-nr_to_scan-and-priority.patch

 Slab cleanups and simplifications

+selinux-simplify-sel_read_bool.patch

 Mutex conversion

+x86-smp-alternatives-fix-3.patch
+x86-smp-alternatives-tidy-2.patch

 Fix x86-smp-alternatives.patch some more

+x86-print-out-early-faults-via-early_printk.patch

 Better x86 diagnostics

+i386-fall-back-to-sensible-cpu-model-name.patch

 Fix (or break?) CPU model detection display

+compilation-fix-for-es7000-when-no-acpi-is-specified-in-config-i386.patch

 es7000 build fix

-x86_64-print-the-offset-in-hex-as-opposed-to-decimal-in-stack-dump.patch

 Dropped, unpopular.

+arch-x86_64-kernel-trapsc-ptrace_singlestep-oops.patch

 x86_64 preempt fix

-ia64-ioremap-check-efi-for-valid-memory-attributes-fix.patch

 Folded into ia64-ioremap-check-efi-for-valid-memory-attributes.patch

+swsusp-freeze-user-space-processes-first.patch
+suspend-update-documentation.patch
+suspend-make-progress-printing-prettier.patch
+swsusp-finally-solve-mysqld-problem.patch

 swsusp updates

+arch-s390-makefile-remove-finline-limit=10000.patch

 s390 cleanup

+only-allocate-percpu-data-for-possible-cpus.patch
+more-for_each_cpu-conversions.patch

 NR_CPUS -> for_each_cpu conversion (and similar)

+i386-instead-of-poisoning-init-zone-change-protection-fix.patch

 Fix i386-instead-of-poisoning-init-zone-change-protection.patch

+kill-include-linux-platformh-default_idle-cleanup.patch

 Cleanup

+rcutorture-tag-success-failure-line-with-module-parameters.patch

 rcutorture reporting fix

+cpuset-memory-spread-basic-implementation.patch
+cpuset-memory-spread-basic-implementation-fix.patch
+cpuset-memory-spread-page-cache-implementation-and-hooks.patch
+cpuset-memory-spread-slab-cache-implementation.patch
+cpuset-memory-spread-slab-cache-optimizations.patch
+cpuset-memory-spread-slab-cache-optimizations-tidy.patch
+cpuset-memory-spread-slab-cache-hooks.patch

 cpuset memory allocation policy feature

+remove-double-semicolons.patch
+isofs-remove-unused-debugging-macros.patch
+remove-ipmi-pm_power_off-redefinition.patch

 Cleanup

+tipar-fixes.patch

 Fix oopses in parport driver

+pidhash-kill-switch_exec_pids.patch
+choose_new_parent-remove-unused-arg-sanitize-exit_state-check.patch
+remove-add_parents-parent-argument.patch
+dont-use-remove_links-set_links-for-reparenting.patch
+kill-set_links-remove_links.patch
+reparent_thread-use-remove_parent-add_parent.patch

 Various fixes/cleanups to core task/pid management

-dont-touch-current-tasks-in-de_thread.patch
-choose_new_parent-remove-unused-arg-sanitize-exit_state-check.patch

 Dropped

+permit-dual-mit-gpl-licenses.patch
+led-class-documentation.patch
+led-add-led-class.patch
+led-add-led-class-tidy.patch
+led-add-led-class-tidy-fix.patch
+led-add-led-class-fix2.patch
+led-add-led-trigger-support.patch
+led-add-led-trigger-support-tidy.patch
+led-trigger-support-fixes.patch
+led-add-led-timer-trigger.patch
+led-add-led-timer-trigger-tidy.patch
+led-add-led-timer-trigger-fix.patch
+led-add-led-timer-trigger-fix-2.patch
+led-add-sharp-charger-status-led-trigger.patch
+led-add-sharp-charger-status-led-trigger-tidy.patch
+led-add-led-device-support-for-the-zaurus-corgi-and.patch
+led-add-led-device-support-for-the-zaurus-corgi-and-tidy.patch
+led-add-led-device-support-for-locomo-devices.patch
+led-add-led-device-support-for-locomo-devices-tidy.patch
+led-add-led-device-support-for-ixp4xx-devices.patch
+led-add-led-device-support-for-ixp4xx-devices-tidy.patch
+led-add-led-device-support-for-ixp4xx-devices-license-change.patch
+led-add-device-support-for-tosa.patch
+led-add-device-support-for-tosa-tidy.patch
+led-add-nand-mtd-activity-led-trigger.patch
+led-add-nand-mtd-activity-led-trigger-tidy.patch
+led-add-ide-disk-activity-led-trigger.patch
+led-add-ide-disk-activity-led-trigger-tidy.patch
+led-add-ide-disk-activity-led-trigger-fix.patch
+led-add-ide-disk-activity-led-trigger-fix-2.patch
+ensure-ide-taskfile-calls-any-driver-specific.patch
+led-add-ide-disk-activity-led-trigger-fix-3.patch

 LED drivers

-mutex-subsystem-add-include-asm-arm-mutexh-fix-2.patch

 Folded into mutex-subsystem-add-include-asm-arm-mutexh-fix.patch

-mutex-subsystem-synchro-test-module-fix.patch
-mutex-subsystem-synchro-test-module-fix-2.patch

 Folded into mutex-subsystem-synchro-test-module.patch

+time-reduced-ntp-rework-part-2-fix-2.patch
+time-clocksource-infrastructure-fix-clocksource_lock-deadlock-crs.patch
+time-generic-timekeeping-infrastructure-fix.patch
+time-generic-timekeeping-infrastructure-fix-crs.patch
+time-i386-clocksource-drivers-fix.patch
+time-i386-clocksource-drivers-fix-crs.patch
+x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad-crs.patch
+i386-dont-disable-the-tsc-on-single-node-numaqs.patch

 Fixes/updates to the time rework patches in -mm.

+kretprobe-kretprobe-booster-fixes.patch

 Improve kretprobe-kretprobe-booster.patch

-sched-modified-nice-support-for-smp-load-balancing-fix.patch
-sched-modified-nice-support-for-smp-load-balancing-fix-fix.patch

 Folded into sched-modified-nice-support-for-smp-load-balancing.patch

+sched-fix-group-power-for-allnodes_domains.patch

 CPU scheduler fix

+small-fixes-backported-to-old-ide-sis-driver.patch

 IDE fix

+from-drivers-video-kconfig-remove-unused-bus_i2c-option.patch
+nvidiafb-add-support-for-geforce4-mx-4000.patch
+nvidiafb-add-suspend-and-resume-hooks.patch
+nvidiafb-add-suspend-and-resume-hooks-tidy.patch
+nvidiafb-add-suspend-and-resume-hooks-fix.patch
+fbdev-framebuffer-driver-for-geode-gx.patch
+fbdev-video_setup-warning-fix.patch

 fbdev updates/drivers/fixes

-pidhash-temporal-debug-checks.patch
+pidhash-temporary-debug-checks.patch

 New version

+fs-nameic-make-lookup_hash-static.patch
+x86_64-unexport-ia32_sys_call_table.patch

 Changes to kernel->module API




All 842 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/patch-list


