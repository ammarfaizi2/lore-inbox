Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVAFIZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVAFIZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVAFIZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:25:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262771AbVAFIWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:22:52 -0500
Date: Thu, 6 Jan 2005 00:22:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-mm2
Message-Id: <20050106002240.00ac4611.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/

- Various minorish updates and fixes


Changes since 2.6.10-mm1:

 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-dtor-input.patch
 bk-kconfig.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch

 Latext versions of various bk trees.

-expose-reiserfs_sync_fs.patch
-fix-reiserfs-quota-debug-messages.patch
-fix-of-quota-deadlock-on-pagelock-quota-core.patch
-vfs_quota_off-oops-fix.patch
-quota-umount-race-fix.patch
-fix-of-quota-deadlock-on-pagelock-ext2.patch
-fix-of-quota-deadlock-on-pagelock-ext2-tweaks.patch
-fix-of-quota-deadlock-on-pagelock-ext3.patch
-fix-of-quota-deadlock-on-pagelock-ext3-tweaks.patch
-fix-of-quota-deadlock-on-pagelock-reiserfs.patch
-fix-of-quota-deadlock-on-pagelock-reiserfs-fix.patch
-reiserfs-bug-fix-do-not-clear-ms_active-mount-flag.patch
-allow-disabling-quota-messages-to-console.patch
-vmscan-total_scanned-fix.patch
-cs461x-gameport-code-isnt-being-included-in-build.patch
-mm-keep-count-of-free-areas.patch
-mm-higher-order-watermarks.patch
-mm-higher-order-watermarks-fix.patch
-mm-teach-kswapd-about-higher-order-areas.patch
-simplified-readahead.patch
-simplified-readahead-fix.patch
-simplified-readahead-cleanups.patch
-readahead-congestion-control.patch
-mempolicy-optimization.patch
-mm-overcommit-updates.patch
-kill-off-highmem_start_page.patch
-make-sure-ioremap-only-tests-valid-addresses.patch
-mark_page_accessed-for-reads-on-non-page-boundaries.patch
-do_anonymous_page-use-setpagereferenced.patch
-slab-add-more-arch-overrides-to-control-object-alignment.patch
-collect-page_states-only-from-online-cpus.patch
-collect-page_states-only-from-online-cpus-tidy.patch
-alloc_large_system_hash-numa-interleaving.patch
-filesystem-hashes-numa-interleaving.patch
-tcp-hashes-numa-interleaving.patch
-netfilter-fix-return-values-of-ipt_recent-checkentry.patch
-netfilter-fix-ip_conntrack_proto_sctp-exit-on-sysctl.patch
-netfilter-fix-ip_ct_selective_cleanup-and-rename.patch
-netfilter-add-comment-above-remove_expectations-in.patch
-netfilter-remove-ipchains-and-ipfwadm-compatibility.patch
-netfilter-remove-copy_to_user-warnings-in-netfilter.patch
-netfilter-fix-cleanup-in-ipt_recent-should-ipt_registrater_match-error.patch
-fix-broken-rst-handling-in-ip_conntrack.patch
-ppc32-freescale-book-e-mmu-cleanup.patch
-ppc32-refactor-common-book-e-exception-code.patch
-ppc32-switch-to-kbuild_defconfig.patch
-ppc32-marvell-host-bridge-support-mv64x60.patch
-ppc32-marvell-host-bridge-support-mv64x60-review-fixes.patch
-ppc32-support-for-marvell-ev-64260-bp-eval-platform.patch
-ppc32-support-for-force-cpci-690-board.patch
-ppc32-support-for-artesyn-katana-cpci-boards.patch
-ppc32-add-support-for-ibm-750fx-and-750gx-eval-boards.patch
-ppc32-ppc4xx-pic-rewrite-cleanup.patch
-ppc32-performance-monitor-oprofile-support-for-e500.patch
-ppc32-performance-monitor-oprofile-support-for-e500-review-fixes.patch
-ppc32-fix-ebonyc-warnings.patch
-ppc32-remove-bogus-sprn_cpc0_gpio-define.patch
-ppc32-debug-setcontext-syscall-implementation.patch
-ppc32-add-uimage-to-default-targets.patch
-ppc32-fix-io_remap_page_range-for-36-bit-phys-platforms.patch
-ppc32-resurrect-documentation-powerpc-cpu_featurestxt.patch
-ppc64-kprobes-implementation.patch
-ppc64-tweaks-to-cpu-sysfs-information.patch
-kprobes-wrapper-to-define-jprobeentry.patch
-termio-userspace-access-error-handling.patch
-ide_arch_obsolete_init-fix.patch
-out-of-line-implementation-of-find_next_bit.patch
-gp-rel-data-support.patch
-gp-rel-data-support-vs-bk-kbuild-fix.patch
-vm-routine-fixes.patch
-vm-routine-fixes-CONFIG_SHMEM-fix.patch
-frv-fujitsu-fr-v-cpu-arch-maintainer-record.patch
-frv-fujitsu-fr-v-arch-documentation.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-1.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-2.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-3.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-4.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-5.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-6.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-7.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-8.patch
-frv-fujitsu-fr-v-cpu-arch-implementation-part-9.patch
-put-memory-in-dma-zone-not-normal-zone-in-frv-arch.patch
-frv-kill-off-highmem_start_page.patch
-frv-first-batch-of-fujitsu-fr-v-arch-include-files.patch
-frv-remove-obsolete-hardirq-stuff-from-includes.patch
-frv-pci-dma-fixes.patch
-fix-frv-pci-config-space-write.patch
-frv-more-fujitsu-fr-v-arch-include-files.patch
-convert-frv-to-use-remap_pfn_range.patch
-frv-yet-more-fujitsu-fr-v-arch-include-files.patch
-frv-remaining-fujitsu-fr-v-arch-include-files.patch
-frv-make-calibrate_delay-optional.patch
-frv-better-mmap-support-in-uclinux.patch
-frv-procfs-changes-for-nommu-changes.patch
-frv-change-setup_arg_pages-to-take-stack-pointer.patch
-frv-change-setup_arg_pages-to-take-stack-pointer-fixes.patch
-frv-add-fdpic-elf-binary-format-driver.patch
-fix-some-elf-fdpic-binfmt-problems.patch
-further-nommu-changes.patch
-further-nommu-proc-changes.patch
-frv-arch-nommu-changes.patch
-make-more-syscalls-available-for-the-fr-v-arch.patch
-frv-debugging-fixes.patch
-frv-minix-ext2-bitops-fixes.patch
-frv-perfctr_info-syscall.patch
-frv-update-the-trap-tables-comment.patch
-frv-accidental-tlb-entry-write-protect-fix.patch
-frv-pagetable-handling-fixes.patch
-frv-fr55x-cpu-support-fixes.patch
-implement-nommu-find_vma.patch
-fix-nommu-map_shared-handling.patch
-permit-nommu-map_shared-of-memory-backed-files.patch
-cross-reference-nommu-vmas-with-mappings.patch
-assign-pkmap_base-dynamically.patch
-x86-remove-data-header-and-code-overlap-in-boot-setups.patch
-cyrix-mii-cpuid-returns-stale-%ecx.patch
-nx-fix-noexec-kernel-parameter.patch
-nx-triple-fault-with-4k-kernel-mappings-and-pae.patch
-trivial-cleanup-in-arch-i386-kernel-heads.patch
-remove-pfn_to_pgdat-on-x86.patch
-boot_ap_for_nondefault_kernel.patch
-i386-boot-loader-ids.patch
-proc-sys-kernel-bootloader_type.patch
-intel-thermal-monitor-for-x86_64.patch
-x86_64-do_general_protection-retval-check.patch
-x86_64-add-a-real-pfn_valid.patch
-x86_64-fix-bugs-in-the-amd-k8-cmp-support-code.patch
-x86_64-fix-bugs-in-the-amd-k8-cmp-support-code-fix.patch
-x86_64-reenable-mga-dri-on-x86-64.patch
-x86_64-remove-duplicated-fake_stack_frame-macro.patch
-x86_64-remove-bios-reboot-code.patch
-x86_64-add-reboot=force.patch
-x86_64-collected-ioremap-fixes.patch
-x86_64-handle-nx-correctly-in-pageattr.patch
-x86_64-split-acpi-boot-table-parsing.patch
-x86_64-split-acpi-boot-table-parsing-fix.patch
-x86_64-add-srat-numa-discovery-to-x86-64.patch
-x86_64-update-uptime-after-suspend.patch
-x86_64-allow-a-kernel-debugger-to-hide-single-steps-in.patch
-x86_64-remove-debug-information-for-vsyscalls.patch
-x86_64-rename-htvalid-to-cmp_legacy.patch
-x86_64-scheduler-support-for-amd-cmp.patch
-x86_64-add-a-missing-__iomem-pointed-out-by-linus.patch
-x86_64-add-a-missing-newline-in-proc-cpuinfo.patch
-x86_64-always-print-segfaults-for-init.patch
-x86_64-export-phys_proc_id.patch
-x86_64-allow-to-configure-more-cpus-and-nodes.patch
-x86_64-allow-to-configure-more-cpus-and-nodes-fix.patch
-x86_64-fix-a-warning-in-the-cmp-support-code-for.patch
-x86_64-fix-some-outdated-assumptions-that-cpu-numbers.patch
-x86_64-fix-em64t-config-description.patch
-x86_64-remove-unneeded-ifdef-in-hardirqh.patch
-x86_64-add-slit-inter-node-distance-information-to.patch
-x86_64-add-x86_64-support-for-jack-steiners-slit-sysfs.patch
-x86_64-eliminate-some-useless-printks-in-acpi-numac.patch
-h8-300-new-systemcall-support.patch
-arm26-remove-arm32-cruft.patch
-arm26-update-the-atomic-ops.patch
-arm26-build-system-updates.patch
-arm26-update-comments-headers-notes.patch
-arm26-necessary-compilation-fixes-for-2610.patch
-arm26cleanup-trap-handling-assembly.patch
-arm26-new-execve-code.patch
-arm26-move-some-files-to-better-locations.patch
-arm26-remove-shark-arm32-from-arm26.patch
-arm26-softirq-update.patch
-arm26-update-systemh-to-some-semblance-of-recentness.patch
-arm26-replace-arm32-time-handling-code-with-smaller-version.patch
-arm26-tlb-update.patch
-arm26-better-put_user-macros.patch
-arm26-better-unistdh-reimplemented-based-on-arm32.patch
-ia64-remove-hcdp-support-for-early-printk.patch
-typeofdev-powersaved_state.patch
-fix-naming-in-swsusp.patch
-swsusp-kill-unused-variable.patch
-swsusp-kill-one-line-helpers-handle-read-errors.patch
-swsusp-small-cleanups.patch
-swsusp-kill-on2-algorithm-in-swsusp.patch
-swsusp-try_to_freeze-to-make-freezing-hooks-nicer.patch
-swsusp-try_to_freeze-to-make-freezing-hooks-nicer-fix.patch
-m32r-add-new-relocation-types-to-elfh.patch
-m32r-support-pgprot_noncached.patch
-m32r-update-ptracec-for-multithread.patch
-m32r-fix-not-to-execute-noexec-pages-0-3.patch
-m32r-cause-sigsegv-for-nonexec-page.patch
-m32r-dont-encode-ace_instruction-in.patch
-m32r-clean-up-arch-m32r-mm-faultc-3-3.patch
-m32r-clean-up-include-asm-m32r-pgtableh.patch
-m32r-support-page_none-1-3.patch
-m32r-remove-page_user-2-3.patch
-m32r-clean-up.patch
-m32r-include-asm-m32r-thread_infoh-minor.patch
-m32r-use-kmalloc-for-m32r-stacks-2-2.patch
-m32r-make-kernel-headers-for-mutual.patch
-m32r-use-generic-hardirq-framework.patch
-m32r-update-include-asm-m32r-systemh.patch
-m32r-update-include-asm-m32r-mmu_contexth.patch
-uml-remove-most-devfs_mk_symlink-calls.patch
-uml-fix-__wrap_free-comment.patch
-uml-fix-some-ptrace-functions-returns-values.patch
-uml-redo-the-signal-delivery-mechanism.patch
-uml-make-restorer-match-i386.patch
-uml-unistdh-cleanup.patch
-uml-remove-a-quilt-induced-duplicity.patch
-uml-fix-sigreturn-to-not-copy_user-under-a-spinlock.patch
-uml-close-host-file-descriptors-properly.patch
-uml-free-host-resources-associated-with-freed-irqs.patch
-uml-unregister-signal-handlers-at-reboot.patch
-hostfs-uml-set-sendfile-to-generic_file_sendfile.patch
-hostfs-uml-add-some-other-pagecache-methods.patch
-uml-terminal-cleanup.patch
-uml-first-part-rework-of-run_helper-and-users.patch
-uml-finish-fixing-run_helper-failure-path.patch
-uml-add-elf-vsyscall-support.patch
-uml-make-vsyscall-page-into-process-page-tables.patch
-uml-include-vsyscall-page-in-core-dumps.patch
-uml-add-tracesysgood-support.patch
-uml-kill-host-processes-properly.patch
-uml-defconfig-update.patch
-uml-small-vsyscall-fixes.patch
-uml-export-end_iomem.patch
-uml-system-call-restart-fixes.patch
-uml-fix-setting-of-tif_sigpending.patch
-uml-allow-vsyscall-code-to-build-on-24.patch
-uml-sysemu-fixes.patch
-uml-correctly-restore-extramask-in-sigreturn.patch
-uml-fix-update_process_times-call.patch
-uml-detect-sysemu_singlestep.patch
-uml-use-sysemu_singlestep.patch
-uml-declare-ptrace_setfpregs.patch
-uml-remove-bogus-__nr_sigreturn-check.patch
-uml-fix-highmem-compilation.patch
-uml-symbol-export.patch
-uml-fix-umldir-init-order.patch
-uml-raise-tty-limit.patch
-uml-sysfs-support-for-uml-network-driver.patch
-uml-sysfs-support-for-the-uml-block-devices.patch
-s390-remove-compat-setup_arg_pages32.patch
-s390-core-patches.patch
-s390-common-i-o-layer.patch
-s390-network-device-driver-patches.patch
-s390-dasd-driver.patch
-s390-character-device-drivers.patch
-s390-dcss-driver-cleanup-fix.patch
-s390-sclp-device-driver-cleanup.patch
-enhanced-i-o-accounting-data-patch.patch
-enhanced-memory-accounting-data-collection.patch
-enhanced-memory-accounting-data-collection-tidy.patch
-4-4gb-incorrect-bound-check-in-do_getname.patch
-handle-quoted-module-parameters.patch
-move-irq_enter-and-irq_exit-to-common-code.patch
-remove-unused-irq_cpustat-fields.patch
-hold-bkl-for-shorter-period-in-generic_shutdown_super.patch
-cleanups-for-the-ipmi-driver.patch
-kill-blkh.patch
-ext3-cleanup-handling-of-aborted-transactions.patch
-ext3-handle-attempted-delete-of-bitmap-blocks.patch
-ext3-handle-attempted-double-delete-of-metadata.patch
-cpumask_t-initializers.patch
-time-run-too-fast-after-s3.patch
-fork-total_forks-not-counted-under-tasklist_lock.patch
-suppress-might_sleep-if-oopsing.patch
-file-sync-no-i_sem.patch
-ext3-support-for-ea-in-inode.patch
-ext3-support-for-ea-in-inode-warning-fix.patch
-off-by-one-in-drivers-parport-probec.patch
-compile-with-ffreestanding.patch
-sys_stime-needs-a-compat-function.patch
-sys_stime-needs-a-compat-function-update.patch
-sync-in-core-time-granuality-with-filesystems.patch
-sync-in-core-time-granuality-with-filesystems-sonypi-fix.patch
-remove-ip2-programs.patch
-rcu-eliminate-rcu_ctrlblklock.patch
-rcu-make-two-internal-structs-static.patch
-rcu-simplify-quiescent-state-detection.patch
-smb_file_open-retval-fix.patch
-sys_sched_setaffinity-on-up-should-fail-for-non-zero.patch
-make-gconfig-work-with-gtk-24.patch
-edd-add-edd=off-and-edd=skipmbr-options.patch
-panic_timeout-move-to-kernelh.patch
-add-pr_get_name.patch
-fix-alt-sysrq-deadlock.patch
-cpumask-range-check-before-using-value.patch
-noop-iosched-make-code-static.patch
-noop-iosched-remove-unused-includes.patch
-loop-device-recursion-avoidance.patch
-noone-uses-have_arch_si_codes-or-have_arch_sigevent_t.patch
-get_blkdev_list-cleanup.patch
-ext-apply-umask-to-symlinks-with-acls-configured-out.patch
-fix-missing-wakeup-in-ipc-sem.patch
-irq-resource-deallocation-acpi.patch
-irq-resource-deallocation-ia64.patch
-__getblk_slow-can-loop-forever-when-pages-are-partially.patch
-remove-rcu-abuse-in-cpu_idle.patch
-remove-rcu-abuse-in-cpu_idle-warning-fix.patch
-udf-simplify-udf_iget-fix-race.patch
-udf-fix-reservation-discarding.patch
-remove-dead-ext3_put_inode-prototype.patch
-compat-sigtimedwait.patch
-compat-sigtimedwait-sparc64-fix.patch
-compat-sigtimedwait-ppc64-fix.patch
-msync-set-PF_SYNCWRITE.patch
-prio_tree-roll-call-to-prio_tree_first-into-prio_tree_next.patch
-prio_tree-generalization.patch
-prio_tree-move-general-code-from-mm-to-lib.patch
-lcd-fix-memory-leak-code-cleanup.patch
-fix-conflicting-cpu_idle-declarations.patch
-removes-redundant-sys_delete_module.patch
-fix-stop-signal-race.patch
-move-group_exit-flag-into-signal_structflags-word.patch
-fix-ptracer-death-race-yielding-bogus-bug_on.patch
-move-waitchld_exit-from-task_struct-to-signal_struct.patch
-task_structexit_state-usage.patch
-trivial-uninline-kill-__exit_mm.patch
-#optimize-__make_request-a-little.patch
-selinux-scalability-add-spin_trylock_irq-and.patch
-selinux-scalability-convert-avc-to-rcu.patch
-selinux-scalability-convert-avc-to-rcu-fix.patch
-selinux-atomic_dec_and_test-bug.patch
-selinux-scalability-avc-statistics-and-tuning.patch
-selinux-regenerate-selinux-module-headers.patch
-selinux-update-selinux_task_setscheduler.patch
-selinux-audit-task-comm-if-exe-cannot-be-determined.patch
-selinux-add-dynamic-context-transition-support-to-selinux.patch
-selinux-enhance-selinux-control-of-executable-mappings.patch
-selinux-add-member-node-to-selinuxfs.patch
-selinux-eliminate-unaligned-accesses-by-policy-loading-code.patch
-oprofile-add-check_user_page_readable.patch
-oprofile-arch-independent-code-for-stack-trace.patch
-oprofile-arch-independent-code-for-stack-trace-rename-timer_init.patch
-oprofile-timer-backtrace-fix-2.patch
-oprofile-i386-support-for-stack-trace-sampling.patch
-oprofile-i386-support-for-stack-trace-sampling-cleanup.patch
-oprofile-i386-support-for-stack-trace-sampling-fix.patch
-oprofile-ia64-support-for-oprofile-stack-trace.patch
-oprofile-update-alpha-for-api-changes.patch
-oprofile-update-arm-for-api-changes.patch
-oprofile-update-ppc-for-api-changes.patch
-oprofile-update-parisc-for-api-changes.patch
-oprofile-update-s390-for-api-changes.patch
-oprofile-update-sh-for-api-changes.patch
-oprofile-update-sparc64-for-api-changes.patch
-oprofile-minor-cleanups.patch
-knfsd-nfsd_translate_wouldblocks.patch
-knfsd-svcrpc-auth_null-fixes.patch
-knfsd-svcrpc-share-code-duplicated-between-auth_unix-and-auth_null.patch
-knfsd-nfsd4-fix-open_downgrade-decode-error.patch
-knfsd-rpcsec_gss-comparing-pointer-to-0-instead-of-null.patch
-knfsd-nfsd4-fix-fileid-in-readdir-responses.patch
-knfsd-nfsd4-use-the-fsid-export-option-when-returning-the-fsid-attribute.patch
-knfsd-nfsd4-encode_dirent-cleanup.patch
-knfsd-nfsd4-encode_dirent-superfluous-assignment.patch
-knfsd-nfsd4-encode_dirent-superfluous-local-variables.patch
-knfsd-nfsd4-encode_dirent-more-readdir-attribute-encoding-to-new-function.patch
-knfsd-nfsd4-encode_dirent-simplify-nfs4_encode_dirent_fattr.patch
-knfsd-nfsd4-encode_dirent-move-rdattr_error-code-to-new-function.patch
-knfsd-nfsd4-encode_dirent-simplify-error-handling.patch
-knfsd-nfsd4-encode_dirent-simplify-control-flow.patch
-knfsd-nfsd4-encode_dirent-fix-dropit-return.patch
-knfsd-nfsd4-encode_dirent-trivial-cleanup.patch
-knfsd-move-nfserr_openmode-checking-from-nfsd_read-write-into-nfs4_preprocess_stateid_op-in-preperation-for-delegation-state.patch
-knfsd-check-the-callback-netid-in-gen_callback.patch
-knfsd-count-the-nfs4_client-structure-usage.patch
-knfsd-preparation-for-delegation-client-callback-probe.patch
-knfsd-preparation-for-delegation-client-callback-probe-warning-fixes.patch
-knfsd-probe-the-callback-path-upon-a-successful-setclientid_confirm.patch
-knfsd-check-for-existence-of-file_lock-parameter-inside-of-the-kernel-lock.patch
-knfsd-get-rid-of-the-special-delegation_stateid_t-use-the-existing-stateid_t.patch
-knfsd-add-structures-for-delegation-support.patch
-knfsd-allocate-and-initialize-the-delegation-structure.patch
-knfsd-find-a-delegation-for-a-file-given-a-stateid.patch
-knfsd-add-the-delegation-release-and-free-functions.patch
-knfsd-changes-to-expire_client.patch
-knfsd-delay-nfsd_colse-for-delegations-until-reaping.patch
-knfsd-delegation-recall-callback-rpc.patch
-knfsd-kernel-thread-for-delegation-callback.patch
-knfsd-helper-functions-for-deciding-to-grant-a-delegation.patch
-knfsd-attempt-to-hand-out-a-delegation.patch
-knfsd-remove-unnecessary-stateowner-existence-check.patch
-knfsd-check-for-openmode-violations-given-a-delegation-stateid.patch
-knfsd-add-checking-of-delegation-stateids-to-nfs4_preprocess_stateid_op.patch
-knfsd-add-the-delegreturn-operation.patch
-knfsd-add-to-the-laundromat-service-for-delegations.patch
-knfsd-clear-the-recall_lru-of-delegations-at-shutdown.patch
-invalidate_inodes-speedup.patch
-linux-2.6.8.1-49-rpc_workqueue.patch
-linux-2.6.8.1-50-rpc_queue_lock.patch
-fbdev-sis-framebuffer-driver-update-1717.patch
-fbdev-sysfs-fix.patch
-pm2fb-module-parameters-and-module-conditional-code.patch
-pm2fb-save-restore-memory-config.patch
-pm2fb-use-modedb-in-modules.patch
-pm2fb-fix-big-endian-sparc-support.patch
-pm2fb-fix-fbi-image-display-on-24-bit-depth-big-endian.patch
-fix-rom-enable-disable-in-r128-and-radeon-fb-drivers.patch
-fbdev-cleanup-i2c-code-of-rivafb.patch
-fbdev-revive-bios-less-booting-for-rage-xl-cards.patch
-fbdev-revive-global_mode_option.patch
-fbcon-fbdev-add-blanking-notification.patch
-fbcon-fbdev-add-blanking-notification-fix.patch
-fbdev-check-return-value-of-fb_add_videomode.patch
-fbdev-do-a-symbol_put-for-each-symbol_get-in-savagefb.patch
-fbdev-add-viewsonic-pf775a-to-broken-display-database.patch
-fbdev-fix-default-timings-in-vga16fb.patch
-fbdev-reduce-stack-usage-of-intelfb.patch
-zr36067-driver-correct-jpeg-app-com-markers.patch
-zr36067-driver-ppc-be-port.patch
-zr36067-driver-reduce-stack-size-usage.patch

 Merged

