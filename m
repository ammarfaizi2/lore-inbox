Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVA2VOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVA2VOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVA2VOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 16:14:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:18896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261565AbVA2VLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 16:11:33 -0500
Date: Sat, 29 Jan 2005 13:11:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-mm2
Message-Id: <20050129131134.75dacb41.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm2/




Changes since 2.6.11-rc2-mm1:



 linus.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-usb.patch
 bk-watchdog.patch
 bk-xfs.patch

 Latest versions of external bk trees

-dib3000mc-build-fix.patch
-fbdev-screen-corruption-fix.patch
-mips-fixed-conflicting-types.patch
-oprofile-falling-back-on-timer-interrupt-mode.patch
-compat-ioctl-security-hook-fixup.patch
-ia64-acpi-build-fix.patch
-hda_intel-fix.patch
-mm-adjust-dirty-threshold-for-lowmem-only-mappings.patch
-mm-truncate-smp-race-fix.patch
-pcnet32-79c976-with-fiber-optic.patch
-add-omap-support-to-smc91x-ethernet-driver.patch
-netpoll-fix-napi-polling-race-on-smp.patch
-tun-tan-arp-monitor-support.patch
-atmel_cs-add-support-lg-lw2100n-wlan-pcmcia-card.patch
-smc91x-power-down-phy-on-suspend.patch
-e100-locking-up-netconsole.patch
-ppc32-add-defconfigs-for-85xx-boards-updated.patch
-ppc32-allow-usage-of-gen550-on-platforms-that-do-not-define.patch
-ppc32-missing-call-to-ioremap-in-pci_iomap.patch
-ppc32-fix-pci2-io-space-mapping-on-cds.patch
-ppc32-add-support-for-pegasos-machines.patch
-ppc64-limit-segment-tables-on-up-kernels.patch
-ppc64-xmon-data-breakpoints-on-partitioned-systems.patch
-ppc64-fix-in_be64-definition.patch
-ppc64-clear-msr_ri-earlier-in-syscall-exit-path.patch
-ppc64-replace-schedule_timeout-in-iseries_pci_reset.patch
-ppc64-replace-schedule_timeout-in-pseries_cpu_die.patch
-ppc64-replace-schedule_timeout-in-__cpu_up.patch
-ppc64-replace-schedule_timeout-in-die.patch
-ppc64-trivial-cleanup-eeh_region.patch
-ppc64-sparse-fixes-for-cpu-feature-constants.patch
-ppc64-use-kref-for-device_node-refcounting.patch
-ppc64-allow-eeh-to-be-disabled.patch
-ppc64-disable-some-boot-wrapper-debug.patch
-ppc64-problem-disabling-sysvipc.patch
-ppc64-enable-virtual-ethernet-and-virtual-scsi.patch
-x86-no-interrupts-from-secondary-cpus-until-officially-online.patch
-x86-remove-unused-function.patch
-x86_64-remove-centaur-mtrr-support.patch
-x86_64-remove-duplicated-includes.patch
-x86_64-enlarge-northbridge-numa-scan-mask.patch
-x86_64-remove-earlyprintk-help.patch
-x86_64-speed-up-suspend.patch
-h8300-fix-warning.patch
-h8300-makefile-update.patch
-swsusp-comment-fix.patch
-kill-softirq_pending.patch
-kill-softirq_pending-fix.patch
-clean-up-uts_release-usage.patch
-3c59x-ethtool-provide-nic-specific-stats.patch
-ext2-ext3-block-allocator-startup-fix.patch
-ext3-quota-leak-fix.patch
-ext3-ea-no-lock-needed-when-freeing-inode.patch
-ext3-ea-set-the-ext3_feature_compat_ext_attr-for-in-inode-xattrs.patch
-ext3-ea-documentation-fix.patch
-ext3-ea-fix-i_extra_isize-check.patch
-ext3-ea-disallow-in-inode-attributes-for-reserved-inodes.patch
-ext3-fix-ea-in-inode-default-acl-creation.patch
-ext2-ext3-acls-remove-the-number-of-acl-entries-limit.patch
-i810_audio-offset-lvi-from-civ-to-avoid-stalled-start.patch
-configurable-delay-before-mounting-root-device.patch
-fs-mbcachec-remove-an-unused-wait-queue-variable.patch
-device-mapper-fix-mirror-log-type-module-ref-count.patch
-device-mapper-remove-unused-bs_bio_init.patch
-device-mapper-add-presuspend-hook.patch
-device-mapper-optionally-bypass-a-bdget.patch
-device-mapper-fix-tb-stripe-data-corruption.patch
-arm26-new-maintainer-of-archimedes-floppy-and-hard-disk-drivers.patch
-problems-disabling-sysctl.patch
-genhd-rename-device_init.patch
-infiniband-core-compat_ioctl-conversion-minor-fixes.patch
-infiniband-mthca-more-arbel-mem-free-support.patch
-infiniband-mthca-implement-modifying-port-attributes.patch
-infiniband-core-fix-port-capability-enums-bit-order.patch
-infiniband-mthca-dont-write-ecr-in-msi-x-mode.patch
-infiniband-mthca-pass-full-process_mad-info-to-firmware.patch
-infiniband-mthca-optimize-event-queue-handling.patch
-infiniband-mthca-test-irq-routing-during-initialization.patch
-infiniband-ipoib-remove-uses-of-yield.patch
-infiniband-core-add-issm-userspace-support.patch
-infiniband-mthca-clean-up-ioremap-request_region-usage.patch
-infiniband-mthca-remove-x86-sse-pessimization.patch
-pcmcia-tcic-eleminate-deprecated-check_region.patch
-pcmcia-i82365-use-config_pnp-instead-of-__isapnp__.patch
-pcmcia-i82092-fix-checking-of-return-value-from-request_region.patch
-pcmcia-socket-acregion-are-unused.patch
-pcmcia-use-unsigned-long-for-io-port-address.patch
-videotext-ioctls-changed-to-use-_io-macros.patch
-video-arv-remove-casts.patch
-video-w9966-remove-casts.patch
-video-zr36120-remove-casts.patch
-v4l-video-buf-update.patch
-v4l2-tuner-api-update.patch
-v4l-tuner-update.patch
-v4l-add-tveeprom-module.patch
-v4l-tvaudio-update.patch
-v4l-bttv-ir-input-driver-update.patch
-v4l-bttv-update.patch
-v4l-saa7134-module.patch
-radeonfb-set-accelerator-id.patch
-vesafb-change-return-error-id.patch
-intelfb-workaround-for-830m.patch
-fbcon-save-blank-state-last.patch
-backlight-fix-compile-error-if-config_fb-is-unset.patch
-matroxfb-fb_matrox_g-kconfig-changes.patch
-include-type-information-as-module-info-where-possible.patch
-fix-architecture-names-in-hugetlbpagetxt.patch
-i386-rebootc-cleanups.patch
-mm-filemapc-make-a-function-static.patch

 Merged

