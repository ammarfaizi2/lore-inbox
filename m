Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVDLLPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVDLLPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVDLLOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:14:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:20426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262248AbVDLKdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:04 -0400
Message-Id: <200504121032.j3CAWuMR005721@shell0.pdx.osdl.net>
Subject: [patch 144/198] Add dontdiff file
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Randy.Dunlap" <rddunlap@osdl.org>

Add a current 'dontdiff' file for use with 'diff -X dontdiff'.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/dontdiff |  137 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+)

diff -puN /dev/null Documentation/dontdiff
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/Documentation/dontdiff	2005-04-12 03:21:38.022356624 -0700
@@ -0,0 +1,137 @@
+.*
+*~
+53c8xx_d.h*
+*.a
+aic7*reg.h*
+aic7*seq.h*
+aic7*reg_print.c*
+53c700_d.h
+aicasm
+aicdb.h*
+asm
+asm_offsets.*
+autoconf.h*
+*.aux
+bbootsect
+*.bin
+bin2c
+binkernel.spec
+BitKeeper
+bootsect
+bsetup
+btfixupprep
+build
+bvmlinux
+bzImage*
+ChangeSet
+classlist.h*
+compile.h*
+comp*.log
+config
+config-*
+config_data.h*
+conmakehash
+consolemap_deftbl.c*
+COPYING
+CREDITS
+.cscope
+*cscope*
+cscope.*
+*.out
+*.css
+CVS
+defkeymap.c*
+devlist.h*
+docproc
+dummy_sym.c*
+*.dvi
+*.eps
+filelist
+fixdep
+fore200e_mkfirm
+fore200e_pca_fw.c*
+gen-devlist
+gen_init_cpio
+gen_crc32table
+crc32table.h*
+*.cpio
+gen-kdb_cmds.c*
+gentbl
+genksyms
+*.gif
+*.gz
+*.html
+ikconfig.h*
+initramfs_list
+*.jpeg
+kconfig
+kconfig.tk
+Kerntypes
+keywords.c*
+ksym.c*
+ksym.h*
+kallsyms
+mk_elfconfig
+elfconfig.h*
+modpost
+pnmtologo
+logo_*.c
+*.log
+lex.c*
+logo_*_clut224.c
+logo_*_mono.c
+lxdialog
+make_times_h
+map
+mkdep
+*_MODULES
+MODS.txt
+modversions.h*
+Module.symvers
+*.mod.c
+*.o
+*.ko
+*.orig
+*.lst
+*.grp
+*.grep
+oui.c*
+mktables
+raid6tables.c
+raid6int*.c
+raid6altivec*.c
+wanxlfw.inc
+maui_boot.h
+pss_boot.h
+trix_boot.h
+*.pdf
+parse.c*
+parse.h*
+PENDING
+ppc_defs.h*
+promcon_tbl.c*
+*.png
+*.ps
+*.rej
+SCCS
+setup
+*.s
+*.so
+*.sgml
+sim710_d.h*
+sm_tbl*
+split-include
+System.map*
+tags
+TAGS
+*.tex
+times.h*
+tkparse
+*.ver
+version.h*
+*_vga16.c
+vmlinux
+vmlinux.lds
+vmlinux-*
+vsyscall.lds
+zImage
_
