Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUIGJN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUIGJN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbUIGJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:13:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:35493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267743AbUIGJKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:10:22 -0400
Date: Tue, 7 Sep 2004 02:08:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4
Message-Id: <20040907020831.62390588.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/

- Added Dave Howells' mysterious CacheFS.

- Various new fixes, cleanups and bugs, as usual.



 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-kbuild.patch
 bk-mmc.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-usb.patch

 Latest versions of external trees

-x86_64-waitid-syscall-number-fix.patch
-shmem-stubs-fix.patch
-sparc-alsa-fix.patch
-add_to_swap-suppress-oom-message.patch
-request_region-for-winbond-and-smsc-parport-drivers.patch
-es7000-more-mp-busses.patch
-fix-target_cpus-for-summit-subarch.patch
-ipr-build-fix.patch
-ppc-increase-max-auxv-entries.patch
-pin-the-kernel-stacks-slb-entry.patch
-ppc64-enable-debug_spinlock_sleep.patch
-ppc64-test-for-eeh-error-in-pci-config-read-path.patch
-ppc64-print-backtrace-in-eeh-code.patch
-ppc64-topdown-support.patch
-ppc64-topdown-support-arch-specific-get_unmapped_area.patch
-ppc64-setup-fw_features-before-init_early-calls-on-pseries.patch
-ppc64-make-use-of-batched-iommu-calls-on-pseries-lpars.patch
-ppc64-another-log-buffer-length-fix.patch
-ppc64-dynamically-allocate-emergency-stacks.patch
-ppc64-update-pseries_defconfig.patch
-ppc64-update-iseries_defconfig.patch
-ppc64-quieten-numa-boot-messages.patch
-ppc64-allocate-numa-node-data-node-locally.patch
-ppc64-cleanup-asm-processorh.patch
-ppc64-implement-page_is_ram.patch
-add-support-for-numa-discovery-on-amd-dual-core-to-x86-64.patch
-fix-boot_cpu_data-on-x86-64.patch
-increase-bus-apic-limits-on-x86-64.patch
-fix-argument-checking-in-sched_setaffinity.patch
-add-ixdp2x01-board-support-to-cs89x0-driver.patch
-new-lost-sync-on-frames-error-in-konicawc.patch
-fix-proc_symlink-warning-with-config_proc_fs=n.patch
-urandom-initialisation-fix.patch
-read_ldt-neglects-to-check-clear_user-return-value.patch
-read_ldt-neglects-checking-of-clear_user-return.patch
-make-single-step-into-signal-delivery-stop-in-handler.patch
-r8169-dac-support-fix.patch
-vm-swapout-throttling.patch
-fat-document-fix-update.patch
-nls-nls_cp932-fix.patch
-v4l-i2c-cleanups.patch
-v4l-i2c-tuner-modules-update.patch
-v4l-bttv-driver-update.patch
-v4l-saa7134-driver-update.patch
-pcxxc-bulid-fix.patch
-move-wait-ops-contention-case-completely-out-of-line.patch
-reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
-document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
-root-reservations-for-strict-overcommit.patch
-fix-the-barrier-ide-detection-logic.patch
-disable-colour-conversion-in-the-cpia.patch
-make-bad_page-print-all-of-page-flags.patch
-fix-compile-warning-in-ppc64-pmac_featurec.patch
-fix-compile-warnings-in-via-pmuc-for-config_pmac_pbook.patch
-stop-put_inode-abuse-in-vxfs.patch
-some-missing-statics-in-mm.patch
-remove-ptrinfo.patch
-remove-ptrinfo-fix.patch
-fix-compile-warning-in-rivafb-on-ppc.patch
-fix-drivers-net-cs89x0c-warning.patch
-announce-hpet-devices-claimed.patch
-silence-sn_console-driver-on-non-sgi-boxes.patch
-drivers-char-amiserialc-min-max-removal.patch
-drivers-char-epcac-min-max-removal.patch
-drivers-char-espc-min-max-removal.patch
-drivers-char-isicomc-min-max-removal.patch
-drivers-char-mxserc-min-max-removal.patch
-drivers-char-pcmcia-synclink_csc-min-max-removal.patch
-drivers-char-pcxxc-min-max-removal.patch
-drivers-char-riscom8c-min-max-removal.patch
-drivers-char-rocketc-min-max-removal.patch
-drivers-char-rocket_inth-min-max-removal.patch
-drivers-char-selectionc-min-max-removal.patch
-drivers-char-serial167c-min-max-removal.patch
-drivers-char-specialixc-min-max-removal.patch
-drivers-char-synclinkc-min-max-removal.patch
-drivers-char-synclinkmpc-min-max-removal.patch
-include-linux-isicomh-min-max-removal.patch
-drivers-tc-zsc-min-max-removal.patch
-ds1620-replace-schedule_timeout-with-msleep.patch
-dsp56k-replace-schedule_timeout-with-msleep.patch
-ec3104-replace-schedule_timeout-with-msleep.patch
-isicom-replace-schedule_timeout-with-msleep.patch
-nwflash-replace-schedule_timeout-with-msleep.patch
-pcwd-replace-schedule_timeout-with-msleep.patch
-synclink-replace-jiffies_from_ms-with-msecs_to_jiffies.patch
-add-msleep_interruptible-function-to-kernel-timerc.patch
-coda-fix-ifdefs-for-config_coda_fs_old_api.patch
-coda-add-sendfile-wrapper.patch
-sort-the-credits-file-properly-and-add-myself.patch
-cdu31a-replace-schedule_timeout-with-msleep.patch
-mcd-replace-schedule_timeout-with-msleep.patch
-radio-radio-maestro-replace-schedule_timeout-with-msleep.patch
-radio-radio-cadet-replace-schedule_timeout-with-msleep.patch
-radio-radio-aimslab-replace-while-schedule-with-msleep.patch
-radio-miropcm20-rds-replace-schedule_timeout-with-msleep.patch
-radio-radio-maxiradio-replace-schedule_timeout-with-msleep.patch
-saa7146_i2cc-use-msleep.patch
-radio-radio-sf16fmi-replace-schedule_timeout-with-msleep.patch
-radio-radio-sf16fmr2-replace-schedule_timeout-with-msleep.patch
-message-mptscsih-replace-schedule_timeout-with-msleep.patch
-message-i2o_core-replace-schedule_timeout-with-msleep.patch
-mtd-cfi_cmdset_0001-replace-schedule_timeout-with-msleep.patch
-update-parport-maintainers-entry.patch
-make-hugetlb-expansion-allocation-nowarn.patch
-update-parport-maintainers-entry.patch
-make-hugetlb-expansion-allocation-nowarn.patch

 Merged

