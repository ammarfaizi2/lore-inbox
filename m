Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbULYAva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbULYAva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 19:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbULYAv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 19:51:29 -0500
Received: from coderock.org ([193.77.147.115]:2521 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261361AbULYAtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 19:49:00 -0500
Date: Sat, 25 Dec 2004 01:48:46 +0100
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.10-kj
Message-ID: <20041225004846.GA19373@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Santa brought another present :-)

I'll start mailing new patches these days, and after external trees get
merged, I'll be bugging you with the old ones.


Patchset is at http://coderock.org/kj/2.6.10-kj/


new in this release:
--------------------
comment-drivers_block_floppy.c.patch
  From: james4765@verizon.net
  Subject: [KJ] [PATCH][RESEND] floppy: relocate devfs comment

module_param-drivers_net_3c59x.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] net/3c59x: module_param conversions

schedule_cleanup-drivers_usb_class_usblp.c.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] class/usblp: cleanup usblp_write()

typo-sound_isa_es18xx.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 8/8] ifdef typos: sound_isa_es18xx.c

typos-arch_ppc_platforms_prep_setup.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] Re: ifdef typos: arch_ppc_platforms_prep_setup.c -another one

typo-arch_ppc_syslib_ppc4xx_dma.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 2/8] ifdef typos: arch_ppc_syslib_ppc4xx_dma.c

typo-arch_sh_boards_renesas_hs7751rvoip_io.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 3/8] ifdef typos: 	arch_sh_boards_renesas_hs7751rvoip_io.c

typo-drivers_char_ipmi_ipmi_si_intf.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 4/8] ifdef typos: drivers_char_ipmi_ipmi_si_intf.c

typo-drivers_net_wireless_wavelan_cs.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 5/8] ifdef typos: drivers_net_wireless_wavelan_cs.c

typo-drivers_usb_net_usbnet.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 6/8] ifdef typos: drivers_usb_net_usbnet.c

typo-sound_isa_cs423x_cs4231_lib.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch 7/8] ifdef typos: sound_isa_cs423x_cs4231_lib.c

typo_au1000-arch_mips.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] mips: AU1[0X]00_USB_DEVICE typo

typo-arch_ppc64_kernel_rtasd.c.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] ppc64: semicolon in rtasd.c

remove_file-arch_alpha_lib_dbg_stackcheck.S.patch
  delete unused file

remove_file-arch_alpha_lib_dbg_stackkill.S.patch
  delete unused file

remove_file-arch_alpha_lib_stacktrace.c.patch
  delete unused file

remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
  delete unused file

remove_file-arch_m68k_apollo_dn_debug.c.patch
  delete unused file

remove_file-arch_m68k_sun3x_sun3x_ksyms.c.patch
  delete unused file

remove_file-arch_m68knommu_platform_68EZ328_ucsimm_crt0_himem.S.patch
  delete unused file

remove_file-arch_m68knommu_platform_68VZ328_ucdimm_crt0_himem.S.patch
  delete unused file

remove_file-arch_mips_arc_salone.c.patch
  delete unused file

remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
  delete unused file

remove_file-arch_ppc64_boot_no_initrd.c.patch
  delete unused file

remove_file-arch_ppc_kernel_find_name.c.patch
  delete unused file

remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
  delete unused file

remove_file-arch_ppc_syslib_ppc4xx_serial.c.patch
  delete unused file

remove_file-arch_sh64_lib_old_checksum.c.patch
  delete unused file

remove_file-arch_um_include_umn.h.patch
  delete unused file

remove_file-arch_x86_64_lib_old_checksum.c.patch
  delete unused file

remove_file-drivers_char_hp600_keyb.c.patch
  delete unused file

remove_file-drivers_char_rio_cdproto.h.patch
  delete unused file

remove_file-drivers_char_rsf16fmi.h.patch
  delete unused file

remove_file-drivers_net_gt64240eth.h.patch
  delete unused file

remove_file-drivers_parport_parport_arc.c.patch
  delete unused file