+gfp_zero-pktcdvd-fix.patch

 Fix the __GFP_ZERO stuff

+s390-add-missing-pte_read-function.patch

 s/390 build fix

+mmc-build-fix.patch

 drivers/mmc build fix

+bk-acpi-revert-20041210.patch

 Remove bad patch from bk-acpi.

+acpi-kfree-fix.patch

 Might fix an acpi bug.

+agpgart-allow-multiple-backends-to-be-initialized.patch
+drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
+fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
+agpgart-add-bridge-parameter-to-driver-functions.patch

 Support for multiple AGP bridges.

+x86_64-agp-hack.patch

 Hack it (badly) to make x86_64 compile.

+vmscan-count-writeback-pages-in-nr_scanned.patch

 page reclaim fix

-xircom_tulip_cb-build-fix-warning-fix.patch

 Folded into xircom_tulip_cb-build-fix.patch

+add-omap-support-to-smc91x-ethernet-driver.patch
+restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
+netfilter-ipt-build-fix.patch

 net fixes

+split-bprm_apply_creds-into-two-functions.patch
+merge-_vm_enough_memorys-into-a-common-helper.patch

 security work

+ppc64-add-performance-monitor-register-information-to-processorh.patch
+ppc64-use-newer-rtas-call-when-available.patch
+ppc64-clean-up-trap-handling.patch
+ppc64-clean-up-trap-handling-in-heads.patch
+ppc64-log-machine-check-errors-to-error-log-and-nvram.patch
+ppc64-iommu-cleanups-rename-pci_dma_directc.patch
+ppc64-iommu-cleanups-main-cleanup-patch.patch

 ppc64 updates

