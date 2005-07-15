Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263245AbVGOIiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbVGOIiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbVGOIiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:38:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263240AbVGOIhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:37:48 -0400
Date: Fri, 15 Jul 2005 01:36:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3-mm1
Message-Id: <20050715013653.36006990.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/

(http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
kernel.org syncs up)


- Added the CKRM patches.  This is just here for people to look at at this
  stage.



Changes since 2.6.13-rc2-mm2:


 git-drm.patch
 git-audit.patch
 git-input.patch
 git-kbuild.patch
 git-libata-adma-mwi.patch
 git-libata-chs-support.patch
 git-libata-passthru.patch
 git-libata-promise-sata-pata.patch
 git-netdev-chelsio.patch
 git-netdev-e100.patch
 git-netdev-smc91x-eeprom.patch
 git-netdev-ieee80211-wifi.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-scsi-block.patch
 git-scsi-misc.patch
 git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
 
 Subsystem trees

-name_to_dev_t-warning-fix.patch
-aacraid-swapped-kmalloc-args.patch
-quiet-ide-cd-warning.patch
-device-mapper-multipath-barriers-not-supported.patch
-device-mapper-multipath-flush-workqueue-when-destroying.patch
-device-mapper-multipath-avoid-possible-suspension-deadlock.patch
-device-mapper-multipath-fix-pg-initialisation-races.patch
-device-mapper-fix-dm_swap_table-error-cases.patch
-device-mapper-snapshots-handle-origin-extension.patch
-lower-vm_dontcopy-total_vm.patch
-__wait_on_freeing_inode-fix.patch
-vfs-bugfix-two-read_inode-calles-without.patch
-sparc64-read_mostly-build-fix.patch
-x86_64-section-linkage-fix.patch
-pcmcia-fix-pcmcia-cs-compilation.patch
-yenta-fix-parent-resource-determination.patch
-pcmcia-documentation-update.patch
-yenta-same-resources-in-same-structs.patch
-yenta-allocate-resource-fixes.patch
-acpi-20050408-2.6.13-rc1.patch
-fix-recursive-ipw2200-dependencies.patch
-drivers-net-wireless-ipw2100-use-the-dma_32bit_mask-constant.patch
-drivers-net-wireless-ipw2200-use-the-dma_32bit_mask-constant.patch
-ipw2100-assume-recent-kernel.patch
-ipw2100-kill-dead-macros.patch
-ipw2100-small-cleanups.patch
-ipw2100-remove-commented-out-code.patch
-wireless-device-attr-fixes.patch
-wireless-device-attr-fixes-2.patch
-ipw2100-old-gcc-fix.patch
-ipvs-add-and-reorder-bh-locks-after-moving-to-keventd.patch
-drivers-net-wireless-ipw2200c-remove-division-by-zero.patch
-ppc64-kill-bitfields-in-ppc64-hash-code.patch
-alpha-pgprot_uncached-comment.patch
-uml-remove-user_constantsh-on-clean.patch
-uml-tlb-flushing-fix.patch
-xtensa-remove-old-syscalls-2-2.patch
-xtensa-use-ssleep-instead-of-schedule_timeout.patch
-xip-empty_zero_page-build-fix.patch
-reset-real_timer-target-on-exec-leader-change.patch
-reset-real_timer-target-on-exec-leader-change-coding-style-fixes.patch
-fix-ext3-options-parsing.patch
-fix-ext2-mount-options-parting.patch
-cdev-cdev_put-oops.patch
-tlb-warning-fix.patch
-nfs-procfs-sysctl-interfaces-for-lockd-do-not-work-on-x86_64.patch
-ibm_asm-kconfig-corrections.patch
-tb0219-add-pci-irq-initialization.patch
-documentation-kernel-parameterstxt-fix-a-typo.patch
-kexec-ppc-fix-for-ksysfs-crash_notes.patch
-irda-users-listssourceforgenet-is-subscribers-only.patch
-hardirq-uses-preempt.patch
-fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch
-inotify-45.patch
-dvb-lgdt3302-qam256-initialization-fix.patch
-dvb-lgdt3302-qam256-initialization-fix-fix.patch
-v4l-bttv-input.patch
-v4l-bttv-update.patch
-v4l-cx88-update.patch
-v4l-documentation.patch
-v4l-saa7134-hybrid-dvb.patch
-v4l-i2c-bt832.patch
-v4l-i2c-infrared-remote-control.patch
-v4l-i2c-miscelaneous.patch
-v4l-i2c-tuner.patch
-v4l-drivers-media-video-kconfig.patch
-v4l-mxb-fix-to-correct-tuner-ioctl.patch
-v4l-saa7134-update.patch
-v4l-tuner-3026-replace-obsolete-ioctl.patch
-v4l-tv-eeprom.patch
-kernel-auditc-fix-sparse-warnings-__nocast-type.patch
-scripts-kernel-doc-dont-use-uninitialized-srctree.patch
-net-kconfig-two-atm-related-spelling-fixes.patch

 Merged