+alpha-nodemask-build-fix.patch
+alpha-pgd_index-warning-fix.patch

 Alpha build fixes

+pnp-64bit-warning-fix.patch

 Fix a warning

+ftape-syntax-error.patch
+kobject-build-fix.patch
+crypto-test-vector-fix.patch

 Other build fixes

+ptracelast_siginfo-also-needs-tasklist_lock.patch

 ptrace locking fix

+random-overflow-fix.patch

 random driver fix

+ext2-quota-leak-fix.patch

 ext2 acl+qouta fix

+irq_affinity-fix-build-when-config_proc_fs=n.patch

 build fix

+fix-audit-skb-leak-on-congested-netlink-socket.patch

 net leak fix

+some-minor-cleanups-for-audit_log_lost-messages.patch

 cleanups

+wait_for_completion-api-extension-addition-fixes.patch

 Fix the new wait_for_completion stuff

+task_size-is-variable.patch
+use-mm_vm_size-in-exit_mmap.patch

 Fixes for recent TASK_SIZE changes (these are still in flux)

+rest_init-local-irq-fix.patch

 Fix scheduler race

+ppc32-back-out-idle-patch-for-non-powersaving-cpus.patch

 Back out earlier fix for the above scheduler race

+ppc32-updated-pegasos-support.patch

 ppc32 update

+i810_audio-offset-lvi-from-civ-to-avoid-stalled-start-fix.patch

 Comment fix

+ia64-acpi-build-fix.patch

 ia64 build fix

+driver-model-fix-u32-vs-pm_message_t-in-oss.patch

 more driver-model type safety fixes

+typo-in-pci_scan_bus_parented.patch

 Fix a tpyo.

+logitech-cordeless-desktop-keyboard-fails-to-report-class-descriptor.patch

 input driver fix

+mm-fix-several-oom-killer-bugs-fix.patch

 Prevent the oom-killer from getting stuck on the X server

+make-used_math-smp-safe-mips-fix.patch

 mips fix

+make-slab-use-alloc_pages-directly.patch

 slab speedup

+page_cache_readahead-unneeded-prev_page-assignments.patch
+cleanup-ahead-window-calculation.patch
+blockable_page_cache_readahead-cleanup.patch
+blockable_page_cache_readahead-cleanup-fix.patch

 readahead cleanups

+vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch

 vmscan accuracy improvement

+fix-mincore-cornercases-overflow-caused-by-large-len.patch

 mincore() bounds fixes

+use-datacs-in-smc91x-driver.patch
+remove-bogus-exports-in-ppp.patch

 net updates

+ppc32-mv64x60-updates.patch
+ppc32-katana-update.patch
+ppc32-ev64260-update.patch
+ppc32-cpci690-update.patch
+ppc32-perfctl-ppc-fix-duplicate-mmcr0-define.patch
+ppc32-stx-gp3-port.patch
+ppc32-fix-via-ide-driver-for-pegasos.patch
+ppc32-opofile-timer-mode-fallback-fix.patch
+ppc32-workaround-for-mpc10x-speculative-pci-read-erratum.patch
+ppc32-add-platform-specific-machine-check-output-handlers.patch
+ppc32-use-platform-device-style-initialization-for-85xx.patch
+add-eugene-surovegin-to-credits.patch
+ppc32-mpc8245-erratum-28-workaround.patch

 ppc32 stuff

+ppc64-mask-lower-bits-in-tlbie.patch
+ppc64-iseries-buildbreak-fix.patch
+ppc64-p615-iommu-fix.patch

 ppc64 updates

+mips-generic-mips-updates.patch
+mips-irix-5-compat-fixes.patch
+mips-build-script-fixes.patch
+mips-sgi-ip22-updates.patch
+mips-sibyte-updates.patch
+mips-rm200-updates.patch
+mips-sgi-ip27-updates.patch
+mips-dvh-fixes.patch
+mips-tx49-updates.patch
+mips-txx9-serieal-driver-rewrite.patch
+mips-amd-alchemy-update.patch
+mips-ite-8172-updates.patch
+mips-amd-alchemy-i2c-driver.patch
+mips-sgi-ip32-updates.patch
+mips-decstation-updates.patch
+mips-decstation-turbochannel-updates.patch
+mips-jazz-updates.patch
+mips-mips-technologies-board-updates.patch
+mips-cobalt-updates.patch
+mips-vr41xx-updates.patch
+mips-vr4181-updates.patch
+mips-nec-ddb-board-updates.patch
+mips-tx39-series-updates.patch
+mips-galileo-updates.patch
+mips-pmc-sierra-updates.patch
+mips-momentum-updates.patch
+mips-lasat-updates.patch

 MIPS update

+allow-hot-add-enabled-i386-numa-box-to-boot.patch

 x86 early boot fix

-kmap_atomic-takes-char.patch
-kmap_atomic-takes-char-fix.patch
-kmap_atomic-fallout.patch

 Dropped due to lack of interest (and ppc32 noisiness)

+merge-vt_struct-into-vc_data-fix.patch

 fix the console cleanups in -mm.

+factor-out-phase-6-of-journal_commit_transaction.patch
+ext3-cleanup-1.patch
+ext3-free-block-accounting-fix.patch
+ext3_test_root-speedup.patch

 Various ext3 tweaklets

+cant-unmount-bad-inode.patch

 permit unmount of a filesystem which has a bad inode at its root.

+iounmap-debugging.patch

 add a dump_stack() to find a bug which we already fixed

+fix-put_user-under-mmap_sem-in-sys_get_mempolicy.patch

 avoid possible deadlock