+show-aggregate-per-process-counters-in-proc-pid-stat.patch

 /proc/pid/stat enhancements

+__set_page_dirty_nobuffers-mappings.patch

 Simplify this function

+pointer-dereference-before-null-check-in-acpi-thermal-driver.patch

 ACPI fix

+ksysfs-build-fix.patch

 bk-driver-code fix

+ppc-build-fix.patch
+ppc64-allow-sd_nodes_per_domain-to-be-overridden.patch
+ppc64-fix-hang-on-oprofile-shutdown.patch
+ppc64-fix-__rw_yield-prototype.patch
+ppc64-be-resilient-against-sysfs-pci-config-accesses.patch
+ppc64-cut-down-paca-footprint.patch
+ppc64-fix-boot-memory-reporting.patch
+ppc64-fix-power5-js20-smp-init.patch

 ppc[64] updates

+cleanup-fix-lost-ticks-handling-on-x86-64.patch
+lazy-tsss-i-o-bitmap-copy-for-x86-64.patch
+lazy-tsss-i-o-bitmap-copy-for-x86-64-fix.patch

 x86_64 updates

-lockmeter.patch
-lockmeter-build-fix.patch
-lockmeter-for-x86_64.patch

 lockmeter broke due to spinlock changes.  It'll be back.

-ipr-ppc64-depends.patch

 No longer needed

-iteraid.patch

 Dropped - Alan's driver handles ITE RAID drivers

-acpi-based-i8042-keyboard-aux-controller-enumeration.patch

 This was broken.

+make-key-management-use-syscalls-not-prctls.patch
+make-key-management-use-syscalls-not-prctls-build-fix.patch

 More key management work

+export-file_ra_state_init-again.patch
+cachefs-filesystem.patch
+cachefs-build-fix.patch
+cachefs-linkage-fix.patch
+cachefs-documentation.patch
+add-page-becoming-writable-notification.patch
+provide-a-filesystem-specific-syncable-page-bit.patch
+provide-a-filesystem-specific-syncable-page-bit-fix.patch
+make-afs-use-cachefs.patch

 cachefs

+ide-probe.patch

 IDE fix

