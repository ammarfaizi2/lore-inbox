Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHaRFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHaRFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUHaRFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:05:42 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25235 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S264795AbUHaRAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:00:49 -0400
Message-ID: <4134AEF0.4050401@tmr.com>
Date: Tue, 31 Aug 2004 13:01:36 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lclbill
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm2/

Nothing particularly noteworthy here.  Some seriously bad scheduler
performance with SMT and HT was fixed up, as was the
fails-to-read-the-last-4k-of-a-file brown bag.



Changes since 2.6.9-rc1-mm1:


  linus.patch
  bk-acpi.patch
  bk-agpgart.patch
  bk-arm.patch
  bk-drm.patch
  bk-ia64.patch
  bk-ieee1394.patch
  bk-input.patch
  bk-kbuild.patch
  bk-mmc.patch
  bk-netdev.patch
  bk-pci.patch
  bk-pnp.patch
  bk-power.patch
  bk-serial.patch

  Latest versions of external trees

-auth_unix_lookup-oops-fix.patch
-auth_unix_lookup-oops-fix-fix.patch
-fix-show_mem-on-discontig-machines.patch
-fix-sysrq-support-in-sn_consolec.patch
-md-fix-problems-with-checksum-handling-in-md-superblocks.patch
-scheduler-profiling.patch
-consolidate-prof_cpu_mask.patch
-introduce-profile_pc.patch
-consolidate-hit-count-increments-in-profile_tick.patch
-move-profile_operations.patch
-make-private-profile-state-static.patch
-make-prof_buffer-atomic_t.patch
-remove-iseries-profiling.patch
-ipr-build-fix.patch
-megaraid-build-fix.patch
-reduce-size-of-struct-inode-on-64bit.patch
-ppc32-refactor-common-book-e-exception-handling-macros.patch
-ppc64-clean-up-unused-macro.patch
-fix-warnings-in-net-irda.patch
-add-a-few-might_sleep-checks.patch
-tmpfs-atomicity-fix.patch
-wireless-extension-v17-for-linus.patch
-wireless-drivers-update-for-we-17.patch
-ide-do-spin-up-for-all-platforms.patch
-dnotify-autofs-may-create-signal-restart-syscall-loop.patch
-mostly-remove-module_parm.patch
-defxx-trivial-updates.patch
-defxx-device-name-fixes.patch
-fix-mt-reparenting-when-thread-group-leader-dies.patch
-copy_mount_options-size-fix.patch
-improve-oprofile-on-many-way-systems.patch
-oprofile-ia64-performance-counter-support.patch
-split-timer-resources.patch
-reduce-casting-in-sysenterc.patch
-cast-page_offset-math-to-void-in-early-printk.patch
-call-virt_to_page-with-void-not-ul.patch
-vmalloc_fault-cleanup.patch
-dont-align-virt_to_page-args.patch
-include-asm-pageh-for-virt_to_page.patch
-task_vsize-locking-cleanup.patch
-task_vsize-locking-cleanup-warning-fix.patch
-o1-proc_pid_statm.patch
-o1-proc_pid_statm-fix.patch
-task-statm-no-procfs-fix.patch
-task-statm-reserved-fix.patch
-task-statm-dontcopy-fix.patch
-r8169-add-ethtool_opsget_regs_len-get_regs.patch
-r8169-per-device-receive-buffer-size.patch
-r8169-code-cleanup.patch
-r8169-enable-mwi.patch
-r8169-bump-version-number.patch
-r8169-sync-the-names-of-a-few-bits-with-the-8139cp-driver.patch
-r8169-comment-a-gcc-295x-bug.patch
-r8169-tx-checksum-offload.patch
-r8169-advertise-dma-to-high-memory.patch
-r8169-rx-checksum-support.patch
-r8169-vlan-support.patch
-sane-mlock_limit.patch
-lanana-maintainer-devicestxt-patch-1-2.patch
-lanana-maintainer-devicestxt-2.patch
-netmos-9805-parport-interface.patch
-s390-lcs-network-driver.patch
-s390-common-i-o-layer.patch
-s390-sclp-driver-changes.patch
-s390-qeth-network-driver.patch
-269-rc1-ifdef-fixes-for-drivers-isdn-hifax.patch
-269-rc1-ifdef-cleanup-for-sh64.patch
-269-rc1-ifdef-cleanup-for-cris-port.patch
-269-rc1-ifdef-cleanup-for-ppc.patch
-269-rc1-ifdef-cleanups-in-drivers-net.patch
-make-oom-killer-points-unsigned-long.patch
-dvb-pci_enable_device-fix.patch
-copying-unaligned-data-across-user-kernel-boundary.patch
-re-fix-pagecache-reading-off-by-one.patch
-re-fix-pagecache-reading-off-by-one-cleanup.patch
-waitqueue_debug-crapectomy.patch
-ftape-support-for-x86_64.patch
-keep-sparc32-config-consistent.patch
-fix-typo-in-bw2c.patch
-interrupt-is-enabled-before-it-should-be-when-kernel-is-booted.patch
-hvcs-hotplug-fixes.patch
-problem-with-sis900-unknown-phy.patch
-revert-ioc_eth3-pci_enable_device-changes.patch
-fix-hp100c-for-pci_enable_device-changes.patch
-x86_64-vs-select-fix.patch
-must_check-copy_to_user.patch
-copy_to_user-checking.patch
-sym_requeue_awaiting_cmds-uninit-var-fix.patch
-de4x5-idiocy-fix.patch

  Merged