+bug-in-tty_ioc-after-changes-between-269-rc1-bk1-and-269-rc1-bk2.patch

 pty fix

+trivial-fix-for-i386-cross-compile.patch

 cross-build fix

+devicestxt-update-with-lanana.patch

 update devices.txt

+cputime-simplifiy-generic-cputime_to_secs-secs_to_cputime.patch

 cputime simplification

+mpsc-updates.patch

 MPSC driver update

+unexport-register_cpu-and-unregister_cpu.patch

 Remove unneeded exports

+oss-support-for-ac97-low-power-codecs.patch

 oss driver update

+add-a-usecs_to_jiffies-function.patch

 usecs_to_jiffies()

+initramfs-move-inode-hash-table-to-__initdata.patch

 save a little RAM.

+idmouse-min-fix.patch

 fix a min() error

+assert_spin_locked.patch

 add assert_spin_locked()

+fix-kallsyms-insmod-rmmod-race.patch
+fix-kallsyms-insmod-rmmod-race-fix.patch
+fix-kallsyms-insmod-rmmod-race-fix-fix.patch

 fix a modules race

+infiniband-use-lanana-assigned-major-in-ib_umad.patch

 infiniband update

+audit-handle-loginuid-through-proc.patch

 audit system fix

+init_i82365-lockup-fix.patch

 Fix pcmcia driver modprobe lockup

+driver-model-type-checking-for-more-drivers.patch

 more driver model typesafety

+oprofile-use-profile_pc-in-oprofile_add_sample.patch

 oprofile cleanup

+oprofile-support-model-4-p4.patch

 more oprofile device support

+d_drop-should-use-per-dentry-lock.patch

 VFS locking fixes

+udf-deadlock-fix.patch

 UDF deadlock fix

+dvb-follow-usb-__le16-changes.patch
+dvb-fix-access-to-freed-memory.patch
+dvb-support-up-to-six-dvb-cards.patch
+dvb-cleanup-firmware-loading-printks.patch

 DVB updates

+random-pt2-kill-redundant-rotate_left-definitions-fix.patch
+random-pt4-replace-sha-with-faster-version-fix-fix.patch
+random-pt4-replace-sha-with-faster-version-fix-fix-fix.patch

 Fix various random driver snafus

+inotify-fix_find_inode.patch

 Fix inotify.patch

+posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic-cleanup.patch
+posix-timers-cpu-clock-support-for-posix-timers-fix.patch
+panic-in-check_process_timers.patch

 Various updates to the posix-timer updates in -mm.

+ltt-architecture-events-mips-fix.patch

 ltt mips fix

+nfsacl-infrastructure-and-server-side-of-nfsacl-fix.patch
+nfsacl-client-side-of-nfsacl-fix.patch
+nfsacl-acl-umask-handling-workaround-in-nfs-client-fix.patch

 Fixes for the NFS ACL patches in -mm.

-kgdb-kill-off-highmem_start_page.patch

 Folded into kgdb-ga.patch

+page-owner-tracking-leak-detector.patch

 Add a memory leak detector at the page allocator level.  See changelog for
 details.

-sched-isochronous-class-for-unprivileged-soft-rt-scheduling.patch
-sched-account-rt_tasks-as-iso_ticks.patch
+rlimit_rt_cpu.patch
+rlimit_rt_cpu-fix.patch
+rlimit_rt_cpu-sparc64-fix.patch

 Drop SCHED_ISO, add the rlimit which allows non-privileged users to gain
 limited RT scheduling policy.

-crashdump-reserving-backup-region-for-kexec-based.patch

 This needs a rethink.

+fbdev-fix-return-code-of-edid_checksum.patch
+backlight-add-backlight-driver-for-sharp-corgi-pdas.patch
+backlight-add-backlight-driver-for-sharp-corgi-pdas-fix.patch

 fbdev updates

+fuse-device-functions-fix.patch
+fuse-read-write-operations-fix.patch
+fuse-read-write-operations-fix.patch

 FUSE updates

+kernel-forkc-make-mm_cachep-static-fix.patch
+matroxfb_basec-make-some-code-static-fix.patch
+kernel-apisgml-references-removed-file-net_initc.patch
+fs-lockd-clntprocc-make-2-functions-static.patch
+oss-sb_cardc-no-need-to-include-mcah.patch
+ioschedc-use-proper-documentation-path.patch
+kernel-resourcec-make-resource_op-static.patch
+kernel-power-mainc-make-pm_states-static.patch
+kernel-sysc-make-some-code-static.patch
+scsi-ipsc-make-some-code-static.patch
+scsi-psi240ic-make-4-functions-static.patch
+scsi-src-make-a-struct-static.patch
+small-drivers-video-kyro-cleanups.patch
+drivers-video-i810-make-some-code-static.patch
+floppyc-make-some-code-static.patch
+drivers-block-nbdc-make-3-functions-static.patch
+drivers-block-cpqarrayc-small-cleanups.patch
+acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch
+pcxx-remove-obsolete-driver.patch
+mark-the-mcd-cdrom-driver-as-broken.patch

 Little fixes and cleanups

+pty-oops-fix.patch

 Linus's workaround for a pty locking bug.



number of patches in -mm: 571
number of changesets in external trees: 438
number of patches in -mm only: 555
total patches: 993



All 561 patches:


linus.patch

alpha-nodemask-build-fix.patch
  alpha: nodemask build fix

alpha-pgd_index-warning-fix.patch
  alpha: pgd_index() warning fix

pnp-64bit-warning-fix.patch
  8250_pnp: 64bit warning fix

ftape-syntax-error.patch
  ftape syntax error

kobject-build-fix.patch
  kobject build fix

crypto-test-vector-fix.patch
  crypto: fix test vectors

ptracelast_siginfo-also-needs-tasklist_lock.patch
  ptrace: last_siginfo also needs tasklist_lock

random-overflow-fix.patch
  random: overflow fix

ext2-quota-leak-fix.patch
  ext2 quota leak fix

irq_affinity-fix-build-when-config_proc_fs=n.patch
  irq_affinity: fix build when CONFIG_PROC_FS=n

fix-audit-skb-leak-on-congested-netlink-socket.patch
  fix audit skb leak on congested netlink socket

some-minor-cleanups-for-audit_log_lost-messages.patch
  some minor cleanups for audit_log_lost() messages