-serial-8250-optionally-skip-autodetection.patch
-serial-8250-omap-support.patch

 Dropped - these were causing problems.

+cpusets-dont-export-proc_cpuset_operations.patch

 Remove unneeded export

+provide-a-filesystem-specific-syncable-page-bit-fix-2.patch

 Fix cachefs additions for standardize-bit-waiting-data-type.patch

+move-wait-ops-contention-case-completely-out-of-line.patch
+reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
+document-wake_up_bits-requirement-for-preceding-memory-barriers.patch

 More page/buffer_head wakeup rework.

+menuconfig-regex-search-dependencies.patch

 More work on the menuconfig-seatch-for-a-config-option feature.

+m32r-change-from-export_symbol_novers-to-export_symbol.patch
+m32r-modify-sys_ipc-to-remove-useless-ibcs2-support-code.patch
+m32r-add-elf-machine-code.patch
+m32r-modify-io-routines-for-m32700ut-cf-access.patch

 m32r architecture updates

+possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch

 More sysfs race fixes

+remove-ext2_panic.patch

 Remove dead code

+s390-export-copy_in_user.patch
+s390-minmax-removal-arch-s390-kernel-debugc.patch
+s390-packed-stack-vs-cpu-hotplug.patch
+s390-lcs-multicast-deadlock.patch

 S/390 update

+allow-i8042-register-location-override-2.patch

 i8042/ACPI interworking

+zlib_inflate-move-zlib_inflatesync-friends.patch
+zlib_inflate-make-zlib_inflate_trees_fixed-generate-the-table.patch
+ppc32-switch-arch-ppc-boot-to-lib-zlib_inflate.patch

 Compression library cleanups

+lazy-tsss-i-o-bitmap-copy-for-i386.patch

 ia32 IO bitmap copying speedup

+pnpbios-parser-bugfix.patch

 PNP fix

+ext3-dreference-of-sb-preceeds-check.patch
+unreachable-code-in-ext3_direct_io.patch

 ext3 bogons

+fbdev-speed-up-scrolling-of-tdfxfb.patch
+fbdev-ppc-crash-and-other-fixes-for-rivafb.patch
+fbcon-take-over-console-on-driver-registration.patch
+fbdev-clean-up-framebuffer-initialization.patch
+fbdev-add-module_init-and-fb_get_options-per-driver.patch

 fbdev update

+remove-bogus-memset-from-cpqfc-driver.patch
+hpt366-ptr-use-before-null-check.patch

 cleanups/fixes

+crypto-teac-xtea_encrypt-should-use-xtea_delta.patch

 Tea hashing fix

+fix-for-nforce2-secondary-ide-getting-wrong-irq.patch

 IDE probing fix (controversial)

+aio-dio-oops-fix.patch

 Fix AIO/direct-io oops

+riscom8-build-fix.patch
+cdu31a-build-fix.patch

 Compile fixes

+use-for_each_cpu-in-oprofile-code.patch
+fix-oprofile-vfree-warning-on-error.patch
+speed-up-oprofile-buffer-drain-code.patch
+speed-up-oprofile-buffer-drain-code-fix.patch

 oprofile fixes/speedups

+synclinkc-kernel-janitor-changes.patch

 Little fixes

+revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch

 Remove unused-by-GPL ia64 exports

+adfs-add-static.patch
+isofs-add-static.patch
+add-static-in-affs.patch
+add-static-in-afs.patch
+add-static-in-befs.patch

 Make some functions static

+correct-elf-section-used-for-out-of-line-spinlocks.patch

 Fix the out-of-line spinlock code

+tsc-synchronisation-cleanup.patch

 ia32 TSC code cleanup

+codemercs-io-warrior-support.patch

 Add in-kernel support for the out-of-kernel Codemercs driver

+fat-use-hlist_head-for-fat_inode_hashtable-1-4.patch
+fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
+fat-cache-lock-from-per-sb-to-per-inode-3-4.patch
+fat-the-inode-hash-from-per-module-to-per-sb-4-4.patch

 fatfs updates

+shmem-dont-slab_hwcache_align.patch
+shmem-inodes-and-links-need-lowmem.patch
+shmem-no-sbinfo-for-shm-mount.patch
+shmem-no-sbinfo-for-tmpfs-mount.patch
+shmem-avoid-the-shmem_inodes-list.patch
+shmem-rework-majmin-and-zero_page.patch
+shmem-copyright-file_setup-trivia.patch

 shmem updates