+vtc-build-fix.patch

 Compile fix

+fix-raid0s-attempt-to-divide-by-64bit-numbers.patch

 RAID0 fix

+v4l-bug-fixes-for-tuner-cx88-and-tea5767.patch

 v4l fix

+xip-empty_zero_page-build-fix.patch
+mm-fix-execute-in-place.patch

 Fix the new execute-in-place code for various architectures.

+visws-reexport-pm_power_off.patch

 visws build fix

+inotify-documentation-update.patch

 inotify docs.

+deprecate-register_serial-and-unregister_serial.patch

 Emit nasty build warnings

+rocketc-fix-ldisc-ref-count-handling.patch

 Fix the rocket driver

+md-raid1-clear-bitmap-when-fullsync-completes.patch

 RAID1 fix

+uart_handle_sysrq_char-warning-fix.patch

 Fix a warning

-update-filesystems-for-new-delete_inode-behavior.patch

 Drop this - it's in git-ocfs2.patch anyway

+update-filesystems-for-new-delete_inode-behavior-fix.patch

 This needs to be, too.

+acpi-fix-table-discovery-from-efi-for-x86.patch

 ACPI fix

-gregkh-i2c-i2c-via686a-cleanups.patch
-gregkh-i2c-i2c-tps6501x-cleanups.patch
-gregkh-i2c-i2c-string-strip.patch
-gregkh-i2c-i2c-max6875-may-do-bad-things.patch
-gregkh-i2c-i2c-max6875-documentation.patch
-gregkh-i2c-i2c-max6875-Kconfig.patch
-gregkh-i2c-i2c-m41t00-kfree-fix.patch
-gregkh-i2c-i2c-idr-core.patch
-gregkh-i2c-i2c-drop-bogus-eeprom-comment.patch
-gregkh-i2c-i2c-docs-01.patch
-gregkh-i2c-i2c-docs-02.patch
-gregkh-i2c-i2c-dev-doc-update.patch
-gregkh-i2c-i2c-atxp1-build-fix.patch
-gregkh-i2c-w1-bigendian-crc-fix.patch

 The i2c tree is all merged up

+input-synaptics-dynabook.diff.patch

 Changes in the input subsystem tree

+apple-usb-touchpad-driver.patch

 USB driver

+git-netdev-ieee80211-wifi.patch

 Fix up Jeff's stuff

+remove-pci_bridge_ctl_vga-handling-from-setup-busc.patch

 PCI fix

+qla-remove-anonymous-union.patch
+qla2xxx-Kconfig-dependency-fix.patch
+fc4-warning-fix.patch

 Fix stuff in git-scsi-misc.patch

-gregkh-usb-usb-bMaxPacketSize0-sysfs.patch
-gregkh-usb-usb-storage-unusual-ids-01.patch
-gregkh-usb-usb-khubd-use-kthread.patch
-gregkh-usb-usb-ftdi_sio-device_id-clutter-reduction.patch
-gregkh-usb-usb-ftdi_sio-remove-TIOCMBIS.patch
-gregkh-usb-usb-ftdi_sio-fix-compiler-warnings.patch
-gregkh-usb-usb-atm-01.patch
-gregkh-usb-usb-atm-02.patch
-gregkh-usb-usb-atm-03.patch
-gregkh-usb-usb-sis-makefile-fix.patch
-gregkh-usb-usb-usbmon-print-control-packets.patch
-gregkh-usb-usb-isp116x-hcd-cleanup.patch
-gregkh-usb-usb-kmalloc-flag-cleanup.patch
-gregkh-usb-usb-net2280-warning-fix.patch
-gregkh-usb-usb-keyspan-remote.patch
-gregkh-usb-usb-coverity-desc-bitmap-overrun-fix.patch
-gregkh-usb-usb-ld-hid-blacklist.patch
-gregkh-usb-usb-sn9c10x-update.patch
-gregkh-usb-usb-gadget-ether-fix-01.patch
-gregkh-usb-usb-gadget-ether-fix-02.patch
-gregkh-usb-usb-ohci-udc-tweaks.patch
-gregkh-usb-usb-ohci-omap-pm-updates.patch
-gregkh-usb-usb-ohci-merge-fix.patch
-gregkh-usb-usb-cdc-descriptor-add.patch
-gregkh-usb-usb-export-getput_intf.patch
-gregkh-usb-usb-cdc-acm-reference-count-fix.patch
-gregkh-usb-usb-ldusb.patch

 The USB subsystem tree is mostly merged up