remove_file-drivers_pcmcia_au1000_generic.c.patch
  delete unused file

remove_file-drivers_pcmcia_au1000_pb1x00.c.patch
  delete unused file

remove_file-drivers_scsi_dpt_dpt_osdutil.h.patch
  delete unused file

remove_file-drivers_video_aty_xlinit.c.patch
  delete unused file

remove_file-drivers_video_riva_nv4ref.h.patch
  delete unused file

remove_file-fs_jffs2_histo.h.patch
  delete unused file

remove_file-fs_jfs_jfs_defragfs.h.patch
  delete unused file

remove_file-include_asm_alpha_numnodes.h.patch
  delete unused file

remove_file-include_asm_arm26_ian_char.h.patch
  delete unused file

remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
  delete unused file

remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
  delete unused file

remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
  delete unused file

remove_file-include_asm_m68k_atari_SCCserial.h.patch
  delete unused file

remove_file-include_asm_m68knommu_io_hw_swap.h.patch
  delete unused file

remove_file-include_asm_m68knommu_semp3.h.patch
  delete unused file

remove_file-include_asm_mips_gfx.h.patch
  delete unused file

remove_file-include_asm_mips_it8172_it8172_lpc.h.patch
  delete unused file

remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
  delete unused file

remove_file-include_asm_mips_mipsprom.h.patch
  delete unused file

remove_file-include_asm_mips_ng1.h.patch
  delete unused file

remove_file-include_asm_mips_ng1hw.h.patch
  delete unused file

remove_file-include_asm_mips_riscos_syscall.h.patch
  delete unused file

remove_file-include_asm_parisc_bootdata.h.patch
  delete unused file

remove_file-include_asm_ppc64_iSeries_iSeries_fixup.h.patch
  delete unused file

remove_file-include_asm_um_arch_signal_i386.h.patch
  delete unused file

remove_file-include_asm_um_archparam_i386.h.patch
  delete unused file

remove_file-include_asm_um_archparam_ppc.h.patch
  delete unused file

remove_file-include_asm_um_module_generic.h.patch
  delete unused file

remove_file-include_asm_um_module_i386.h.patch
  delete unused file

remove_file-include_asm_um_processor_i386.h.patch
  delete unused file

remove_file-include_asm_um_processor_ppc.h.patch
  delete unused file

remove_file-include_asm_um_ptrace_i386.h.patch
  delete unused file

remove_file-include_asm_um_sigcontext_i386.h.patch
  delete unused file

remove_file-include_asm_um_sigcontext_ppc.h.patch
  delete unused file

remove_file-include_asm_um_system_i386.h.patch
  delete unused file

remove_file-include_asm_um_system_ppc.h.patch
  delete unused file

remove_file-include_linux_byteorder_pdp_endian.h.patch
  delete unused file

remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
  delete unused file

remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
  delete unused file

remove_file-include_linux_umsdos_fs_i.h.patch
  delete unused file

remove_file-include_sound_soundmem.h.patch
  delete unused file

remove_file-net_sunrpc_auth_gss_gss_pseudoflavors.c.patch
  delete unused file

remove_file-net_sunrpc_auth_gss_sunrpcgss_syms.c.patch
  delete unused file

remove_file-sound_core_seq_oss_seq_oss_misc.c.patch
  delete unused file

remove_file-sound_oss_maestro_tables.h.patch
  delete unused file

remove_file-sound_pci_cs46xx_imgs_cwcemb80.h.patch
  delete unused file

cleanup-drivers_media_radio_radio-sf16fmi.c.patch
  From: sebek64@post.cz (Marcel Sebek)
  Subject: [KJ] [PATCH] radio-sf16fmi cleanup

cleanup-drivers_media_radio_miropcm20-radio.c.patch
  From: sebek64@post.cz (Marcel Sebek)
  Subject: [KJ] [PATCH] miropcm20-radio cleanup

cleanup-drivers_atm_he.c.patch
  From: sebek64@post.cz (Marcel Sebek)
  Subject: [KJ] [PATCH] drivers/atm/he.c remove dead code