+dmi_iterate-fix.patch

 dmi oops fix

+arch-i386-kernel-cpu-mtrr-too-many-bits-are-masked-off-from-cr4.patch

 x86 mtrr fix

+pm-introduce-pm_message_t.patch
+mark-older-power-managment-as-deprecated.patch
+swsusp-device-power-management-fix.patch
+swsusp-properly-suspend-and-resume-all-devices.patch

 swsusp updates

+request_irq-avoid-slash-in-proc-directory-entries.patch

 Don't try to create /proc files which contain slashes

+prohibit-slash-in-proc-directory-entry-names.patch

 Error out if someone tries to do it again.

+speedup-proc-pid-maps.patch

 Optimise /proc/pid/maps

+fix-cdrom-autoclose.patch

 cdrom fix

+move-accounting-function-calls-out-of-critical-vm-code-paths.patch

 Speed up the new accounting code.

-ioctl-rework.patch
+ioctl-rework-2.patch

 New version of the patch which permits bkl-less ioctl implementations.

+fix-__ptrace_unlink-task_traced-recovery-for-real-parent.patch
+fix-coredump_wait-deadlock-with-ptracer-tracee-on-shared-mm.patch

 More ptrace fixes from Roland.

+oprofile-fix-ia64-callgraph-bug-with-old-gcc.patch

 oprofile fix