+lighten-mmlist_lock.patch

 Small VM speedup

+allocate-correct-amount-of-memory-for-pid-hash.patch

 Fix a memory waste

+misrouted-irq-recovery-take-2.patch
+misrouted-irq-recovery-take-2-fix.patch
+misrouted-irq-recovery-take-2-cleanup.patch

 Smarter handling of broken/misrouted IRQs on x86

+uml-avoid-using-elv_queue_empty.patch
+uml-avoid-forcing-use-of-the-no-op-scheduler.patch
+uml-correct-the-failure-path-in-start_io_thread.patch

 UML updates

+fix-address_spacei_mmap-comment.patch

 Fix a comment

+remove-mod_incdec_use_count-users-that-got-back-in.patch
+dont-mention-mod_incdec_use_count-in-documentation.patch

 Withdraw bogues MOD_INC_COUNT/MOD_DEC_COUNT instances.

+explicity-align-tss-stack.patch

 ia32 TSS stack alignment fix

+check-checksums-for-bnep.patch

 bluetooth fix

+remember-to-check-return-value-from-__copy_to_user-in.patch

 Check copy_to_user return value.


number of patches in -mm: 354
number of changesets in external trees: 410
number of patches in -mm only: 340
total patches: 750



All 354 patches:


linus.patch

distinct-tgid-tid-cpu-usage.patch
  distinct tgid/tid CPU usage

show-aggregate-per-process-counters-in-proc-pid-stat.patch
  show aggregate per-process counters in /proc/PID/stat

es7000-subarch-update.patch
  ES7000 subarch update

pkt_act-fix.patch
  pkt_act-fix

__set_page_dirty_nobuffers-mappings.patch
  __set_page_dirty_nobuffers mappings

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

bk-acpi.patch

acpi-compile-fix.patch
  acpi-compile-fix

acpi-x86_64-build-fix.patch
  acpi x86_64 build fix

bk-agpgart.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

bk-kbuild.patch

bk-mmc.patch

bk-netdev.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
  -mm swsusp: make sure we do not return to userspace where image is on disk

mm-swsusp-copy_page-is-harmfull.patch
  -mm swsusp: copy_page is harmfull

swsusp-fix-highmem.patch
  swsusp: fix highmem

swsusp-do-not-disable-platform-swsusp-because-s4bios-is-available.patch
  swsusp: do not disable platform swsusp because S4bios is available

swsusp-fix-default-powerdown-mode.patch
  swsusp: fix default powerdown mode

mark-old-power-managment-as-deprecated-and-clean-it-up.patch
  Mark old power managment as deprecated and clean it up

use-global-system_state-to-avoid-system-state-confusion.patch
  Use global system_state to avoid system-state confusion

swsusp-error-do-not-oops-after-allocation-failure.patch
  swsusp: do not oops after allocation failure

pegasus-fixes.patch
  pegasus.c fixes

pointer-dereference-before-null-check-in-acpi-thermal-driver.patch
  Pointer dereference before NULL check in ACPI thermal driver

ksysfs-build-fix.patch
  ksysfs build fix

network-packet-tracer-module-using-kprobes-interface.patch
  Network packet tracer module using kprobes interface.

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

ppc-build-fix.patch
  ppc build fix

ppc64-allow-sd_nodes_per_domain-to-be-overridden.patch
  ppc64: allow SD_NODES_PER_DOMAIN to be overridden

ppc64-fix-hang-on-oprofile-shutdown.patch
  ppc64: fix hang on oprofile shutdown

ppc64-fix-__rw_yield-prototype.patch
  ppc64: fix __rw_yield prototype

ppc64-be-resilient-against-sysfs-pci-config-accesses.patch
  ppc64: be resilient against sysfs PCI config accesses

ppc64-cut-down-paca-footprint.patch
  ppc64: cut down paca footprint

ppc64-fix-boot-memory-reporting.patch
  ppc64: fix boot memory reporting

ppc64-fix-power5-js20-smp-init.patch
  ppc64: fix POWER5/JS20 SMP init

cleanup-fix-lost-ticks-handling-on-x86-64.patch
  Cleanup & fix lost ticks handling on x86-64

lazy-tsss-i-o-bitmap-copy-for-x86-64.patch
  lazy TSS's I/O bitmap copy for x86-64

lazy-tsss-i-o-bitmap-copy-for-x86-64-fix.patch
  lazy-tsss-i-o-bitmap-copy-for-x86-64-fix