wait_for_completion-api-extension-addition-fixes.patch
  wait_for_completion API extension addition fixes

task_size-is-variable.patch
  TASK_SIZE is variable.

rest_init-local-irq-fix.patch
  rest_init() local irq fix

ppc32-back-out-idle-patch-for-non-powersaving-cpus.patch
  ppc32: back out idle patch for non-powersaving CPU's

ppc32-updated-pegasos-support.patch
  ppc32: (Updated) Pegasos support

i810_audio-offset-lvi-from-civ-to-avoid-stalled-start-fix.patch
  i810_audio comment fix

bug-in-io_destroy-fs-aioc1248.patch
  Fix BUG in io_destroy

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

ia64-acpi-build-fix.patch
  ia64 acpi build fix

bk-acpi.patch

acpi-sleep-while-atomic-during-s3-resume-from-ram.patch
  acpi: sleep-while-atomic during S3 resume from ram

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

acpi-kfree-fix.patch
  a

bk-agpgart.patch

bk-alsa.patch

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

tpm_msc-build-fix.patch
  tpm_msc-build-fix

tpm_atmel-build-fix.patch
  tpm_atmel build fix

driver-model-more-pm_message_t-conversion.patch
  driver model: more pm_message_t conversion

driver-model-more-pci_choose_states-are-needed.patch
  driver model: more pci_choose_state()s are needed

driver-model-fix-u32-vs-pm_message_t-in-oss.patch
  driver model: fix u32 vs. pm_message_t in OSS

bk-drm.patch

bk-drm-via.patch

bk-i2c.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

disable-sidewinder-debug-messages.patch
  Disable Sidewinder debug messages

kbuild-no-redundant-srctree-in-tags-file.patch
  kbuild: no redundant srctree in tags file

seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch
  Seagate ST3200822AS SATA disk needs to be in sil_blacklist as well

bk-netdev.patch

bk-ntfs.patch

prevent-pci_name_bus-buffer-overflows.patch
  prevent pci_name_bus() buffer overflows

typo-in-pci_scan_bus_parented.patch
  typo in pci_scan_bus_parented

maintainers-add-entry-for-qla2xxx-driver.patch
  MAINTAINERS: add entry for qla2xxx driver.

bk-usb.patch

logitech-cordeless-desktop-keyboard-fails-to-report-class-descriptor.patch
  Logitech Cordeless Desktop Keyboard fails to report class descriptor

bk-watchdog.patch

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

mm-oom-killer-tunable.patch
  mm: oom-killer tunable

mm-keep-balance-between-different-classzones.patch
  mm: rework lower-zone protection initialisation

mm-fix-several-oom-killer-bugs.patch
  mm: fix several oom killer bugs

mm-fix-several-oom-killer-bugs-fix.patch
  mm-fix-several-oom-killer-bugs-fix

mm-convert-memdie-to-an-atomic-thread-bitflag.patch
  mm: convert memdie to an atomic thread bitflag

make-used_math-smp-safe.patch
  make used_math SMP-safe

make-used_math-smp-safe-mips-fix.patch
  make-used_math-smp-safe mips fix

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements

simpler-topdown-mmap-layout-allocator.patch
  simpler topdown mmap layout allocator

alloc_zeroed_user_highpage-to-fix-the-clear_user_highpage-issue.patch
  alloc_zeroed_user_highpage() to fix the clear_user_highpage issue

make-slab-use-alloc_pages-directly.patch
  Make slab use alloc_pages directly

page_cache_readahead-unneeded-prev_page-assignments.patch
  page_cache_readahead: unneeded prev_page assignments

cleanup-ahead-window-calculation.patch
  cleanup ahead window calculation

blockable_page_cache_readahead-cleanup.patch
  blockable_page_cache_readahead() cleanup

blockable_page_cache_readahead-cleanup-fix.patch
  blockable_page_cache_readahead-cleanup fix

vmscan-reclaim-swap_cluster_max-pages-in-a-single-pass.patch
  vmscan: reclaim SWAP_CLUSTER_MAX pages in a single pass

fix-mincore-cornercases-overflow-caused-by-large-len.patch
  Fix mincore cornercases: overflow caused by large "len"

use-mm_vm_size-in-exit_mmap.patch
  Use MM_VM_SIZE in exit_mmap

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

use-datacs-in-smc91x-driver.patch
  use datacs in smc91x driver

remove-bogus-exports-in-ppp.patch
  remove bogus exports in ppp

ppc32-mv64x60-updates.patch
  ppc32: mv64x60 updates

ppc32-pmac-sleep-support-update.patch
  ppc32: pmac sleep support update

ppc32-katana-update.patch
  ppc32: katana update

ppc32-ev64260-update.patch
  ppc32: ev64260 update

ppc32-cpci690-update.patch
  ppc32: cpci690 update

ppc32-perfctl-ppc-fix-duplicate-mmcr0-define.patch
  ppc32: perfctl-ppc: fix duplicate mmcr0 define

ppc32-stx-gp3-port.patch
  ppc32: STx GP3 port

ppc32-fix-via-ide-driver-for-pegasos.patch
  ppc32: Fix via IDE driver for pegasos

ppc32-opofile-timer-mode-fallback-fix.patch
  ppc32: oprofile timer-mode fallback fix

ppc32-workaround-for-mpc10x-speculative-pci-read-erratum.patch
  ppc32: workaround for mpc10x speculative PCI read erratum

ppc32-add-platform-specific-machine-check-output-handlers.patch
  ppc32: add platform specific machine check output handlers

ppc32-use-platform-device-style-initialization-for-85xx.patch
  ppc32: use platform device style initialization for 85xx  serial8250 ports

add-eugene-surovegin-to-credits.patch
  Add Eugene Surovegin to CREDITS

ppc32-mpc8245-erratum-28-workaround.patch
  ppc32: MPC8245 erratum 28 workaround

add-try_acquire_console_sem.patch
  Add try_acquire_console_sem

update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
  update aty128fb sleep/wakeup code for new powermac changes

radeonfb-massive-update-of-pm-code.patch
  radeonfb: massive update of PM code

radeonfb-build-fix.patch
  radeonfb-build-fix

ppc64-mask-lower-bits-in-tlbie.patch
  ppc64: mask lower bits in tlbie