+remove-function-prototype-inside-function.patch

  Warning fix

+make-assign_irq_vector-non-__init.patch

  Section fix

+platform-update-for-es7000.patch

  es7000 update

+fix-oops-with-nmi_watchdog=2.patch

  Fix an oops

+request_region-for-winbond-and-smsc-parport-drivers-fix.patch

  parport driver fix

+swsusp-error-do-not-oops-after-allocation-failure.patch

  swsusp oops fix

+pegasus-fixes.patch

  bk-netdev fixes

+fix-the-unnecessary-entropy-call-in-the-irq-handler.patch

  low-level IRQ handler fix

+update-ppc-maintainers-credits.patch
+ppc64-1-3-rework-ppc64-cpu-map-setup.patch
+ppc64-2-3-set-platform-cpuids-later-in-boot.patch
+ppc64-3-3-allocate-irqstacks-only-for-possible-cpus.patch
+ppc64-add-a-pfn_to_kaddr-function.patch

  PPC/PPC64 updates

+perfctr-prescott-fix.patch

  perfctr fix

+nicksched-sched_fifo-fix.patch
+sched-smtnice-fix.patch

  nicksched fixes

-jbd-recovery-latency-fix.patch
-journal_clean_checkpoint_list-latency-fix-fix.patch
-kjournald-smp-latency-fix.patch
-unmap_vmas-smp-latency-fix.patch
-__cleanup_transaction-latency-fix.patch
-prune_dcache-latency-fix.patch
-slab-latency-fix.patch
-get_user_pages-latency-fix.patch

  These worked OK, but were scrappy, and aren't going anywhere.

-fix-ide-probe-double-detection.patch

  Dropped

+hotplug-cpu-move-cpu_online_map-clear-to-__cpu_disable.patch

  hotplug CPU fix

+new-lost-sync-on-frames-error-in-konicawc.patch

  USB driver fix

+tiny-shmem-tmpfs-replacement.patch

  shmem/tmpfs impementation based on ramfs for tiny systems

-rss-ulimit-enforcement.patch

  Dropped, pending some evidence that it does useful things.

-implement-in-kernel-keys-keyring-management-update.patch
-implement-in-kernel-keys-keyring-management-update-build-fix.patch
-implement-in-kernel-keys-keyring-management-update-build-fix-2.patch
-key-management-patch-cleanup.patch

  Folded into implement-in-kernel-keys-keyring-management.patch

+make-key-management-code-use-new-the-error-codes.patch

  Use the new errno codes in the key management patches

-waitid-system-call-update.patch
-waitid-ia64-build-fix.patch
-waitid-system-call-cleanups.patch

  Folded into waitid-system-call.patch

+waitid-clear-fields.patch

  Clear some userspace fields in the waitid syscall

+cleanup-ptrace-stops-and-remove-notify_parent.patch
+cleanup-ptrace-stops-and-remove-notify_parent-extra.patch

  ptrace cleanups

-add-to-snd-intel8x0-ac97-quirk-list.patch

  Dropped - was already fixed

+kexec-ppc-kexec-kconfig-misplacement.patch

  Fix up kexec ppc Kconfig