+option-card-driver-update-maintainer-entry-fixes.patch

 USB driver coding style tweaks

+i6300esb-pci_match_device-fix.patch

 Fix bug in bk-watchdog.patch

+proc-pid-numa_maps-to-show-on-which-nodes-pages-reside.patch
+proc-pid-numa_maps-to-show-on-which-nodes-pages-reside-tidy.patch

 Add /proc/pid/numa_maps

+smaps-print-more-fields.patch

 Print more stuff in /proc/pid/smaps

+s2io-fix-a-compiler-warning-in-a-printk.patch

 s2io fix

+tmpfs-enable-atomic-inode-security.patch
+remove-security_inode_post_create-mkdir-symlink-mknod.patch
+remove-the-inode_post_link-and-inode_post_rename-lsm-hooks.patch

 Fixes and updates to the LSM work in -mm.

+ppc-ppc64-use-kconfighz.patch
+ppc32-update-defconfigs.patch
+ppc32-add-proper-prototype-for-cpm2_reset.patch
+ppc32-make-the-uarts-on-mpc824x-individual-platform-devices.patch
+ppc64-update-defconfigs.patch
+ppc64-hide-config_adb.patch
+ppc64-genrtc-build-fix.patch

 ppc32/ppc64 updates

+hpet-use-read_timer_tsc-only-when-cpu-has-tsc.patch

 hpet driver fix

+suspend-update-documentation.patch
+swsusp-fix-printks-and-cleanups.patch
+swsusp-fix-remaining-u32-vs-pm_message_t-confusion.patch
+swsusp-switch-pm_message_t-to-struct.patch
+swsusp-switch-pm_message_t-to-struct-pmac_zilog-fix.patch
+swsusp-switch-pm_message_t-to-struct-ppc32-fixes.patch
+fix-pm_message_t-stuff-in-mm-tree-netdev.patch

 Third attempt at finishing off the pm_mesage_t conversion and switching it
 to be a struct.  Seems to be OK now.

+aio-add-enosys-into-sys_io_cancel.patch

 AIO return value fix

+tpm-support-for-infineon-tpm.patch
+ppc64-tpm_infineon-build-fix.patch

 TPm driver updates

+mb_cache_shrink-frees-unexpected-caches.patch

 mbcache fix

+inotify-speedup.patch

 inotify speed tweak

+kprobes-prevent-possible-race-conditions-generic.patch
+kprobes-prevent-possible-race-conditions-generic-fixes.patch
+kprobes-prevent-possible-race-conditions-i386-changes.patch
+kprobes-prevent-possible-race-conditions-x86_64-changes.patch
+kprobes-prevent-possible-race-conditions-ppc64-changes.patch
+kprobes-prevent-possible-race-conditions-ia64-changes.patch
+kprobes-prevent-possible-race-conditions-ia64-changes-fixes.patch
+kprobes-prevent-possible-race-conditions-sparc64-changes.patch
+kprobes-ia64-fix-race-when-break-hits-and-kprobe-not-found.patch

 kprobes work

-pivot_root-circular-reference-fix.patch
+pivot_root-circular-reference-fix-2.patch

 Fix this problem in a new way