ppc64-iseries-buildbreak-fix.patch
  ppc64: iSeries buildbreak fix

ppc64-p615-iommu-fix.patch
  ppc64: p615 IOMMU fix

ppc64-reloc_hide.patch

agpgart-allow-multiple-backends-to-be-initialized.patch
  agpgart: allow multiple backends to be initialized
  agpgart-allow-multiple-backends-to-be-initialized fix
  agpgart: add bridge assignment missed in agp_allocate_memory
  x86_64 agp failure fix

agpgart-add-agp_find_bridge-function.patch
  agpgart: add agp_find_bridge function

agpgart-allow-drivers-to-allocate-memory-local-to.patch
  agpgart: allow drivers to allocate memory local to the bridge

drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  drm: add support for new multiple agp bridge agpgart api

fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  fb: add support for new multiple agp bridge agpgart api

agpgart-add-bridge-parameter-to-driver-functions.patch
  agpgart: add bridge parameter to driver functions

mips-generic-mips-updates.patch
  mips: generic MIPS updates

mips-irix-5-compat-fixes.patch
  mips: IRIX 5 compat fixes

mips-build-script-fixes.patch
  mips: build script fixes

mips-sgi-ip22-updates.patch
  mips: SGI IP22 updates

mips-sibyte-updates.patch
  mips: sibyte updates

mips-rm200-updates.patch
  mips: RM200 updates

mips-sgi-ip27-updates.patch
  mips: SGI IP27 updates

mips-dvh-fixes.patch
  mips: DVH fixes

mips-tx49-updates.patch
  mips: TX49 updates

mips-txx9-serieal-driver-rewrite.patch
  mips: TXX9 serieal driver rewrite

mips-amd-alchemy-update.patch
  mips: aMD Alchemy update

mips-ite-8172-updates.patch
  mips: ITE 8172 updates

mips-amd-alchemy-i2c-driver.patch
  mips: AMD Alchemy I2C driver

mips-sgi-ip32-updates.patch
  mips: SGI IP32 updates

mips-decstation-updates.patch
  mips: DECstation updates

mips-decstation-turbochannel-updates.patch
  mips: DECstation Turbochannel updates

mips-jazz-updates.patch
  mips: jazz updates

mips-mips-technologies-board-updates.patch
  mips: mIPS Technologies board updates

mips-cobalt-updates.patch
  mips: cobalt updates

mips-vr41xx-updates.patch
  mips: vR41xx updates

mips-vr4181-updates.patch
  mips: VR4181 updates

mips-nec-ddb-board-updates.patch
  mips: NEC DDB board updates

mips-tx39-series-updates.patch
  mips: TX39 series updates

mips-galileo-updates.patch
  mips: galileo updates

mips-pmc-sierra-updates.patch
  mips: PMC-Sierra updates

mips-momentum-updates.patch
  mips: Momentum updates

mips-lasat-updates.patch
  mips: Lasat updates

superhyway-bus-support.patch
  SuperHyway bus support

allow-hot-add-enabled-i386-numa-box-to-boot.patch
  Allow hot-add enabled i386 NUMA box to boot

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

irqpoll.patch
  irqpoll

poll-mini-optimisations.patch
  poll: mini optimisations

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cleanup-vc-array-access.patch
  cleanup vc array access

remove-console_macrosh.patch
  remove console_macros.h

merge-vt_struct-into-vc_data.patch
  merge vt_struct into vc_data

merge-vt_struct-into-vc_data-fix.patch
  merge-vt_struct-into-vc_data fix

jbd-journal-overflow-fix.patch
  JBD: journal overflow fix

jbd-journal-overflow-fix-fixes.patch
  jbd-journal-overflow-fix-fixes

jbd-fix-against-journal-overflow.patch
  JBD: reduce stack and number of journal descriptors

jbd-fix-against-journal-overflow-tidies.patch
  jbd-fix-against-journal-overflow-tidies

jbd-log-space-management-optimization.patch
  JBD: log space management optimization

factor-out-phase-6-of-journal_commit_transaction.patch
  Factor out phase 6 of journal_commit_transaction

ext3-cleanup-1.patch
  ext3 cleanup 1

ext3-free-block-accounting-fix.patch
  ext3: free block accounting fix

ext3_test_root-speedup.patch
  ext3_test_root() speedup

i4l-new-hfc_usb-driver-version.patch
  i4l: new hfc_usb driver version

i4l-hfc-4s-and-hfc-8s-driver.patch
  i4l: HFC-4S and HFC-8S driver

fix-race-between-the-nmi-code-and-the-cmos-clock.patch
  Fix race between the NMI code and the CMOS clock

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

fix-put_user-under-mmap_sem-in-sys_get_mempolicy.patch
  fix put_user under mmap_sem in sys_get_mempolicy()

bug-in-tty_ioc-after-changes-between-269-rc1-bk1-and-269-rc1-bk2.patch
  Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2

trivial-fix-for-i386-cross-compile.patch
  fix for i386 cross compile

devicestxt-update-with-lanana.patch
  Devices.txt, update with LANANA

cputime-simplifiy-generic-cputime_to_secs-secs_to_cputime.patch
  cputime: simplifiy generic cputime_to_secs/secs_to_cputime

mpsc-updates.patch
  mpsc updates

unexport-register_cpu-and-unregister_cpu.patch
  unexport register_cpu and unregister_cpu

oss-support-for-ac97-low-power-codecs.patch
  OSS Support for AC97 low power codecs

add-a-usecs_to_jiffies-function.patch
  Add a usecs_to_jiffies() function

initramfs-move-inode-hash-table-to-__initdata.patch
  initramfs: move inode hash table to __initdata

idmouse-min-fix.patch
  idmouse min() fix

assert_spin_locked.patch
  assert_spin_locked()

fix-kallsyms-insmod-rmmod-race.patch
  Fix kallsyms/insmod/rmmod race

fix-kallsyms-insmod-rmmod-race-fix.patch
  fix-kallsyms-insmod-rmmod-race fix

fix-kallsyms-insmod-rmmod-race-fix-fix.patch
  fix-kallsyms-insmod-rmmod-race-fix-fix

infiniband-use-lanana-assigned-major-in-ib_umad.patch
  infiniband: use LANANA-assigned major in ib_umad