-acpi-based-floppy-controller-enumeration.patch
+add-acpi-based-floppy-controller-enumeration.patch
+add-acpi-based-floppy-controller-enumeration-fix.patch

  New floppy-via-acpi patch

+cdrom-range-fixes.patch

  cdrom.c range checking fixes

+vsxxxaac-fixups.patch

  Fix this driver

+tioccons-security.patch

  make TIOCCONS root-only

+dont-oops-on-stripped-modules.patch

  Fix oops when loading stripped modules

+i386-bootmem-restrictions.patch

  Comment fixes

+use-page_to_nid.patch

  Cleanup

+fix-process-start-times.patch

  Maybe fix the reporting of process startup times

+tdfx-linkage-fix.patch

  fbdev driver fix

+propagate-pci_enable_device-errors.patch

  pci_enable_device handling fix

+netpoll-fix-unaligned-accesses.patch
+netpoll-revert-queue-stopped-change.patch
+netpoll-kill-config_netpoll_rx.patch
+netpoll-increase-napi-budget.patch
+netpoll-fix-up-trapped-logic.patch

  netpoll fixes

+make-i386-signal-delivery-work-with-mregparm.patch

  signal delivery fix

+fix-comment-in-include-linux-nodemaskh.patch

  Comment fix

+x86-build-issue-with-software-suspend-code.patch

  Build fix

+hpt366c-wrong-timings-used-since-268.patch

  IDE driver fix

+disambiguate-espc-clones.patch

  scsi device naming uniqueness

+fix-a-null-pointer-bug-in-do_generic_file_read.patch

  pagecache read API fix

+synclinkmp-transmit-eom-fix.patch

  synclink driver fix

+interrupt-driven-hvc_console-as-vio-device.patch

  HVCS driver update

+remove-ext2_panic-prototype.patch

  Dead code removal

+export-more-symbols-on-sparc32.patch

  sparc32 build fix

+fix-hardcoded-value-in-vsyscalllds.patch

  cleanup

+move-waitqueue-functions-to-kernel-waitc.patch
+standardize-bit-waiting-data-type.patch
+consolidate-bit-waiting-code-patterns.patch
+consolidate-bit-waiting-code-patterns-cleanup.patch
+eliminate-bh-waitqueue-hashtable.patch
+eliminate-inode-waitqueue-hashtable.patch

  Consolidate hashed waiting in VFS

+3c59x-pm-fix.patch

  Unconditionally enable 3c59x power management.  This broke things last 
time
  I tried it.

+serial-mpsc-driver.patch

  New serial driver

+fix-up-centaur-cpu-feature-enabling.patch

  Fix enabling of VIA CPU features.

+zr36067-driver-correct-i2c-algo-bit-dependency-in-kconfig.patch
+zr36067-driver-use-msleep-instead-of-schedule_timeout.patch
+zr36067-driver-correct-subfrequency-carrier.patch

  Fix this driver

+hfs-hfsplus-is-missing-sendfile.patch

  Make HFS support the loop driver

+mark-pcxx-as-broken.patch

  Dead driver

+fix-devfs-name-for-microcode-driver.patch

  devfs naming fix

+urandom-initialisation-fix.patch

  urandom driver startup fix

+topology-macro-safeness.patch

  Make some macros saner

+befs-load-default-nls-if-none-is-specified-in-mount-options.patch

  BeFS fix

+fbdev-fix-kernel-panic-from-fbio_cursor-ioctl.patch
+fbdev-fix-copy_to-from_user-in-fbmemcfb_read-write.patch

  fbdev fixes

+serial-add-support-for-non-standard-xtals-to-16c950-driver.patch

  Serial driver update

+completely-out-of-line-spinlocks--generic.patch
+completely-out-of-line-spinlocks--i386.patch
+completely-out-of-line-spinlocks--x86_64.patch

  Make spinlocks out-of-line on two architectures.   Needs an update.

+add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch

  Siemens MC45 PCMCIA GPRS card support

+v4l-bttv-add-sanity-check-bug-3309.patch

  bttv BUGfix

+allow-cluster-wide-flock.patch

  flock support for clustered machines

+kernel-forkc-add-missing-unlikely.patch

  microoptimisation

+stv0299-device-naming-fix.patch

  skystart2 naming fix