+nfsd4_setclientid_confirm-locking-fix.patch

 Fix the new nfsd code.

+sched-remove-outdated-misleading-comments.patch

 Fix CPU scheduler comments

+debug-sched-domains-before-attach.patch

 CPU scheduler debugging

+replace-numnodes-with-node_online_map-ia64-fix.patch

 Fix replace-numnodes-with-node_online_map-ia64.patch

+replace-numnodes-with-node_online_map-fix.patch

 Fix replace-numnodes-with-node_online_map.patch

+block2mtd-avoid-touching-truncate_count.patch

 Don't play with ->truncate_count - it is going away.

+cpu_idle-smp_processor_id-warning-fix.patch

 Avoid an "smp_processor_id in preemptible code" warning.

+add-page-becoming-writable-notification-build-fix.patch

 Fix add-page-becoming-writable-notification-fix.patch

+kexec-kexecx86_64-4level-fix-unfix.patch

 Hack to make x86_64 compile.  Will break kexec.

-reiser4-unstatic-kswapd.patch

 Hopefully not needed.

+generic-serial-cli-conversion.patch
+specialix-io8-cli-conversion.patch
+rio-cli-conversion.patch
+rio_linux-64-bit-workaround.patch
+sx-cli-conversion.patch

 De-cli()ify a few char drivers.

+fbdev-rivafb-should-recognize-nf2-igp.patch

 New PCI ID.

+bug-on-error-handlings-in-ext3-under-i-o-failure.patch
+bug-on-error-handlings-in-ext3-under-i-o-failure-fix.patch

 Fix ext3 I/O error handling.

+cputime-introduce-cputime-vs-move-accounting-function-calls-out-of-critical-vm-code-paths.patch

 Fix the cputime patches for the I/O accounting speedup patch.

+update-hugetlb-documentation.patch

 Documentation update

+ide-cd-is-very-noisy.patch

 Kill some printks

+signedness-fix-in-deadline-ioschedc.patch

 deadline /sys fix

+cleanup-virtual-console-selectionc-interface.patch

 Code cleanup

+warn-about-cli-sti-co-uses-even-on-up.patch

 deprecate cli() and sti().

+remove-umsdos-from-tree.patch

 Kill umsdos.

+kill-quota_v2c-printk-of-size_t-warning.patch
+kill-gen_init_cpioc-printk-of-size_t-warning.patch
+silence-numerous-size_t-warnings-in-drivers-acpi-processor_idlec.patch

 size_t warning fixes

+make-irda-string-tables-conditional-on-config_irda_debug.patch

 Dead code fix

+fix-unresolved-mtd-symbols-in-scx200_docflashc.patch
+fix-module_param-type-mismatch-in-drivers-char-n_hdlcc.patch

 Build fixes

+drivers-char-misc-cleanups.patch
+pktcdvd-make-two-functions-static.patch
+pktcdvd-grep-friendly-function-prototypes.patch
+pktcdvd-small-documentation-update.patch
+isofs-remove-useless-include.patch
+synaptics-remove-unused-struct-member-variable.patch
+kill-one-if-x-vfreex-usage.patch
+smbfs-make-some-functions-static.patch

 Various small cleanups and fixes

+periodically-scan-redzone-entries-and-slab-control-structures.patch

 Additional slab sanity checking



number of patches in -mm: 560
number of changesets in external trees: 479
number of patches in -mm only: 544
total patches: 1023



All 560 patches:


linus.patch

gfp_zero-pktcdvd-fix.patch
  __GFP_ZERO pktcdvd fix

s390-add-missing-pte_read-function.patch
  s390: add missing pte_read function

mmc-build-fix.patch
  mmc build fix

bk-acpi.patch