ppc64-reloc_hide.patch

factor-out-common-asm-hardirqh-code.patch
  factor out common <asm/hardirq.h> code

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

tty_io-hangup-locking.patch
  tty_io.c hangup locking

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix
  perfctr x86 init bug
  perfctr: K8 fix for internal benchmarking code
  perfctr x86 update

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup
  perfctr SMP hang fix

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

ext3-online-resize-patch.patch
  ext3: online resizing
  ext3-online-resize-warning-fix

nicksched.patch
  nicksched

nicksched-sched_fifo-fix.patch
  nicksched: SCHED_FIFO fix

sched-smtnice-fix.patch
  sched: SMT nice fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

pcmcia-implement-driver-model-support.patch
  pcmcia: implement driver model support

pcmcia-update-network-drivers.patch
  pcmcia: update network drivers

pcmcia-update-wireless-drivers.patch
  pcmcia: update wireless drivers

pcmcia-fix-eject-lockup.patch
  pcmcia: fix eject lockup

pcmcia-add-hotplug-support.patch
  pcmcia: add *hotplug support

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

packet-writing-credits.patch
  packet-writing: add credits

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support
  packet: remove #warning
  packet writing: door unlocking fix
  pkt_lock_door() warning fix
  Fix race in pktcdvd kernel thread handling
  Fix open/close races in pktcdvd
  packet writing: review fixups
  Remove pkt_dev from struct pktcdvd_device
  packet writing: convert to seq_file

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.
  Get blockdev size right in pktcdvd after switching discs

packet-writing-docco.patch
  packet writing documentation
  Trivial CDRW packet writing doc update

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device
  Subject: Re: 2.6.8-rc2-mm2
  control-pktcdvd-with-an-auxiliary-character-device-fix

simplified-request-size-handling-in-cdrw-packet-writing.patch
  Simplified request size handling in CDRW packet writing

fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
  Fix setting of maximum read speed in CDRW packet writing

packet-writing-reporting-fix.patch
  Packet writing reporting fixes

speed-up-the-cdrw-packet-writing-driver.patch
  Speed up the cdrw packet writing driver

packet-writing-avoid-bio-hackery.patch
  packet writing: avoid BIO hackery

cdrom-buffer-size-fix.patch
  cdrom: buffer sizing fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

pty_write-latency-fix.patch
  pty_write-latency-fix

create-nodemask_t.patch
  Create nodemask_t
  nodemask fix
  nodemask build fix

b44-add-47xx-support.patch
  b44: add 47xx support

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

scsi-qla2xxx-fix-inline-compile-errors.patch
  qla2xxx gcc-3.5 fixes

add-support-for-it8212-ide-controllers.patch
  Add support for IT8212 IDE controllers

i386-hotplug-cpu.patch
  i386 Hotplug CPU

hotplug-cpu-fix-apic-queued-timer-vector-race.patch
  Hotplug cpu: Fix APIC queued timer vector race

hotplug-cpu-move-cpu_online_map-clear-to-__cpu_disable.patch
  Hotplug cpu: Move cpu_online_map clear to __cpu_disable

igxb-speedup.patch
  igxb speedup

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

add-pci_fixup_enable-pass.patch
  pci: add pci_fixup_enable pass

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

add-some-key-management-specific-error-codes.patch
  Add some key management specific error codes

keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch
  keys: new error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64

implement-in-kernel-keys-keyring-management.patch
  implement in-kernel keys & keyring management
  keys build fix
  keys & keyring management update patch
  implement-in-kernel-keys-keyring-management-update-build-fix
  implement-in-kernel-keys-keyring-management-update-build-fix-2
  key management patch cleanup

make-key-management-code-use-new-the-error-codes.patch
  Make key management code use new the error codes

keys-permission-fix.patch
  keys: permission fix

keys-keyring-management-keyfs-patch.patch
  keys & keyring management: keyfs patch

keyfs-build-fix.patch
  keyfs build fix

implement-in-kernel-keys-keyring-management-afs-workaround.patch
  implement-in-kernel-keys-keyring-management afs workaround

support-supplementary-information-for-request-key.patch
  Support supplementary information for request-key

make-key-management-use-syscalls-not-prctls.patch
  Make key management use syscalls not prctls

make-key-management-use-syscalls-not-prctls-build-fix.patch
  make-key-management-use-syscalls-not-prctls build fix

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-build-fix.patch
  cachefs build fix