+s390-core-changes.patch
+s390-kernel-stack-options.patch
+s390-zfcp-host-adapater.patch

  s390 update

+isdn-build-fix.patch

  x86_64 build fix

+read_ldt-neglects-to-check-clear_user-return-value.patch

  Check a copy_*_user return value

+make-single-step-into-signal-delivery-stop-in-handler.patch

  x86_64 ptracing fix



number of patches in -mm: 288
number of changesets in external trees: 397
number of patches in -mm only: 274
total patches: 671



linus.patch

remove-function-prototype-inside-function.patch
   prio-tree: remove function prototype inside function

make-assign_irq_vector-non-__init.patch
   Make assign_irq_vector() non-__init

platform-update-for-es7000.patch
   platform update for ES7000

fix-oops-with-nmi_watchdog=2.patch
   Fix oops with nmi-watchdog=2

request_region-for-winbond-and-smsc-parport-drivers.patch
   request_region for winbond and smsc parport drivers

request_region-for-winbond-and-smsc-parport-drivers-fix.patch
   request_region-for-winbond-and-smsc-parport-drivers fix

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

bk-agpgart.patch

bk-arm.patch

bk-drm.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

bk-kbuild.patch

bk-mmc.patch

bk-netdev.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-serial.patch

mm.patch
   add -mmN to EXTRAVERSION

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
   -mm swsusp: make sure we do not return to userspace where image is on 
disk

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

sound-control-build-fix.patch
   sound/core/control.c build fix

i386_exception_notifiers.patch
   i386 exceptions notifier for kprobes

kprobes-base.patch
   kprobes base patch

kprobes-unset-fix.patch
   kprobes: fix things when CONFIG_KPROBES is unset

kprobes-func-args.patch
   Jumper Probes to provide function arguments

kprobes-build-fix.patch
   kprobes build fix

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

fix-the-unnecessary-entropy-call-in-the-irq-handler.patch
   Fix the unnecessary entropy call in the irq handler

make-tree_lock-an-rwlock.patch
   make mapping->tree_lock an rwlock

must-fix.patch
   must fix lists update
   must fix list update
   mustfix update
   must-fix update
   mustfix lists

update-ppc-maintainers-credits.patch
   Update PPC MAINTAINERS & CREDITS

ppc64-1-3-rework-ppc64-cpu-map-setup.patch
   ppc64: rework PPC64 cpu map setup

ppc64-2-3-set-platform-cpuids-later-in-boot.patch
   ppc64: set platform cpuids later in boot

ppc64-3-3-allocate-irqstacks-only-for-possible-cpus.patch
   ppc64: allocate irqstacks only for possible cpus

ppc64-add-a-pfn_to_kaddr-function.patch
   ppc64: add a pfn_to_kaddr() function

ppc64-reloc_hide.patch

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

lockmeter.patch
   lockmeter
   ia64 CONFIG_LOCKMETER fix

lockmeter-build-fix.patch
   lockmeter-build-fix

lockmeter-for-x86_64.patch
   lockmeter for x86_64

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
   ext3 block reservation patch set -- dynamically increase reservation 
window
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

ipr-ppc64-depends.patch
   Make ipr.c require ppc

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
   Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised 
counters
   perfctr update 6/6: misc minor cleanups
   perfctr update 3/6: __user annotations
   perfctr-cpus_complement-fix
   perfctr cpumask cleanup
   perfctr SMP hang fix

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
   Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help 
text

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

dev-zero-vs-hugetlb-mappings.patch
   /dev/zero vs hugetlb mappings.

hugetlbfs-private-mappings.patch
   hugetlbfs private mappings

truncate_inode_pages-latency-fix.patch
   truncate_inode_pages-latency-fix

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

add-ixdp2x01-board-support-to-cs89x0-driver.patch
   Add IXDP2x01 board support to CS89x0 driver

b44-add-47xx-support.patch
   b44: add 47xx support

allow-x86_64-to-reenable-interrupts-on-contention.patch
   Allow x86_64 to reenable interrupts on contention

fix-smm-failures-on-e750x-systems.patch
   fix SMM failures on E750x systems

serial-cs-and-unusable-port-size-ranges.patch
   serial-cs and unusable port size ranges

vlan-support-for-3c59x-3c90x.patch
   VLAN support for 3c59x/3c90x

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

new-lost-sync-on-frames-error-in-konicawc.patch
   "Lost sync on frames" error in konicawc module