audit-handle-loginuid-through-proc.patch
  audit: handle loginuid through proc

init_i82365-lockup-fix.patch
  init_i82365() lockup fix

driver-model-type-checking-for-more-drivers.patch
  driver-model: Type-checking for more drivers

oprofile-use-profile_pc-in-oprofile_add_sample.patch
  OProfile: Use profile_pc in oprofile_add_sample

oprofile-support-model-4-p4.patch
  OProfile: Support model 4 P4

d_drop-should-use-per-dentry-lock.patch
  d_drop should use per dentry lock

udf-deadlock-fix.patch
  udf deadlock fix

dvb-follow-usb-__le16-changes.patch
  dvb: follow USB __le16 changes

dvb-fix-access-to-freed-memory.patch
  dvb: fix access to freed memory

dvb-support-up-to-six-dvb-cards.patch
  dvb: support up to six DVB cards

dvb-cleanup-firmware-loading-printks.patch
  dvb: cleanup firmware loading printks

random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
  random: cleanup waitqueue logic, fix missed wakeup

random-pt2-kill-pool-clearing.patch
  random: kill pool clearing

random-pt2-combine-legacy-ioctls.patch
  random: combine legacy ioctls

random-pt2-re-init-all-pools-on-zero.patch
  random: re-init all pools on zero

random-pt2-simplify-initialization.patch
  random: simplify initialization

random-pt2-kill-memsets-of-static-data.patch
  random: kill memsets of static data

random-pt2-kill-dead-extract_state-struct.patch
  random: kill dead extract_state struct

random-pt2-kill-22-compat-waitqueue-defs.patch
  random: kill 2.2 compat waitqueue defs

random-pt2-kill-redundant-rotate_left-definitions.patch
  random: kill redundant rotate_left definitions

random-pt2-kill-redundant-rotate_left-definitions-fix.patch
  rol32 thinko

random-pt2-kill-misnamed-log2.patch
  random: kill misnamed log2

random-pt3-more-meaningful-pool-names.patch
  random: More meaningful pool names

random-pt3-static-allocation-of-pools.patch
  random: Static allocation of pools

random-pt3-static-sysctl-bits.patch
  random: Static sysctl bits

random-pt3-catastrophic-reseed-checks.patch
  random: Catastrophic reseed checks

random-pt3-entropy-reservation-accounting.patch
  random: Entropy reservation accounting

random-pt3-reservation-flag-in-pool-struct.patch
  random: Reservation flag in pool struct

random-pt3-reseed-pointer-in-pool-struct.patch
  random: Reseed pointer in pool struct

random-pt3-break-up-extract_user.patch
  random: Break up extract_user

random-pt3-remove-dead-md5-copy.patch
  random: Remove dead MD5 copy

random-pt3-simplify-hash-folding.patch
  random: Simplify hash folding

random-pt3-clean-up-hash-buffering.patch
  random: Clean up hash buffering

random-pt3-remove-entropy-batching.patch
  random: Remove entropy batching

random-pt4-create-new-rol32-ror32-bitops.patch
  random: Create new rol32/ror32 bitops

random-pt4-use-them-throughout-the-tree.patch
  random: Use them throughout the tree

random-pt4-kill-the-sha-variants.patch
  random: Kill the SHA variants

random-pt4-cleanup-sha-interface.patch
  random: Cleanup SHA interface

random-pt4-move-sha-code-to-lib.patch
  random: Move SHA code to lib/

random-pt4-replace-sha-with-faster-version.patch
  random: Replace SHA with faster version

random-pt4-replace-sha-with-faster-version-fix.patch
  random-pt4-replace-sha-with-faster-version-fix

random-pt4-replace-sha-with-faster-version-fix-fix.patch
  SHA1 clarify kerneldoc

random-pt4-replace-sha-with-faster-version-fix-fix-fix.patch
  random-pt4-cleanup-sha-interface fix

random-pt4-update-cryptolib-to-use-sha-fro-lib.patch
  random: Update cryptolib to use SHA fro lib

random-pt4-move-halfmd4-to-lib.patch
  random: Move halfmd4 to lib

random-pt4-kill-duplicate-halfmd4-in-ext3-htree.patch
  random: Kill duplicate halfmd4 in ext3 htree

random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix.patch
  random-pt4-kill-duplicate-halfmd4-in-ext3-htree-fix

random-pt4-simplify-and-shrink-syncookie-code.patch
  random: Simplify and shrink syncookie code

random-pt4-move-syncookies-to-net.patch
  random: Move syncookies to net/

random-pt4-move-other-tcp-ip-bits-to-net.patch
  random: Move other tcp/ip bits to net/

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

speedup-proc-pid-maps-fix.patch
  Speed up /proc/pid/maps fix

speedup-proc-pid-maps-fix-fix.patch
  speedup-proc-pid-maps fix fix

speedup-proc-pid-maps-fix-fix-fix.patch
  speedup /proc/<pid>/maps(4th version)

fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
  fix loss of records on size > 4096 in proc/<pid>/maps

speedup-proc-pid-maps-fix-fix-fix-fix.patch
  speedup-proc-pid-maps-fix-fix-fix fix

inotify.patch
  inotify

inotify-fix_find_inode.patch
  inotify: fix find_inode

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch
  posix-timers: tidy up clock interfaces and consolidate dispatch logic

posix-timers-high-resolution-cpu-clocks-for-posix-clock_-syscalls.patch
  posix-timers: high-resolution CPU clocks for POSIX clock_* syscalls

posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic-cleanup.patch
  posix-timers: tidy up clock interfaces and  consolidate dispatch logic cleanup

posix-timers-fix-posix-timers-signals-lock-order.patch
  posix-timers: fix posix-timers signals lock order

posix-timers-cpu-clock-support-for-posix-timers.patch
  posix-timers: CPU clock support for POSIX timers

posix-timers-cpu-clock-support-for-posix-timers-fix.patch
  posix-timers: CPU clock support for POSIX timers (fix)

panic-in-check_process_timers.patch
  PANIC in check_process_timers()

make-itimer_real-per-process.patch
  make ITIMER_REAL per-process

make-itimer_prof-itimer_virtual-per-process.patch
  make ITIMER_PROF, ITIMER_VIRTUAL per-process