bk-acpi-revert-20041210.patch
  bk-acpi-revert-20041210

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

acpi-kfree-fix.patch
  a

bk-alsa.patch

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

bk-dtor-input.patch

bk-kconfig.patch

bk-netdev.patch

via-rhine-warning-fix.patch
  via-rhine warning fix

hostap-fix-kconfig-typos-and-missing-select-crypto.patch
  hostap: fix Kconfig typos and missing select CRYPTO

ixgb-lr-card-support.patch
  ixgb LR card support

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

agpgart-allow-multiple-backends-to-be-initialized.patch
  agpgart: allow multiple backends to be initialized

drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  drm: add support for new multiple agp bridge agpgart api

fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  fb: add support for new multiple agp bridge agpgart api

agpgart-add-bridge-parameter-to-driver-functions.patch
  agpgart: add bridge parameter to driver functions

x86_64-agp-hack.patch
  x86_64 agp hack

vmscan-count-writeback-pages-in-nr_scanned.patch
  vmscan: count writeback pages in nr_scanned

vm-pageout-throttling.patch
  vm: pageout throttling

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

xircom_tulip_cb-build-fix.patch
  xircom_tulip_cb.c build fix

net-netconsole-poll-support-for-3c509.patch
  net: Netconsole poll support for 3c509

pcnet32-79c976-with-fiber-optic.patch
  pcnet32: 79c976 with fiber optic fix

multicast-filtering-for-tunc.patch
  Multicast filtering for tun.c

r8169-missing-netif_poll_enable-and-irq-ack.patch
  r8169: missing netif_poll_enable and irq ack

r8169-c-101.patch
  r8169: C 101

r8169-large-send-enablement.patch
  r8169: Large Send enablement

r8169-reduce-max-mtu-for-large-frames.patch
  r8169: reduce max MTU for large frames

r8169-oversized-driver-field-for-ethtool.patch
  r8169: oversized driver field for ethtool

fix-ibm_emac-autonegotiation-result-parsing.patch
  EMAC: fix ibm_emac autonegotiation result parsing

add-omap-support-to-smc91x-ethernet-driver.patch
  Add OMAP support to smc91x Ethernet driver

restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
  Restore net/sched/ipt.c After iptables Kmod Cleanup

netfilter-ipt-build-fix.patch
  netfilter: ipt build fix

split-bprm_apply_creds-into-two-functions.patch
  split bprm_apply_creds into two functions

merge-_vm_enough_memorys-into-a-common-helper.patch
  merge *_vm_enough_memory()s into a common helper

ppc64-add-performance-monitor-register-information-to-processorh.patch
  ppc64: add performance monitor register information to processor.h

ppc64-use-newer-rtas-call-when-available.patch
  ppc64: use newer RTAS call when available

ppc64-clean-up-trap-handling.patch
  ppc64: clean up trap handling

ppc64-clean-up-trap-handling-in-heads.patch
  ppc64: clean up trap handling in head.S

ppc64-log-machine-check-errors-to-error-log-and-nvram.patch
  ppc64: Log machine check errors to error log and NVRAM

ppc64-iommu-cleanups-rename-pci_dma_directc.patch
  ppc64: IOMMU cleanups: rename pci_dma_direct.c

ppc64-iommu-cleanups-main-cleanup-patch.patch
  ppc64: IOMMU cleanups: Main cleanup patch

ppc64-reloc_hide.patch

superhyway-bus-support.patch
  SuperHyway bus support

dmi_iterate-fix.patch
  dmi_iterate() fix

arch-i386-kernel-cpu-mtrr-too-many-bits-are-masked-off-from-cr4.patch
  arch/i386/kernel/cpu/mtrr: too many bits are masked off from CR4

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

pm-introduce-pm_message_t.patch
  pm: introduce pm_message_t

mark-older-power-managment-as-deprecated.patch
  mark older power managment as deprecated

swsusp-device-power-management-fix.patch
  swsusp: device power management fix

swsusp-properly-suspend-and-resume-all-devices.patch
  swsusp: properly suspend and resume all devices

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-takes-char-fix.patch
  kmap_atomic-takes-char-fix

kmap_atomic-fallout.patch
  kmap_atomic fallout

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

CONFIG_SOUND_VIA82CXXX_PROCFS.patch
  Add CONFIG_SOUND_VIA82CXXX_PROCFS

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

request_irq-avoid-slash-in-proc-directory-entries.patch
  request_irq: avoid slash in proc directory entries

prohibit-slash-in-proc-directory-entry-names.patch
  prohibit slash in proc directory entry names

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

fix-cdrom-autoclose.patch
  fix cdrom autoclose

move-accounting-function-calls-out-of-critical-vm-code-paths.patch
  Move accounting function calls out of critical vm code paths

gen_init_cpio-symlink-pipe-socket-support.patch
  gen_init_cpio symlink, pipe and socket support

gen_init_cpio-slink_pipe_sock_2.patch
  gen_init_cpio-slink_pipe_sock_2

initramfs-allow-no-trailer.patch
  INITRAMFS: allow no trailer

htree-telldir-fix.patch
  ext3 htree telldir() fix

ioctl-rework-2.patch
  ioctl rework #2

initramfs-unprivileged-image-creation.patch
  initramfs: unprivileged image creation

fix-__ptrace_unlink-task_traced-recovery-for-real-parent.patch
  fix __ptrace_unlink TASK_TRACED recovery for real parent

fix-coredump_wait-deadlock-with-ptracer-tracee-on-shared-mm.patch
  fix coredump_wait deadlock with ptracer & tracee on shared mm

oprofile-fix-ia64-callgraph-bug-with-old-gcc.patch
  oprofile: fix ia64 callgraph bug with old gcc

pcmcia-new-ds-cs-interface.patch
  pcmcia: new ds - cs interface

pcmcia-call-device-drivers-from-ds-not-from-cs.patch
  pcmcia: call device drivers from ds, not from cs

pcmcia-unify-bind_mtd-and-pcmcia_bind_mtd.patch
  pcmcia: unify bind_mtd and pcmcia_bind_mtd

pcmcia-unfiy-bind_device-and-pcmcia_bind_device.patch
  pcmcia: unfiy bind_device and pcmcia_bind_device

pcmcia-device-model-integration-can-only-be-submitted-under-gpl.patch
  pcmcia: device model integration can only be submitted under GPL

pcmcia-add-pcmcia_devices.patch
  pcmcia: add pcmcia_device(s)

pcmcia-remove-socket_bind_t-use-pcmcia_devices-instead.patch
  pcmcia: remove socket_bind_t, use pcmcia_devices instead

pcmcia-remove-internal-module-use-count-use-module_refcount-instead.patch
  pcmcia: remove internal module use count, use module_refcount instead

pcmcia-set-drivers-owner-field.patch
  pcmcia: set driver's .owner field

pcmcia-move-pcmcia_unregister_client-to-ds.patch
  pcmcia: move pcmcia_(un,)register_client to ds

pcmcia-device-model-integration-can-only-be-submitted-under-gpl-part-2.patch
  pcmcia: device model integration can only be submitted under GPL, part 2

pcmcia-use-kref-instead-of-native-atomic-counter.patch
  pcmcia: use kref instead of native atomic counter

pcmcia-add-pcmcia_putget_socket.patch
  pcmcia: add pcmcia_(put,get)_socket

pcmcia-grab-a-reference-to-the-cs-socket-in-ds.patch
  pcmcia: grab a reference to the cs-socket in ds

pcmcia-get-a-reference-to-ds-socket-for-each-pcmcia_device.patch
  pcmcia: get a reference to ds-socket for each pcmcia_device

pcmcia-add-a-pointer-to-client-in-struct-pcmcia_device.patch
  pcmcia: add a pointer to client in struct pcmcia_device

pcmcia-use-pcmcia_device-in-send_event.patch
  pcmcia: use pcmcia_device in send_event