iteraid.patch
   ITE RAID driver
   iteraid cleanup
   iteraid warning fix
   iteraid: pci_enable_device() for IRQ routing

igxb-speedup.patch
   igxb speedup

serialize-access-to-ide-devices.patch
   serialize access to ide devices

tiny-shmem-tmpfs-replacement.patch
   tiny shmem/tmpfs replacement

remove-unconditional-pci-acpi-irq-routing.patch
   remove unconditional PCI ACPI IRQ routing

add-pci_fixup_enable-pass.patch
   pci: add pci_fixup_enable pass

disable-atykb-warning.patch
   disable atykb "too many keys pressed" warning

x86_64-numa-emulation.patch
   x86_64: emulate NUMA on non-NUMA hardware

add-some-key-management-specific-error-codes.patch
   Add some key management specific error codes

implement-in-kernel-keys-keyring-management.patch
   implement in-kernel keys & keyring management
   keys build fix
   keys & keyring management update patch
   implement-in-kernel-keys-keyring-management-update-build-fix
   implement-in-kernel-keys-keyring-management-update-build-fix-2
   key management patch cleanup

make-key-management-code-use-new-the-error-codes.patch
   Make key management code use new the error codes

keys-keyring-management-keyfs-patch.patch
   keys & keyring management: keyfs patch

keyfs-build-fix.patch
   keyfs build fix

implement-in-kernel-keys-keyring-management-afs-workaround.patch
   implement-in-kernel-keys-keyring-management afs workaround

268-rc3-jffs2-unable-to-read-filesystems.patch
   jffs2 unable to read filesystems

qlogic-isp2x00-remove-needless-busyloop.patch
   QLogic ISP2x00: remove needless busyloop

using-get_cycles-for-add_timer_randomness.patch
   Using get_cycles for add_timer_randomness

waitid-system-call.patch
   waitid system call
   waitid system call update
   waitid-ia64-build-fix
   waitid-system-call cleanups

waitid-clear-fields.patch
   waitidL clear fields on WNOHANG early returns

fix-rusage-semantics.patch
   fix rusage semantics

cleanup-ptrace-stops-and-remove-notify_parent.patch
   cleanup ptrace stops and remove notify_parent

cleanup-ptrace-stops-and-remove-notify_parent-extra.patch
   cleanup-ptrace-stops-and-remove-notify_parent cleanup

serial-8250-optionally-skip-autodetection.patch
   Serial 8250 optionally skip autodetection

serial-8250-omap-support.patch
   Serial 8250 OMAP support

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

possible-dcache-bug-debugging-patch.patch
   Possible dcache BUG: debugging patch

fix-pid-hash-sizing.patch
   fix PID hash sizing

use-hlist-for-pid-hash.patch
   use hlist for pid hash

use-hlist-for-pid-hash-cache-friendliness.patch
   use hlist for pid hash: cache friendliness

amiga-partition-reading-fix.patch
   Amiga partition reading fix

kallsyms-data-size-reduction--lookup-speedup.patch
   kallsyms data size reduction / lookup speedup

prevent-memory-leak-in-devpts.patch
   Prevent memory leak in devpts

cdrom-range-fixes.patch
   cdrom signedness range fixes

vsxxxaac-fixups.patch
   vsxxxaa.c fixups

tioccons-security.patch
   TIOCCONS security

dont-oops-on-stripped-modules.patch
   Don't OOPS on stripped modules

i386-bootmem-restrictions.patch
   i386 bootmem restrictions

use-page_to_nid.patch
   use page_to_nid

fix-process-start-times.patch
   Fix reporting of process start times

tdfx-linkage-fix.patch
   tdfx linkage fix

propagate-pci_enable_device-errors.patch
   propagate pci_enable_device() errors

netpoll-fix-unaligned-accesses.patch
   netpoll: fix unaligned accesses

netpoll-revert-queue-stopped-change.patch
   netpoll: revert queue stopped change

netpoll-kill-config_netpoll_rx.patch
   netpoll: kill CONFIG_NETPOLL_RX

netpoll-increase-napi-budget.patch
   netpoll: increase NAPI budget

netpoll-fix-up-trapped-logic.patch
   netpoll: fix up trapped logic

make-i386-signal-delivery-work-with-mregparm.patch
   Make i386 signal delivery work with -mregparm