make-rlimit_cpu-sigxcpu-per-process.patch
  make RLIMIT_CPU/SIGXCPU per-process

relayfs-doc.patch
  relayfs: doc

relayfs-common-files.patch
  relayfs: common files

relayfs-remove-klog-debugging-channel.patch
  relayfs - remove klog debugging channel

relayfs-locking-lockless-implementation.patch
  relayfs: locking/lockless implementation

relayfs-headers.patch
  relayfs: headers

relayfs-remove-klog-debugging-channel-headers.patch
  relayfs - remove klog debugging channel

ltt-core-implementation.patch
  ltt: core implementation

ltt-core-headers.patch
  ltt: core headers

mips-fixed-ltt-build-errors.patch
  mips: fixed LTT build errors

ltt-kconfig-fix.patch
  ltt kconfig fix

ltt-doesnt-build-on-x86_64.patch
  ltt doesn't build on x86_64

ltt-kernel-events.patch
  ltt: kernel/ events

ltt-kernel-events-tidy.patch
  ltt-kernel-events tidy

ltt-kernel-events-build-fix.patch
  ltt-kernel-events-build-fix

ltt-fs-events.patch
  ltt: fs/ events

ltt-fs-events-tidy.patch
  ltt-fs-events tidy

ltt-ipc-events.patch
  ltt: ipc/ events

ltt-mm-events.patch
  ltt: mm/ events

ltt-net-events.patch
  ltt: net/ events

ltt-architecture-events.patch
  ltt: architecture events

ltt-architecture-events-mips-fix.patch
  mips: fix LTT for MIPS

nfs-fix_vfsflock.patch
  VFS: Fix structure initialization in locks_remove_flock()

nfs-flock.patch
  NFS: Add emulation of BSD flock() in terms of POSIX locks on the server

nfsacl-protocol-extension-for-nfsv3.patch
  NFSACL protocol extension for NFSv3: generalise qsort()

nfsacl-return-enosys-for-rpc-programs-that-are-unavailable.patch
  nfsacl: return -ENOSYS for RPC programs that are unavailable

nfsacl-add-missing-eopnotsupp-=-nfs3err_notsupp-mapping-in-nfsd.patch
  nfsacl: add missing -EOPNOTSUPP => NFS3ERR_NOTSUPP mapping in nfsd

nfsacl-allow-multiple-programs-to-listen-on-the-same-port.patch
  nfsacl: allow multiple programs to listen on the same port

nfsacl-allow-multiple-programs-to-share-the-same-transport.patch
  nfsacl: allow multiple programs to share the same transport

nfsacl-lazy-rpc-receive-buffer-allocation.patch
  nfsacl: lazy RPC receive buffer allocation

nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
  nfsacl: encode and decode arbitrary XDR arrays

nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix.patch
  nfsacl-encode-and-decode-arbitrary-xdr-arrays-fix

nfsacl-add-noacl-nfs-mount-option.patch
  nfsacl: add noacl nfs mount option

nfsacl-infrastructure-and-server-side-of-nfsacl.patch
  nfsacl: infrastructure and server side of nfsacl

nfsacl-infrastructure-and-server-side-of-nfsacl-fix.patch
  nfsacl-infrastructure-and-server-side-of-nfsacl fix

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: solaris nfsacl workaround

nfsacl-client-side-of-nfsacl.patch
  nfsacl: client side of nfsacl

nfsacl-client-side-of-nfsacl-fix.patch
  nfsacl: Must not initialize inode->i_op to NULL

nfsacl-acl-umask-handling-workaround-in-nfs-client.patch
  nfsacl: aCL umask handling workaround in nfs client

nfsacl-acl-umask-handling-workaround-in-nfs-client-fix.patch
  ACL umask handling workaround in nfs client fix

nfsacl-cache-acls-on-the-nfs-client-side.patch
  nfsacl: cache acls on the nfs client side

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
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes
  kgdb: kill off highmem_start_page

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

sched-fix-preemption-race-core-i386.patch
  sched: fix preemption race (Core/i386)

sched-make-use-of-preempt_schedule_irq-ppc.patch
  sched: make use of preempt_schedule_irq() (PPC)

sched-make-use-of-preempt_schedule_irq-arm.patch
  sched: make use of preempt_schedule_irq (ARM)

rlimit_rt_cpu.patch
  implement RLIMIT_RT_CPU

rlimit_rt_cpu-fix.patch
  rlimit_rt_cpu fix

rlimit_rt_cpu-sparc64-fix.patch
  rlimit_rt_cpu-sparc64-fix

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

ppc64-fix-cpu-hotplug.patch
  ppc64: fix hotplug cpu

serialize-access-to-ide-devices.patch
  serialize access to ide devices

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-move-cpusets-above-embedded.patch
  move CPUSETS above EMBEDDED

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-recover-read-performance.patch
  reiser4: recover read performance

reiser4-export-find_get_pages_tag.patch
  reiser4-export-find_get_pages_tag

reiser4-add-missing-context.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

fbdev-fix-return-code-of-edid_checksum.patch
  fbdev: Fix return code of edid_checksum

backlight-add-backlight-driver-for-sharp-corgi-pdas.patch
  backlight: Add backlight driver for Sharp Corgi PDAs

backlight-add-backlight-driver-for-sharp-corgi-pdas-fix.patch
  backlight-add-backlight-driver-for-sharp-corgi-pdas-fix

raid5-overlapping-read-hack.patch
  raid5 overlapping read hack

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

fuse-maintainers-kconfig-and-makefile-changes.patch
  Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  Subject: [PATCH 2/11] FUSE - core

fuse-device-functions.patch
  Subject: [PATCH 3/11] FUSE - device functions

fuse-device-functions-fix.patch
  fuse: better error reporting in fuse_fill_super

fuse-fix-llseek-on-device.patch
  FUSE: fix llseek on device

fuse-make-two-functions-static.patch
  fuse: make two functions static

fuse-fix-variable-with-confusing-name.patch
  fuse: fix variable with confusing name

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-read-write-operations-fix.patch
  fuse: fix hard link operation

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-dont-check-against-zero-fsuid.patch
  fuse: don't check against zero fsuid

fuse-remove-mount_max-and-user_allow_other-module-parameters.patch
  fuse: remove mount_max and user_allow_other module parameters

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