pcmcia-use-pcmcia_device-to-mark-clients-as-stale.patch
  pcmcia: use pcmcia_device to mark clients as stale

pcmcia-code-moving-in-ds.patch
  pcmcia: code moving in ds

pcmcia-use-pcmcia_device-in-register_client.patch
  pcmcia: use pcmcia_device in register_client

pcmcia-direct-ordered-unbind-of-devices.patch
  pcmcia: direct-ordered unbind of devices

pcmcia-bug-on-dev_list-=-null.patch
  pcmcia: BUG on dev_list != NULL

pcmcia-bug-if-clients-are-kept-too-long.patch
  pcmcia: BUG() if clients are kept too long

pcmcia-move-struct-client_t-inside-struct-pcmcia_device.patch
  pcmcia: move struct client_t inside struct pcmcia_device

pcmcia-use-driver_find-in-ds.patch
  pcmcia: use driver_find in ds

pcmcia-set_netdev-for-network-devices.patch
  pcmcia: SET_NETDEV for network devices

pcmcia-set_netdev-for-wireless-network-devices.patch
  pcmcia: SET_NETDEV for wireless network devices

pcmcia-reduce-stack-usage-in-ds_ioctl-randy-dunlap.patch
  pcmcia: reduce stack usage in ds_ioctl (Randy Dunlap)

pcmcia-add-disable_clkrun-option.patch
  pcmcia: Add disable_clkrun option

pcmcia-rename-pcmcia-devices.patch
  pcmcia: rename PCMCIA devices

pcmcia-pd6729-e-mail-update.patch
  pcmcia: pd6729: e-mail update

pcmcia-pd6729-cleanups.patch
  pcmcia: pd6729: cleanups

pcmcia-pd6729-isa_irq-handling.patch
  pcmcia: pd6729: isa_irq handling

pcmcia-remove-obsolete-code.patch
  pcmcia: remove obsolete code

pcmcia-remove-pending_events.patch
  pcmcia: remove pending_events

pcmcia-remove-client_attributes.patch
  pcmcia: remove client_attributes

pcmcia-remove-unneeded-parameter-from-rsrc_mgr.patch
  pcmcia: remove unneeded parameter from rsrc_mgr

pcmcia-remove-dev_info-from-client.patch
  pcmcia: remove dev_info from client

pcmcia-remove-mtd-and-bulkmem-replaced-by-pcmciamtd.patch
  pcmcia: remove mtd and bulkmem (replaced by pcmciamtd)

pcmcia-per-socket-resource-database.patch
  pcmcia: per-socket resource database

pcmcia-validate_mem-only-for-non-statically-mapped-sockets.patch
  pcmcia: validate_mem only for non-statically mapped sockets

pcmcia-adjust_io_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: adjust_io_region only for non-statically mapped sockets

pcmcia-find_io_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: find_io_region only for non-statically mapped sockets

pcmcia-find_mem_region-only-for-non-statically-mapped-sockets.patch
  pcmcia: find_mem_region only for non-statically mapped sockets

pcmcia-adjust_-and-release_resources-only-for-non-statically-mapped-sockets.patch
  pcmcia: adjust_ and release_resources only for non-statically mapped sockets

pcmcia-move-resource-handling-code-only-for-non-statically-mapped-sockets-to-other-file.patch
  pcmcia: move resource handling code only for non-statically mapped sockets to other file

pcmcia-make-rsrc_nonstatic-an-independend-module.patch
  pcmcia: make rsrc_nonstatic an independend module

pcmcia-allocate-resource-database-per-socket.patch
  pcmcia: allocate resource database per-socket

pcmcia-remove-typedef.patch
  pcmcia: remove typedef

pcmcia-grab-lock-in-resource_release.patch
  pcmcia: grab lock in resource_release

nfsd4_setclientid_confirm-locking-fix.patch
  nfsd4_setclientid_confirm locking fix

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

kgdb-kill-off-highmem_start_page.patch
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

perfctr-core.patch
  perfctr: core

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

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

sched-more-agressive-wake_idle.patch
  sched: more agressive wake_idle()

sched-can_migrate-exception-for-idle-cpus.patch
  sched: can_migrate exception for idle cpus

sched-newidle-fix.patch
  sched: newidle fix

sched-active_load_balance-fixlet.patch
  sched: active_load_balance() fixlet

sched-reset-cache_hot_time.patch
  sched: reset cache_hot_time

schedc-whitespace-mangler.patch
  sched.c whitespace mangler

sched-alter_kthread_prio.patch
  sched: alter_kthread_prio

sched-adjust_timeslice_granularity.patch
  sched: adjust_timeslice_granularity

sched-add_requeue_task.patch
  sched: add_requeue_task

requeue_granularity.patch
  sched: requeue_granularity

sched-remove_interactive_credit.patch
  sched: remove_interactive_credit

sched-use-cached-current-value.patch
  sched: use cached current value

dont-hide-thread_group_leader-from-grep.patch
  don't hide thread_group_leader() from grep

sched-no-need-to-recalculate-rq.patch
  sched: no need to recalculate rq

export-sched_setscheduler-for-kernel-module-use.patch
  export sched_setscheduler() for kernel module use

sched-remove-outdated-misleading-comments.patch
  sched: remove outdated/misleading comments

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts.patch
  sched-fix-scheduling-latencies-in-mttrc reenables interrupts

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

debug-sched-domains-before-attach.patch
  debug sched domains before attach

replace-numnodes-with-node_online_map-alpha.patch
  Subject: [RFC PATCH 1/10] Replace 'numnodes' with 'node_online_map' - alpha

replace-numnodes-with-node_online_map-arm.patch
  Subject: [RFC PATCH 2/10] Replace 'numnodes' with 'node_online_map' - arm

replace-numnodes-with-node_online_map-i386.patch
  Subject: [RFC PATCH 3/10] Replace 'numnodes' with 'node_online_map' - i386

replace-numnodes-with-node_online_map-ia64.patch
  Subject: [RFC PATCH 4/10] Replace 'numnodes' with 'node_online_map' - ia64

replace-numnodes-with-node_online_map-ia64-fix.patch
  replace-numnodes-with-node_online_map-ia64 fix

replace-numnodes-with-node_online_map-m32r.patch
  Subject: [RFC PATCH 5/10] Replace 'numnodes' with 'node_online_map' - m32r

replace-numnodes-with-node_online_map-mips.patch
  Subject: [RFC PATCH 6/10] Replace 'numnodes' with 'node_online_map' - mips

replace-numnodes-with-node_online_map-parisc.patch
  Subject: [RFC PATCH 7/10] Replace 'numnodes' with 'node_online_map' - parisc

replace-numnodes-with-node_online_map-ppc64.patch
  Subject: [RFC PATCH 8/10] Replace 'numnodes' with 'node_online_map' - ppc64

replace-numnodes-with-node_online_map-x86_64.patch
  Subject: [RFC PATCH 9/10] Replace 'numnodes' with 'node_online_map' - x86_64

replace-numnodes-with-node_online_map.patch
  Subject: [RFC PATCH 10/10] Replace 'numnodes' with 'node_online_map' - 	arch-independent

replace-numnodes-with-node_online_map-fix.patch
  replace-numnodes-with-node_online_map fix

block2mtd-avoid-touching-truncate_count.patch
  block2mtd: avoid touching truncate_count

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

cpu_idle-smp_processor_id-warning-fix.patch
  cpu_idle-smp_processor_id-warning-fix

oprofile-preempt-warning-fixes.patch
  oprofile preempt warning fixes

smp_processor_id-commentary.patch
  smp_processor_id() commentary

cpu_down-warning-fix.patch
  cpu_down() warning fix

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

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

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

kexec-apic-virt-wire-fix.patch
  kexec: apic-virt-wire fix

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-kexecx86_64-4level-fix.patch
  kexec-kexecx86_64-4level-fix