fix-comment-in-include-linux-nodemaskh.patch
   Fix comment in include/linux/nodemask.h

x86-build-issue-with-software-suspend-code.patch
   Fix x86 build issue with software suspend code

hpt366c-wrong-timings-used-since-268.patch
   hpt366.c: wrong timings

disambiguate-espc-clones.patch
   Disambiguate esp.c clones

fix-a-null-pointer-bug-in-do_generic_file_read.patch
   Fix a NULL pointer bug in do_generic_file_read()

synclinkmp-transmit-eom-fix.patch
   synclinkmp transmit eom fix

interrupt-driven-hvc_console-as-vio-device.patch
   interrupt driven hvc_console as vio device

remove-ext2_panic-prototype.patch
   remove ext2_panic() prototype

export-more-symbols-on-sparc32.patch
   export more symbols on sparc32

fix-hardcoded-value-in-vsyscalllds.patch
   Fix hardcoded value in vsyscall.lds

move-waitqueue-functions-to-kernel-waitc.patch
   move waitqueue functions to kernel/wait.c

standardize-bit-waiting-data-type.patch
   standardize bit waiting data type

consolidate-bit-waiting-code-patterns.patch
   consolidate bit waiting code patterns

consolidate-bit-waiting-code-patterns-cleanup.patch
   consolidate-bit-waiting-code-patterns-cleanup

eliminate-bh-waitqueue-hashtable.patch
   eliminate bh waitqueue hashtable

eliminate-inode-waitqueue-hashtable.patch
   eliminate inode waitqueue hashtable

3c59x-pm-fix.patch
   3c59x: enable power management unconditionally

serial-mpsc-driver.patch
   Serial MPSC driver

fix-up-centaur-cpu-feature-enabling.patch
   Fix up Centaur CPU feature enabling.

zr36067-driver-correct-i2c-algo-bit-dependency-in-kconfig.patch
   zr36067 driver - correct i2c-algo-bit dependency in Kconfig

zr36067-driver-use-msleep-instead-of-schedule_timeout.patch
   zr36067 driver - use msleep() instead of schedule_timeout()

zr36067-driver-correct-subfrequency-carrier.patch
   zr36067 driver - correct subfrequency carrier

hfs-hfsplus-is-missing-sendfile.patch
   hfs/hfsplus is missing .sendfile

mark-pcxx-as-broken.patch
   mark pcxx as broken

fix-devfs-name-for-microcode-driver.patch
   fix devfs name for microcode driver

urandom-initialisation-fix.patch
   urandom initialisation fix

topology-macro-safeness.patch
   make topology.h macros safer

befs-load-default-nls-if-none-is-specified-in-mount-options.patch
   BeFS: load default nls if none is specified in mount options

fbdev-fix-kernel-panic-from-fbio_cursor-ioctl.patch
   fbdev: fix kernel panic from FBIO_CURSOR ioctl

fbdev-fix-copy_to-from_user-in-fbmemcfb_read-write.patch
   fbdev: fix copy_to/from_user in fbmem.c:fb_read/write

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
   serial: add support for non-standard XTALs to 16c950 driver

completely-out-of-line-spinlocks--generic.patch
   Completely out of line spinlocks / generic

completely-out-of-line-spinlocks--i386.patch
   Completely out of line spinlocks / i386

completely-out-of-line-spinlocks--x86_64.patch
   Completely out of line spinlocks / x86_64

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
   Add support for Possio GCC AKA PCMCIA Siemens MC45

v4l-bttv-add-sanity-check-bug-3309.patch
   v4l/bttv: add sanity check (bug #3309)

allow-cluster-wide-flock.patch
   Allow cluster-wide flock

kernel-forkc-add-missing-unlikely.patch
   kernel/fork.c add missing unlikely().

stv0299-device-naming-fix.patch
   stv0299 device naming fix

s390-core-changes.patch
   s390: core changes

s390-kernel-stack-options.patch
   s390: kernel stack options.

s390-zfcp-host-adapater.patch
   s390: zfcp host adapater

isdn-build-fix.patch
   isdn debug build fix

read_ldt-neglects-to-check-clear_user-return-value.patch
   read_ldt() neglects to check clear_user() return value

make-single-step-into-signal-delivery-stop-in-handler.patch
   make single-step into signal delivery stop in handler



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