cachefs-linkage-fix.patch
  cachefs linkage fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

make-afs-use-cachefs.patch
  Make AFS use CacheFS

ide-probe.patch
  ide probe

268-rc3-jffs2-unable-to-read-filesystems.patch
  jffs2 unable to read filesystems

qlogic-isp2x00-remove-needless-busyloop.patch
  QLogic ISP2x00: remove needless busyloop

cleanup-ptrace-stops-and-remove-notify_parent.patch
  cleanup ptrace stops and remove notify_parent

cleanup-ptrace-stops-and-remove-notify_parent-extra.patch
  cleanup-ptrace-stops-and-remove-notify_parent cleanup

ptrace-api-preservation.patch
  ptrace userspace API preservation

nix-rusage_group.patch
  Remove RUSAGE_GROUP

i386-syscall-tracing-of-bogus-system-calls.patch
  i386 syscall tracing of bogus system calls

make-single-step-into-signal-delivery-stop-in-handler.patch
  make single-step into signal delivery stop in handler

jffs2-mount-options-discarded.patch
  JFFS2 mount options discarded

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

find_isa_irq_pin-should-not-be-__init.patch
  find_isa_irq_pin should not be __init

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-kexecppc.patch
  kexec: kexec.ppc

kexec-ppc-kexec-kconfig-misplacement.patch
  kexec ppc KEXEC Kconfig misplacement

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

inconsistent-kallsyms-fix.patch
  Inconsistent kallsyms fix

kallsyms-correct-type-char-in-proc-kallsyms.patch
  kallsyms: correct type char in /proc/kallsyms

cdrom-range-fixes.patch
  cdrom signedness range fixes

vsxxxaac-fixups.patch
  vsxxxaa.c fixups

tioccons-security.patch
  TIOCCONS security

fix-process-start-times.patch
  Fix reporting of process start times

fix-comment-in-include-linux-nodemaskh.patch
  Fix comment in include/linux/nodemask.h

x86-build-issue-with-software-suspend-code.patch
  Fix x86 build issue with software suspend code

hpt366c-wrong-timings-used-since-268.patch
  hpt366.c: wrong timings

disambiguate-espc-clones.patch
  Disambiguate esp.c clones

move-waitqueue-functions-to-kernel-waitc.patch
  move waitqueue functions to kernel/wait.c

standardize-bit-waiting-data-type.patch
  standardize bit waiting data type

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

consolidate-bit-waiting-code-patterns.patch
  consolidate bit waiting code patterns
  consolidate-bit-waiting-code-patterns-cleanup
  __wait_on_bit-fix

eliminate-bh-waitqueue-hashtable.patch
  eliminate bh waitqueue hashtable

eliminate-bh-waitqueue-hashtable-fix.patch
  wait_on_bit_lock() must test_and_set_bit(), not test_bit()

eliminate-inode-waitqueue-hashtable.patch
  eliminate inode waitqueue hashtable

move-wait-ops-contention-case-completely-out-of-line.patch
  move wait ops' contention case completely out of line

reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
  reduce number of parameters to __wait_on_bit() and __wait_on_bit_lock()

document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
  document wake_up_bit()'s requirement for preceding memory barriers

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

serial-mpsc-driver.patch
  Serial MPSC driver

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

allow-cluster-wide-flock.patch
  Allow cluster-wide flock

allow-cluster-wide-flock-update.patch
  Allow cluster-wide flock (update)

searching-for-parameters-in-make-menuconfig.patch
  searching for parameters in 'make menuconfig'

menuconfig-regex-search-dependencies.patch
  menuconfig: regex search + dependencies

filemap-read-fix.patch
  filemap read() fix

fix-f_version-optimization-for-get_tgid_list.patch
  fix f_version optimization for get_tgid_list

kernel-sysfs-events-layer.patch
  kernel sysfs events layer

add-smc91x-ethernet-for-lpd7a40x.patch
  add SMC91x ethernet for LPD7A40X

centralize-some-nls-helpers.patch
  centralize some nls helpers

remove-unused-sysctls-from-kernel-personalityc.patch
  remove unused sysctls from kernel/personality.c

m32r-base.patch
  m32r architecture

m32r-change-from-export_symbol_novers-to-export_symbol.patch
  m32r: change from EXPORT_SYMBOL_NOVERS to  EXPORT_SYMBOL

m32r-modify-sys_ipc-to-remove-useless-ibcs2-support-code.patch
  m32r: modify sys_ipc() to remove useless  iBCS2 support code