kexec-kexecx86_64-4level-fix-unfix.patch
  kexec-kexecx86_64-4level-fix unfix

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-loading-kernel-from-non-default-offset-fix.patch
  kdump: fix bss compile error

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

kexec-ppc-support.patch
  kexec: ppc support

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-memory-preserving-reboot-using-kexec-fix.patch
  kdump: Fix for boot problems on SMP

kdump-config_discontigmem-fix.patch
  kdump: CONFIG_DISCONTIGMEM fix

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
  crashdump-routines-for-copying-dump-pages-kmap-fiddle

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

x86-rename-apic_mode_exint.patch
  x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  x86: local apic fix

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

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

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

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

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-add-eeprom_reset-for-3c900-boomerang.patch
  3c59x: Add EEPROM_RESET for 3c900 Boomerang

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

new-serial-flow-control.patch
  new serial flow control

mpsc-driver-patch.patch
  serial: MPSC driver

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

rio-cli-conversion.patch
  RIO cli() conversion

rio_linux-64-bit-workaround.patch
  rio_linux 64 bit workaround

sx-cli-conversion.patch
  SX cli() conversion

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-improve-hash-code-in-linearc.patch
  md: improve 'hash' code in linear.c

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revisit-for-mm-page_allocc-fix.patch
  no-buddy-bitmap-patch-revisit-for-mm-page_allocc fix

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

fbdev-rivafb-should-recognize-nf2-igp.patch
  fbdev: rivafb should recognize NF2/IGP

raid6-altivec-support.patch
  raid6: altivec support

remove-export_symbol_novers.patch
  Remove EXPORT_SYMBOL_NOVERS

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

readpage-vs-invalidate-fix.patch
  readpage-vs-invalidate fix

invalidate_inode_pages-mmap-coherency-fix.patch
  invalidate_inode_pages2() mmap coherency fix

bug-on-error-handlings-in-ext3-under-i-o-failure.patch
  BUG on error handlings in Ext3 under I/O failure condition

bug-on-error-handlings-in-ext3-under-i-o-failure-fix.patch
  bug-on-error-handlings-in-ext3-under-i-o-failure fix

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-introduce-cputime-vs-move-accounting-function-calls-out-of-critical-vm-code-paths.patch
  cputime-introduce-cputime-vs-move-accounting-function-calls-out-of-critical-vm-code-paths

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

mm-check_rlimit-oops-on-p-signal.patch
  check_rlimit oops on p->signal

cputime-microsecond-based-cputime-for-s390.patch
  cputime: microsecond based cputime for s390

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

lock-initializer-unifying-batch-2-alpha.patch
  Lock initializer unifying: ALPHA

lock-initializer-unifying-batch-2-ia64.patch
  Lock initializer unifying: IA64

lock-initializer-unifying-batch-2-m32r.patch
  Lock initializer unifying: M32R

lock-initializer-unifying-batch-2-mips.patch
  Lock initializer unifying: MIPS

lock-initializer-unifying-batch-2-misc-drivers.patch
  Lock initializer unifying: Misc drivers

lock-initializer-unifying-batch-2-block-devices.patch
  Lock initializer unifying: Block devices

lock-initializer-unifying-batch-2-drm.patch
  Lock initializer unifying: DRM

lock-initializer-unifying-batch-2-character-devices.patch
  Lock initializer unifying: character devices

lock-initializer-unifying-batch-2-rio.patch
  Lock initializer unifying: RIO

lock-initializer-unifying-batch-2-firewire.patch
  Lock initializer unifying: Firewire

lock-initializer-unifying-batch-2-isdn.patch
  Lock initializer unifying: ISDN

lock-initializer-unifying-batch-2-raid.patch
  Lock initializer unifying: Raid

lock-initializer-unifying-batch-2-media-drivers.patch
  Lock initializer unifying: media drivers

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

lock-initializer-cleanup-common-headers.patch
  Lock initializer cleanup (common headers)

lock-initializer-cleanup-character-devices.patch
  Lock initializer cleanup (character devices)

lock-initializer-cleanup-core.patch
  Lock initializer cleanup (Core)

moxa-update-status-of-moxa-smartio-driver.patch
  moxa: Update status of Moxa Smartio driver

moxa-remove-ancient-changelog-readmemoxa.patch
  moxa: Remove ancient changelog README.moxa

moxa-remove-readmemoxa-from-documentation-00-index.patch
  moxa: Remove README.moxa from Documentation/00-INDEX

specialix-remove-bouncing-e-mail-address.patch
  specialix: remove bouncing e-mail address

stallion-update-to-documentation-stalliontxt.patch
  stallion: Update to Documentation/stallion.txt

riscom8-update-staus-and-documentation-of-driver.patch
  riscom8: Update staus and documentation of driver

pm-remove-outdated-docs.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: pm: remove outdated docs

docs-add-sparse-howto.patch
  From: Pavel Machek <pavel@ucw.cz>
  Subject: docs: add sparse howto

cciss-documentation-update.patch
  cciss: Documentation update

cciss-correct-mailing-list-address-in-source-code.patch
  cciss: Correct mailing list address in source code

cpqarray-correct-mailing-list-address-in-source-code.patch
  cpqarray: Correct mailing list address in source code

sh-remove-x86-specific-help-in-kconfig.patch
  sh: Remove x86-specific help in Kconfig

cyclades-put-readmecycladez-in-documentation-serial.patch
  cyclades: Put README.cycladeZ in Documentation/serial

tipar-document-driver-options.patch
  tipar: Document driver options

tipar-code-cleanup.patch
  tipar: Code cleanup

update-hugetlb-documentation.patch
  update hugetlb documentation

eth1394-module_parm-conversion.patch
  eth1394 MODULE_PARM conversion

isapnp-module_param-conversion.patch
  isapnp module_param conversion

sr-module_param-conversion.patch
  sr module_param conversion

media-video-module_param-conversion.patch
  media/video module_param conversion

btaudio-module_param-conversion.patch
  btaudio module_param conversion

small-drivers-char-rio-cleanups-fwd.patch
  small drivers/char/rio/ cleanups

small-char-generic_serialc-cleanup-fwd.patch
  small char/generic_serial.c cleanup

debug_bugverbose-for-i386-fwd.patch
  DEBUG_BUGVERBOSE for i386

telephony-ixjc-cleanup-fwd.patch
  telephony/ixj.c cleanup

char-cycladesc-remove-unused-code-fwd.patch
  char/cyclades.c: remove unused code

oss-ac97-quirk-facility.patch
  oss: AC97 quirk facility

oss-ac97-quirk-facility-fix.patch
  oss-ac97-quirk-facility fix

ext3-use-generic_open_file-to-fix-possible-preemption-bugs.patch
  ext3: use generic_open_file to fix possible preemption bugs

bttv-i2cc-make-two-functions-static.patch
  bttv-i2c.c: make two functions static

bttv-riscc-make-some-functions-static.patch
  bttv-risc.c: make some functions static

bttv-help-fix.patch
  bttv help fix

zoran_driverc-make-zoran_num_formats-static.patch
  zoran_driver.c: make zoran_num_formats static

media-video-msp3400c-remove-unused-struct-d1.patch
  media/video/msp3400.c: remove unused struct d1

zoran_devicec-make-zr36057_init_vfe-static.patch
  zoran_device.c: make zr36057_init_vfe static

drivers-media-video-the-easy-cleanups.patch
  drivers/media/video: the easy cleanups

small-ftape-cleanups-fwd.patch
  small ftape cleanups

reiser3-cleanups.patch
  reiser3 cleanups

cdromc-make-several-functions-static.patch
  cdrom.c: make several functions static (fwd)

fs-coda-psdevc-shouldnt-include-lph.patch
  fs/coda/psdev.c shouldn't include lp.h

remove-early_param-tests.patch
  remove early_param test code

MODULE_PARM-allmod.patch
  MODULE_PARM conversions

MODULE_PARM-allyes.patch
  MODULE_PARM conversions