fuse-read-write-operations-fix.patch
  fuse: fix hard link operation

ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch
  ieee1394: add a disable_irm option to ieee1394.ko

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

compile-error-blackbird_load_firmware.patch
  blackbird_load_firmware compile fix

i386-x86_64-apicc-make-two-functions-static.patch
  i386/x86_64 apic.c: make two functions static

i386-cyrixc-make-a-function-static.patch
  i386 cyrix.c: make a function static

mtrr-some-cleanups.patch
  mtrr: some cleanups

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-cpuidc-make-two-functions-static.patch
  i386 cpuid.c: make two functions static

i386-efic-make-some-code-static.patch
  i386 efi.c: make some code static

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

i386-mpparsec-make-mp_processor_info-static.patch
  i386 mpparse.c: make MP_processor_info static

i386-x86_64-msrc-make-two-functions-static.patch
  i386/x86_64 msr.c: make two functions static

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

hpet-make-some-code-static.patch
  hpet: make some code static

26-patch-i386-trapsc-make-a-function-static.patch
  i386 traps.c: make a function static

i386-semaphorec-make-4-functions-static.patch
  i386 semaphore.c: make 4 functions static

kill-aux_device_present.patch
  kill aux_device_present

i386-setupc-make-4-variables-static.patch
  i386 setup.c: make 4 variables static

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

scsi-megaraid_mmc-make-some-code-static.patch
  SCSI megaraid_mm.c: make some code static

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

add-map_populate-sys_remap_file_pages-support-to-xfs.patch
  add MAP_POPULATE/sys_remap_file_pages support to XFS

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

kernel-acctc-make-a-function-static.patch
  kernel/acct.c: make a function static

kernel-auditc-make-some-functions-static.patch
  kernel/audit.c: make some functions static

kernel-capabilityc-make-a-spinlock-static.patch
  kernel/capability.c: make a spinlock static

mm-thrashc-make-a-variable-static.patch
  mm/thrash.c: make a variable static

lib-kernel_lockc-make-kernel_sem-static.patch
  lib/kernel_lock.c: make kernel_sem static

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

drivers-block-umemc-make-two-functions-static.patch
  drivers/block/umem.c: make two functions static

drivers-block-xdc-make-a-variable-static.patch
  drivers/block/xd.c: make a variable static

kernel-configsc-make-a-variable-static.patch
  kernel/configs.c: make a variable static

kernel-forkc-make-mm_cachep-static.patch
  kernel/fork.c: make mm_cachep static

kernel-forkc-make-mm_cachep-static-fix.patch
  kernel-forkc-make-mm_cachep-static fix

kernel-kallsymsc-make-some-code-static.patch
  kernel/kallsyms.c: make some code static

mm-page-writebackc-remove-an-unused-function.patch
  mm/page-writeback.c: remove an unused function

mm-shmemc-make-a-struct-static.patch
  mm/shmem.c: make a struct static

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

if-0-cx88_risc_disasm.patch
  #if 0 cx88_risc_disasm

make-loglevels-in-init-mainc-a-little-more-sane.patch
  Make loglevels in init/main.c a little more sane.

isicom-use-null-for-pointer.patch
  sparse: use NULL for pointer

remove-bouncing-email-address-of-hennus-bergman.patch
  remove bouncing email address of Hennus Bergman

cirrusfbc-make-some-code-static.patch
  cirrusfb.c: make some code static

matroxfb_basec-make-some-code-static.patch
  matroxfb_base.c: make some code static

matroxfb_basec-make-some-code-static-fix.patch
  matroxfb_basec-make-some-code-static fix

asiliantfbc-make-some-code-static.patch
  asiliantfb.c: make some code static

i386-apic-kconfig-cleanups.patch
  i386 APIC Kconfig cleanups

security-seclvlc-make-some-code-static.patch
  security/seclvl.c: make some code static

drivers-block-elevatorc-make-two-functions-static.patch
  drivers/block/elevator.c: make two functions static

drivers-block-rdc-make-two-variables-static.patch
  drivers/block/rd.c: make two variables static

loopc-make-two-functions-static.patch
  loop.c: make two functions static

remove-bouncing-email-address-of-thomas-hood.patch
  remove bouncing email address of Thomas Hood

fs-adfs-dir_fc-remove-an-unused-function.patch
  fs/adfs/dir_f.c: remove an unused function

drivers-char-moxac-if-0-an-unused-function.patch
  drivers/char/moxa.c: #if 0 an unused function

kernel-apisgml-references-removed-file-net_initc.patch
  kernel-api.sgml references removed file net_init.c

fs-lockd-clntprocc-make-2-functions-static.patch
  fs/lockd/clntproc.c: make 2 functions static

oss-sb_cardc-no-need-to-include-mcah.patch
  OSS sb_card.c: no need to include mca.h

ioschedc-use-proper-documentation-path.patch
  *-iosched.c: Use proper documentation path

kernel-resourcec-make-resource_op-static.patch
  kernel/resource.c: make resource_op static

kernel-power-mainc-make-pm_states-static.patch
  kernel/power/main.c: make pm_states static

kernel-sysc-make-some-code-static.patch
  kernel/sys.c: make some code static

scsi-ipsc-make-some-code-static.patch
  SCSI ips.c: make some code static

scsi-psi240ic-make-4-functions-static.patch
  SCSI psi240i.c: make 4 functions static

scsi-src-make-a-struct-static.patch
  SCSI sr.c: make a struct static

small-drivers-video-kyro-cleanups.patch
  small drivers/video/kyro/ cleanups

drivers-video-i810-make-some-code-static.patch
  drivers/video/i810/: make some code static

floppyc-make-some-code-static.patch
  floppy.c: make some code static

drivers-block-nbdc-make-3-functions-static.patch
  drivers/block/nbd.c: make 3 functions static

drivers-block-cpqarrayc-small-cleanups.patch
  drivers/block/cpqarray.c: small cleanups

acpi-call-acpi_leave_sleep_state-before-resuming-devices.patch
  acpi: call acpi_leave_sleep_state before resuming devices

pcxx-remove-obsolete-driver.patch
  pcxx: Remove obsolete driver

pty-oops-fix.patch
  pty oops fix

mark-the-mcd-cdrom-driver-as-broken.patch
  mark the mcd cdrom driver as BROKEN