m32r-add-elf-machine-code.patch
  m32r: add ELF machine code

m32r-upgrade-to-2681-kernel.patch
  m32r: upgrade to 2.6.8.1 kernel

m32r-support-a-new-bootloader-m32r-g00ff.patch
  m32r: support a new bootloader "m32r-g00ff"

m32r-modify-io-routines-for-m32700ut-cf-access.patch
  m32r: modify IO routines for m32700ut CF  access

fs-compatc-rwsem-instead-of-bkl-around-ioctl32_hash_table.patch
  fs/compat.c: rwsem instead of BKL around ioctl32_hash_table

small-wait_on_page_writeback_range-optimization.patch
  small wait_on_page_writeback_range() optimization

vm-pageout-throttling.patch
  vm: pageout throttling

3w-xxxxc-queue-depth.patch
  3w-xxxx.c queue depth

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
  Possible race in sysfs_read_file() and sysfs_write_file()

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

md-correct-working_disk-counts-for-raid5-and-raid6.patch
  md: correct "working_disk" counts for raid5 and raid6

knfsd-calls-to-break_lease-in-nfsd-should-be-o_nonblocking.patch
  knfsd: calls to break_lease in nfsd should be O_NONBLOCKing

knfsd-return-eacces-instead-of-estale-for-certain-filehandle-lookup-failures.patch
  knfsd: return EACCES instead of ESTALE for certain filehandle lookup failures

knfsd-fix-incorrect-indentation-in-fh_verify.patch
  knfsd: fix incorrect indentation in fh_verify

nfsd4-support-acl_support-attribute.patch
  knfsd: nfsd4: Support acl_support attribute

knfsd-trivial-cleanup-of-nfs4statec.patch
  knfsd: trivial cleanup of nfs4state.c

nfsd4-could-leak-a-stateid-in-an-error-path.patch
  knfsd: nfsd4 could leak a stateid in an error path

nfsd4-postpone-release-of-stateowner-on-close.patch
  knfsd: nfsd4: postpone release of stateowner on CLOSE

nfsd4-store-current-tgid-instead-of-lockowner-hash-in-fl_pid.patch
  knfsd: nfsd4: store current->tgid instead of lockowner hash in fl_pid

knfsd-remove-redundant-initialization-in-nfsd4_lockt.patch
  knfsd: remove redundant initialization in nfsd4_lockt

remove-in-kernel-init_module-cleanup_module-stubs.patch
  Remove in-kernel init_module/cleanup_module stubs

remove-ext2_panic.patch
  remove ext2_panic()

s390-export-copy_in_user.patch
  s390: export copy_in_user

s390-minmax-removal-arch-s390-kernel-debugc.patch
  s390: minmax-removal arch/s390/kernel/debug.c

s390-packed-stack-vs-cpu-hotplug.patch
  s390: packed stack vs. cpu hotplug.

s390-lcs-multicast-deadlock.patch
  s390: lcs multicast deadlock

allow-i8042-register-location-override-2.patch
  allow i8042 register location override #2

zlib_inflate-move-zlib_inflatesync-friends.patch
  zlib_inflate: Move zlib_inflateSync & friends

zlib_inflate-make-zlib_inflate_trees_fixed-generate-the-table.patch
  zlib_inflate: Make zlib_inflate_trees_fixed(...) generate the table

ppc32-switch-arch-ppc-boot-to-lib-zlib_inflate.patch
  ppc32: Switch arch/ppc/boot to lib/zlib_inflate

lazy-tsss-i-o-bitmap-copy-for-i386.patch
  lazy TSS's I/O bitmap copy for i386

pnpbios-parser-bugfix.patch
  pnpbios parser bugfix

ext3-dreference-of-sb-preceeds-check.patch
  ext3 dreference of sb preceeds check.

unreachable-code-in-ext3_direct_io.patch
  unreachable code in ext3_direct_IO()

fbdev-speed-up-scrolling-of-tdfxfb.patch
  fbdev: Speed up scrolling of tdfxfb

fbdev-ppc-crash-and-other-fixes-for-rivafb.patch
  fbdev: PPC crash and other fixes for rivafb

fbcon-take-over-console-on-driver-registration.patch
  fbcon: take over console on driver registration

fbdev-clean-up-framebuffer-initialization.patch
  fbdev: Clean up framebuffer initialization