array_size-fs_proc_base.c.bak.patch
  From: walter harms <wharms@bfs.de>
  Subject: [KJ] inux-2.6.9/fs/proc/base.c: array size

remove_sprintf-fs_proc_proc_tty.c.bak.patch
  From: walter harms <wharms@bfs.de>
  Subject: [KJ] linux-2.6.9/fs/proc/proc_tty.c: avoid array

kj_tag.patch
  -kj



merged:
-------
min-max-arch_mips_au1000_common_usbdev
msleep-drivers_net_irda_pcmcia_yenta_socket
check-register_netdevice_notifier-net_8021q_vlan
check-register_netdevice_notifier-net_atm_mpc


changed:
--------
min-max-arch_sh_boards_bigsur_io.patch
  changed to min_t
ssleep-drivers_scsi_qla2xxx_qla_os
  changed to msleep
msleep_interruptible-drivers_macintosh_mediabay.patch
  fixed typo


dropped:
--------
remove-pci-find-device-arch_mips_pci_pci-hplj
  file removed
fix-test-kernel_sched
  nacked


all patches:
------------
remove-old-ifdefs-aic7xxx_osm_pci.patch
min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_chan_kern.patch
list-for-each-entry-drivers_macintosh_via-pmu.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-entry-safe-arch_i386_mm_pageattr.patch
list-for-each-entry-safe-fs_coda_psdev.patch
list-for-each-entry-safe-fs_dquot.patch
list-for-each-fs_dcache.patch
msleep-drivers_ide_ide-tape.patch
msleep-drivers_ieee1394_sbp2.patch
pr_debug-drivers_block_umem.patch
list-for-each-drivers_net_ipv6_ip6_fib.patch
list-for-each-drivers_net_tulip_de4x5.patch
min-max-arch_sh_boards_bigsur_io.patch
min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
msleep-drivers_atm_ambassador.patch
msleep-drivers_block_xd.patch
msleep-drivers_ide_ide-cd.patch
msleep-drivers_ide_ide-cs.patch
msleep-drivers_mtd_chips_amd_flash.patch
msleep-drivers_mtd_chips_cfi_cmdset_0001.patch
msleep-drivers_mtd_chips_cfi_cmdset_0002.patch
msleep-drivers_mtd_chips_cfi_cmdset_0020.patch
msleep_interruptible-drivers_base_dmapool.patch
msleep_interruptible-drivers_block_cciss.patch
msleep_interruptible-drivers_block_pcd.patch
msleep_interruptible-drivers_block_pf.patch
msleep_interruptible-drivers_block_pg.patch
msleep_interruptible-drivers_block_pt.patch
msleep_interruptible-drivers_cdrom_sonycd535.patch
msleep_interruptible-drivers_macintosh_mediabay.patch
set_current_state-drivers_block_swim3.patch
set_current_state-drivers_block_swim_iop.patch
add_module_version-drivers_net_8139cp.patch
for-each-pci-dev-arch_i386_pci_acpi.patch
for-each-pci-dev-arch_i386_pci_i386.patch
for-each-pci-dev-drivers_char_agp_generic.patch
for-each-pci-dev-drivers_char_agp_isoch.patch
function-string-arch-mips.patch
msleep-drivers_media_radio_radio-zoltrix.patch
msleep-drivers_net_3c505.patch
msleep-drivers_net_e1000_e1000_osdep.patch
msleep-drivers_net_irda_act200l-sir.patch
msleep-drivers_net_irda_irtty-sir.patch
msleep-drivers_net_irda_ma600-sir.patch
msleep-drivers_net_irda_pcmcia_xirc2ps_cs.patch
msleep-drivers_net_irda_sir_dev.patch
msleep-drivers_net_ixgb_ixgb_osdep.patch
msleep-drivers_net_ni65.patch
msleep-drivers_net_ns83820.patch
msleep-drivers_net_s2io.patch
msleep-drivers_net_wan_cosa.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep-drivers_scsi_ibmvscsi.patch
msleep-drivers_scsi_ide-scsi.patch
msleep-drivers_scsi_imm.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_scsi_ppa.patch
msleep-drivers_scsi_qla1280.patch
msleep_interruptible-drivers_net_cs89x0.patch
msleep_interruptible-drivers_net_e1000_e1000_ethtool.patch
msleep_interruptible-drivers_net_gt96100eth.patch
msleep_interruptible-drivers_net_irda_tekram-sir.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
msleep_interruptible-drivers_net_pcnet32.patch
msleep_interruptible-drivers_net_sb1000.patch
msleep_interruptible-drivers_net_slip.patch
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_ieee1284.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_s390_net_ctctty.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-drivers_scsi_dpt_i2o.patch
msleep_interruptible-drivers_scsi_st.patch
msleep_interruptible-drivers_tc_zs.patch
msleep+msleep_interruptible-drivers_net_e100.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
msleep+msleep_interruptible-drivers_net_wireless_airo.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
pci_dev_present-arch_ia64_hp_common_sba_iommu.patch
pci_dev_present-arch_ia64_pci_pci.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
pci_get_device-drivers_char_agp_amd64-agp.patch
pci_get_device-drivers_char_agp_intel-agp.patch
pci_get_device-drivers_char_agp_intel-mch-agp.patch
remove-pci-find-device-arch_sparc64_kernel_ebus.patch
remove-pci-find-device-drivers_net_e1000_e1000_main.patch
remove-pci-find-device-drivers_net_gt96100eth.patch
remove-pci-find-device-drivers_net_ixgb_ixgb_main.patch
remove-pci-find-device-drivers_net_tg3.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
set_current_state-drivers_net_wan_farsync.patch
ssleep-drivers_net_wireless_orinoco_plx.patch
ssleep-drivers_net_wireless_orinoco_tmd.patch
ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
fix-comment-fs_jbd_journal.patch
lib-parser-fs_devpts_inode.patch
msleep_interruptible-drivers_cdrom_sonycd535_2.patch
msleep_interruptible-drivers_message_fusion_mptbase.patch
msleep_interruptible-drivers_net_ewrk3.patch
reorder-state-drivers_char_snsc.patch
reorder-state-drivers_video_pxafb.patch
reorder-state-drivers_video_sa1100fb.patch
set_current_state-drivers_input_joystick_iforce_iforce-packets.patch
ssleep-drivers_scsi_qla2xxx_qla_os.patch
docs-fs_super.patch
docs-kernel_sysctl.patch
kconfig-arch_sh_drivers_pci.patch
kconfig-arch_sparc64.patch
module_parm-net_ne2k-pci.patch
module_parm-net_wireless_atmel_cs.patch
module_parm-net_wireless_orinoco.patch
module_parm-net_wireless_wavelan.p.h.patch
module_parm-net_wireless_wl3501_cs.patch
msleep-sound_sparc_cs4231.patch
myri_code_cleanup.patch
printk-drivers-scsi-zalon.patch
strlcpy-net_wireless_wavelan.patch
comment-drivers_block_floppy.c.patch
module_param-drivers_net_3c59x.c.patch
schedule_cleanup-drivers_usb_class_usblp.c.patch
typo-sound_isa_es18xx.c.patch
typos-arch_ppc_platforms_prep_setup.c.patch
typo-arch_ppc_syslib_ppc4xx_dma.c.patch
typo-arch_sh_boards_renesas_hs7751rvoip_io.c.patch
typo-drivers_char_ipmi_ipmi_si_intf.c.patch
typo-drivers_net_wireless_wavelan_cs.c.patch
typo-drivers_usb_net_usbnet.c.patch
typo-sound_isa_cs423x_cs4231_lib.c.patch
typo_au1000-arch_mips.patch
typo-arch_ppc64_kernel_rtasd.c.patch
remove_file-arch_alpha_lib_dbg_stackcheck.S.patch
remove_file-arch_alpha_lib_dbg_stackkill.S.patch
remove_file-arch_alpha_lib_stacktrace.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_m68k_apollo_dn_debug.c.patch
remove_file-arch_m68k_sun3x_sun3x_ksyms.c.patch
remove_file-arch_m68knommu_platform_68EZ328_ucsimm_crt0_himem.S.patch
remove_file-arch_m68knommu_platform_68VZ328_ucdimm_crt0_himem.S.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc64_boot_no_initrd.c.patch
remove_file-arch_ppc_kernel_find_name.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-arch_ppc_syslib_ppc4xx_serial.c.patch
remove_file-arch_sh64_lib_old_checksum.c.patch
remove_file-arch_um_include_umn.h.patch
remove_file-arch_x86_64_lib_old_checksum.c.patch
remove_file-drivers_char_hp600_keyb.c.patch
remove_file-drivers_char_rio_cdproto.h.patch
remove_file-drivers_char_rsf16fmi.h.patch
remove_file-drivers_net_gt64240eth.h.patch
remove_file-drivers_parport_parport_arc.c.patch
remove_file-drivers_pcmcia_au1000_generic.c.patch
remove_file-drivers_pcmcia_au1000_pb1x00.c.patch
remove_file-drivers_scsi_dpt_dpt_osdutil.h.patch
remove_file-drivers_video_aty_xlinit.c.patch
remove_file-drivers_video_riva_nv4ref.h.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-fs_jfs_jfs_defragfs.h.patch
remove_file-include_asm_alpha_numnodes.h.patch
remove_file-include_asm_arm26_ian_char.h.patch
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
remove_file-include_asm_m68k_atari_SCCserial.h.patch
remove_file-include_asm_m68knommu_io_hw_swap.h.patch
remove_file-include_asm_m68knommu_semp3.h.patch
remove_file-include_asm_mips_gfx.h.patch
remove_file-include_asm_mips_it8172_it8172_lpc.h.patch
remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
remove_file-include_asm_mips_mipsprom.h.patch
remove_file-include_asm_mips_ng1.h.patch
remove_file-include_asm_mips_ng1hw.h.patch
remove_file-include_asm_mips_riscos_syscall.h.patch
remove_file-include_asm_parisc_bootdata.h.patch
remove_file-include_asm_ppc64_iSeries_iSeries_fixup.h.patch
remove_file-include_asm_um_arch_signal_i386.h.patch
remove_file-include_asm_um_archparam_i386.h.patch
remove_file-include_asm_um_archparam_ppc.h.patch
remove_file-include_asm_um_module_generic.h.patch
remove_file-include_asm_um_module_i386.h.patch
remove_file-include_asm_um_processor_i386.h.patch
remove_file-include_asm_um_processor_ppc.h.patch
remove_file-include_asm_um_ptrace_i386.h.patch
remove_file-include_asm_um_sigcontext_i386.h.patch
remove_file-include_asm_um_sigcontext_ppc.h.patch
remove_file-include_asm_um_system_i386.h.patch
remove_file-include_asm_um_system_ppc.h.patch
remove_file-include_linux_byteorder_pdp_endian.h.patch
remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
remove_file-include_linux_umsdos_fs_i.h.patch
remove_file-include_sound_soundmem.h.patch
remove_file-net_sunrpc_auth_gss_gss_pseudoflavors.c.patch
remove_file-net_sunrpc_auth_gss_sunrpcgss_syms.c.patch
remove_file-sound_core_seq_oss_seq_oss_misc.c.patch
remove_file-sound_oss_maestro_tables.h.patch
remove_file-sound_pci_cs46xx_imgs_cwcemb80.h.patch
cleanup-drivers_media_radio_radio-sf16fmi.c.patch
cleanup-drivers_media_radio_miropcm20-radio.c.patch
cleanup-drivers_atm_he.c.patch
array_size-fs_proc_base.c.bak.patch
remove_sprintf-fs_proc_proc_tty.c.bak.patch
kj_tag.patch