lockd-fix-two-struct-definitions.patch
  lockd: fix two struct definitions

small-mca-cleanups-fwd.patch
  small MCA cleanups

small-drivers-media-radio-cleanups-fwd.patch
  small drivers/media/radio/ cleanups

ifdef-typos-arch_ppc_platforms_prep_setupc.patch
  ifdef typos: arch_ppc_platforms_prep_setup.c

ifdef-typos-arch_ppc_platforms_prep_setupc-another-one.patch
  ifdef typos: arch_ppc_platforms_prep_setup.c -another one

ifdef-typos-arch_ppc_syslib_ppc4xx_dmac.patch
  ifdef typos: arch_ppc_syslib_ppc4xx_dma.c

ifdef-typos-arch_sh_boards_renesas_hs7751rvoip_ioc.patch
  ifdef typos: arch_sh_boards_renesas_hs7751rvoip_io.c

ifdef-typos-drivers_char_ipmi_ipmi_si_intfc.patch
  ifdef typos: drivers_char_ipmi_ipmi_si_intf.c

ifdef-typos-drivers_net_wireless_wavelan_csc.patch
  ifdef typos: drivers_net_wireless_wavelan_cs.c

ifdef-typos-drivers_usb_net_usbnetc.patch
  ifdef typos: drivers_usb_net_usbnet.c

ifdef-typos-mips-au100_usb_device.patch
  ifdef typos mips: AU1[0X]00_USB_DEVICE

ipmi-use-c99-struct-inits.patch
  IPMI: use C99 struct inits.

drm-remove-unused-functions-fwd.patch
  DRM: remove unused functions

floppyc-remove-an-unused-function-fwd.patch
  floppy.c: remove an unused function

media-video-ir-kbd-i2cc-remove-an-unused-function-fwd.patch
  media/video/ir-kbd-i2c.c: remove an unused function

nfs-remove-an-unused-function-fwd.patch
  NFS: remove an unused function

watchdog-machzwdc-remove-unused-functions-fwd.patch
  watchdog/machzwd.c: remove unused functions

video-drivers-remove-unused-functions-fwd.patch
  video drivers: remove unused functions

isdn-b1pcmciac-remove-an-unused-variable-fwd.patch
  ISDN b1pcmcia.c: remove an unused variable

binfmt_scriptc-make-struct-script_format-static-fwd.patch
  binfmt_script.c: make struct script_format static

bioc-make-bio_destructor-static-fwd.patch
  bio.c: make bio_destructor static

devpts-inodec-make-one-struct-static-fwd.patch
  devpts/inode.c: make one struct static

small-proc_fs-cleanups-fwd.patch
  small proc_fs cleanups

kernel-timerc-comment-typo.patch
  Fix kernel/timer.c comment typo

mark-qnx4fs_rw-as-broken-fwd.patch
  mark QNX4FS_RW as BROKEN

oss-remove-unused-functions-fwd.patch
  OSS: remove unused functions

dvb-av7110_hwc-remove-unused-functions-fwd.patch
  DVB av7110_hw.c: remove unused functions

schedc-remove-an-unused-macro-fwd.patch
  sched.c: remove an unused macro

scsi-ahcic-remove-an-unused-function-fwd.patch
  scsi/ahci.c: remove an unused function

scsi-aic7xxx-aic79xx_osmc-remove-an-unused-function-fwd.patch
  scsi/aic7xxx/aic79xx_osm.c: remove an unused function

schedc-remove-an-unused-function-fwd.patch
  sched.c: remove an unused function

prism54-small-prismcompat-cleanup-fwd.patch
  prism54: small prismcompat cleanup

some-parport_pcc-cleanups-fwd.patch
  some parport_pc.c cleanups

fix-typo-and-email-in-saktxt.patch
  fix typo and email in SAK.txt

cris-remove-kernel-20-ifdefs-fwd.patch
  cris: remove kernel 2.0 #ifdef's

afs-afs_voltypes-isnt-always-required-fwd.patch
  AFS: afs_voltypes isn't always required

befs-if-0-two-unused-global-functions-fwd.patch
  befs: #if 0 two unused global functions

binfmt_scriptc-make-em86_format-static.patch
  binfmt_script.c: make em86_format static

remove-unused-include-asm-m68k-adb_mouseh.patch
  remove unused include/asm-m68k/adb_mouse.h

scsi-aic7xxx-remove-two-useless-variables.patch
  scsi/aic7xxx/: remove two useless variables

remove-in_string_c.patch
  remove IN_STRING_C

remove-ct_to_secs-ct_to_usecs.patch
  remove CT_TO_SECS()/CT_TO_USECS()

bttv-driverc-make-some-variables-static.patch
  bttv-driver.c: make some variables static

arch-alpha-kconfig-kill-stale-reference-to-documentation-smptex.patch
  arch/alpha/Kconfig: Kill stale reference to Documentation/smp.tex

init-initramfsc-make-unpack_to_rootfs-static.patch
  init/initramfs.c: make unpack_to_rootfs static

oss-misc-cleanups.patch
  OSS: misc cleanups

inux-269-fs-proc-basec-array-size.patch
  fs/proc/base.c: array size

linux-269-fs-proc-proc_ttyc-avoid-array.patch
  fs/proc/proc_tty.c: avoid array

optimize-prefetch-usage-in-list_for_each_xxx.patch
  optimize prefetch() usage in list_for_each_xxx

signalc-convert-assertion-to-bug_on.patch
  signal.c: convert assertion to BUG_ON()

right-severity-level-for-fatal-message.patch
  Right severity level for fatal message

remove-unused-drivers-char-rio-cdprotoh.patch
  remove unused drivers/char/rio/cdproto.h

remove-unused-drivers-char-rsf16fmih.patch
  remove unused drivers/char/rsf16fmi.h

mtd-added-nec-upd29f064115-support.patch
  mtd: added NEC uPD29F064115 support

waiting-10s-before-mounting-root-filesystem.patch
  retry mounting the root filesystem at boot time

ide-cd-is-very-noisy.patch
  IDE CD is very noisy

signedness-fix-in-deadline-ioschedc.patch
  signedness fix in deadline-iosched.c

cleanup-virtual-console-selectionc-interface.patch
  cleanup virtual console <-> selection.c interface

warn-about-cli-sti-co-uses-even-on-up.patch
  warn about cli, sti & co uses even on UP

remove-umsdos-from-tree.patch
  remove umsdos from tree

kill-quota_v2c-printk-of-size_t-warning.patch
  kill quota_v2.c printk() of size_t warning

kill-gen_init_cpioc-printk-of-size_t-warning.patch
  kill gen_init_cpio.c printk() of size_t warning

silence-numerous-size_t-warnings-in-drivers-acpi-processor_idlec.patch
  silence numerous size_t warnings in drivers/acpi/processor_idle.c

make-irda-string-tables-conditional-on-config_irda_debug.patch
  make IRDA string tables conditional on CONFIG_IRDA_DEBUG

fix-unresolved-mtd-symbols-in-scx200_docflashc.patch
  fix unresolved MTD symbols in scx200_docflash.c

fix-module_param-type-mismatch-in-drivers-char-n_hdlcc.patch
  fix module_param() type mismatch in drivers/char/n_hdlc.c

drivers-char-misc-cleanups.patch
  drivers/char/: misc cleanups

pktcdvd-make-two-functions-static.patch
  pktcdvd: make two functions static

pktcdvd-grep-friendly-function-prototypes.patch
  pktcdvd: grep-friendly function prototypes

pktcdvd-small-documentation-update.patch
  pktcdvd: Small documentation update

isofs-remove-useless-include.patch
  isofs: Remove useless include

synaptics-remove-unused-struct-member-variable.patch
  synaptics: Remove unused struct member variable

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

kill-one-if-x-vfreex-usage.patch
  kill one "if (X) vfree(X)" usage

smbfs-make-some-functions-static.patch
  smbfs: make some functions static