fbdev-add-module_init-and-fb_get_options-per-driver.patch
  fbdev: Add module_init() and fb_get_options() per driver

remove-bogus-memset-from-cpqfc-driver.patch
  Remove bogus memset from cpqfc driver

hpt366-ptr-use-before-null-check.patch
  hpt366 ptr use before NULL check.

crypto-teac-xtea_encrypt-should-use-xtea_delta.patch
  crypto: tea.c xtea_encrypt should use XTEA_DELTA

fix-for-nforce2-secondary-ide-getting-wrong-irq.patch
  Fix for NForce2 secondary IDE getting wrong IRQ

aio-dio-oops-fix.patch
  AIO/DIO oops fix

riscom8-build-fix.patch
  riscom8 build fix

use-for_each_cpu-in-oprofile-code.patch
  use for_each_cpu in oprofile code

fix-oprofile-vfree-warning-on-error.patch
  fix oprofile vfree warning on error

speed-up-oprofile-buffer-drain-code.patch
  Speed up oprofile buffer drain code

speed-up-oprofile-buffer-drain-code-fix.patch
  speed-up-oprofile-buffer-drain-code-fix

cdu31a-build-fix.patch
  cdu31a.c build fix

synclinkc-kernel-janitor-changes.patch
  synclink.c kernel janitor changes

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

adfs-add-static.patch
  adfs: add static

isofs-add-static.patch
  isofs: add static

correct-elf-section-used-for-out-of-line-spinlocks.patch
  Correct ELF section used for out of line spinlocks

tsc-synchronisation-cleanup.patch
  ia32: tsc synchronisation cleanup

add-static-in-affs.patch
  add static in affs

add-static-in-afs.patch
  add static in afs

add-static-in-befs.patch
  add static in befs

codemercs-io-warrior-support.patch
  Codemercs IO-Warrior support

fat-use-hlist_head-for-fat_inode_hashtable-1-4.patch
  FAT: use hlist_head for fat_inode_hashtable

fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
  FAT: rewrite the cache for file allocation table lookup

fat-cache-lock-from-per-sb-to-per-inode-3-4.patch
  FAT: cache lock from per sb to per inode

fat-the-inode-hash-from-per-module-to-per-sb-4-4.patch
  FAT: the inode hash from per module to per sb

shmem-dont-slab_hwcache_align.patch
  shmem: don't SLAB_HWCACHE_ALIGN

shmem-inodes-and-links-need-lowmem.patch
  shmem: inodes and links need lowmem

shmem-no-sbinfo-for-shm-mount.patch
  shmem: no sbinfo for shm mount

shmem-no-sbinfo-for-tmpfs-mount.patch
  shmem: no sbinfo for tmpfs mount?

shmem-avoid-the-shmem_inodes-list.patch
  shmem: avoid the shmem_inodes list

shmem-rework-majmin-and-zero_page.patch
  shmem: rework majmin and ZERO_PAGE

shmem-copyright-file_setup-trivia.patch
  shmem: Copyright file_setup trivia

lighten-mmlist_lock.patch
  lighten mmlist_lock

allocate-correct-amount-of-memory-for-pid-hash.patch
  Allocate correct amount of memory for pid hash

misrouted-irq-recovery-take-2.patch
  Misrouted IRQ recovery, take 2

misrouted-irq-recovery-take-2-cleanup.patch
  misrouted-irq-recovery-take-2 cleanup

misrouted-irq-recovery-take-2-fix.patch
  misrouted-irq-recovery-take-2 fix

uml-avoid-using-elv_queue_empty.patch
  uml: avoid using elv_queue_empty

uml-avoid-forcing-use-of-the-no-op-scheduler.patch
  uml: Avoid forcing use of the no-op scheduler

uml-correct-the-failure-path-in-start_io_thread.patch
  uml:  Correct the failure path in start_io_thread

fix-address_spacei_mmap-comment.patch
  fix address_space.i_mmap comment

remove-mod_incdec_use_count-users-that-got-back-in.patch
  remove MOD_{INC,DEC}_USE_COUNT users that got back in

dont-mention-mod_incdec_use_count-in-documentation.patch
  don't mention MOD_{INC,DEC}_USE_COUNT in Documentation/

explicity-align-tss-stack.patch
  explicity align tss->stack

check-checksums-for-bnep.patch
  Check checksums for BNEP

remember-to-check-return-value-from-__copy_to_user-in.patch
  __copy_to_user() check in cdrom_read_cdda_old()