+ckrm-core-ckrm-event-callbacks.patch
+ckrm-processor-delay-accounting.patch
+ckrm-processor-delay-accounting-warning-fixes.patch
+ckrm-core-infrastructure.patch
+ckrm-resource-control-file-system-rcfs.patch
+ckrm-classtype-definitions-for-task-class.patch
+ckrm-classtype-definitions-for-socket-class.patch
+ckrm-numtasks-controller.patch
+ckrm-documentation.patch
+ckrm-add-missing-read_unlock.patch
+ckrm-move-callbacks-from-listenaq-to-socketclass.patch
+ckrm-change-ipaddr_port-syntax.patch
+ckrm-check-to-see-if-my-guarantee-is-set-to-dontcare.patch
+ckrm-minor-cosmetic-cleanups-in-numtasks-controller.patch
+ckrm-undo-removal-of-check-in-numtasks_put_ref_local.patch
+ckrm-rule-based-classification-engine-stub-rcfs-support.patch
+ckrm-rule-based-classification-engine-basic-rcfs-support.patch
+ckrm-rule-based-classification-engine-bitvector-support-for-classification-info.patch
+ckrm-rule-based-classification-engine-full-ce.patch
+ckrm-rule-based-classification-engine-more-advanced-classification-engine.patch
+ckrm-clean-up-typo-in-printk-message.patch
+ckrm-fix-for-compiler-warnings.patch
+ckrm-fix-share-calculation.patch
+ckrm-fix-edge-cases-with-empty-lists-and-rule-deletion.patch
+ckrm-add-numtasks-controller-config-file-write-support.patch
+ckrm-add-fork-rate-control-to-the-numtasks-controller.patch
+ckrm-classification-engines-rbce-and-crbce-are-mutually-exclusive.patch
+ckrm-make-get_class-global.patch
+ckrm-cleanups-to-ckrm-initialization.patch
+ckrm-replace-target-file-interface-with-a-writable-members-file.patch
+ckrm-use-sizeof-instead-of-define-for-the-array-size-in-taskclass.patch
+ckrm-fix-a-bug-in-the-use-of-classtype.patch
+ckrm-include-taskdelaysh-in-crbceh.patch
+ckrm-send-timestamps-to-userspace-in-msecs-instead-of-jiffies.patch
+ckrm-fix-compile-warnings-and-delete-dead-code.patch
+ckrm-fix-a-null-dereference-bug.patch
+ckrm-classification-engine-configuration-support-cleanup.patch
+ckrm-use-sizeof-instead-of-define-for-the-array-size-in-rbce.patch
+ckrm-delete-target-file-from-tc_magicc.patch

 Class-based kernel resource management

-nfs-fix-client-hang-due-to-race-condition.patch
+nfs-split-nfsi-flags-into-two-fields.patch
+nfs-use-atomic-bitops-to-manipulate-flags-in-nfsi-flags.patch
+nfs-introduce-the-use-of-inode-i_lock-to-protect-fields-in-nfsi.patch

 Fix this NFS race more cleanly

+spinlock-consolidation-s390-fix.patch

+numa-aware-slab-allocator-v5-fix.patch

 Fix numa-aware-slab-allocator-v5.patch

+fix-pm_message_t-stuff-in-mm-tree-perfctr.patch

 Update perfctr for the new pm_message_t regime

+fix-page-becoming-writable-in-do_wp_page.patch
+fix-page-becoming-writable-vm_page_prot.patch
+fix-page-becoming-writable-in-do_file_page.patch

 Fix add-page-becoming-writable-notification.patch (part of cachefs)

+v9fs-documentation-makefiles-configuration-resend-take-2.patch
+v9fs-vfs-file-dentry-and-directory-operations-resend-take-2.patch
+v9fs-vfs-inode-operations-resend-take-2.patch
+v9fs-vfs-superblock-operations-and-glue-resend-take-2.patch
+v9fs-9p-protocol-implementation-resend-take-2.patch
+v9fs-transport-modules-resend-take-2.patch
+v9fs-debug-and-support-routines-resend-take-2.patch
+v9fs-clean-up-vfs_inode-and-setattr-functions-2.patch

 v8fs updates

+fbmon-horizontal-frequency-rounding-fix.patch
+fbmem-use-unregister_chrdev-on-unload.patch
+radeonfb-clean-up-edid-sysfs-attribute.patch
+fbdev-colormap-fixes.patch

 fbdev updates

+device-mapper-fix-deadlocks-in-core-prep-fix.patch

 Fix device-mapper-fix-deadlocks-in-core-prep.patch

+drivers-scsi-aic7xxx-possible-cleanups.patch
+mm-swap_state-fix-nocast-type-warnings.patch
+spelling-fixes-for-documentation.patch
+lib-radix-tree-fix-nocast-type-warnings.patch
+dmapool-fix-nocast-type-warnings.patch
+telephony-ixj-use-msleep-instead-of-schedule_timeout.patch
+i386-smpboot-use-msleep-instead-of-schedule_timeout.patch

 Little fxes and cleanups

+remove-linux-versionh-includes.patch
+remove-linux-versionh-from-drivers-net.patch
+remove-linux-versionh-from-drivers-scsi.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-2.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-3.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-4.patch
+move-kernel_version-from-linux-versionh-to-linux-utsnameh-fix-5.patch
+remove-linux-versionh-include-for-mm.patch
+remove-linux-versionh-from-net-ieee80211.patch
+remove-linux-versionh-from-drivers-scsi-for-mm.patch
+remove-linux-versionh-from-drivers-net-for-mm.patch

 Futz with header files, waste much time.



number of patches in -mm: 591
number of changesets in external trees: 9
number of patches in -mm only: 590
total patches: 599


All 591 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/patch-list


