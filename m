Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTKUXq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKUXq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:46:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:10958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbTKUXqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:46:20 -0500
Subject: Re: 2.6.0-test9-mm5 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031121121116.61db0160.akpm@osdl.org>
References: <20031121121116.61db0160.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1069458420.7171.62.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 21 Nov 2003 15:47:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.0-test9-mm5   0w/0e     0w/0e   172w/ 0e  12w/0e   3w/0e    211w/0e
2.6.0-test9-mm4   2w/0e     0w/0e   174w/ 0e  12w/0e   3w/0e    213w/0e
2.6.0-test9-mm3   0w/0e     0w/0e   172w/ 0e  12w/0e   3w/0e    211w/0e
2.6.0-test9-mm2   0w/0e     0w/0e   172w/ 0e  12w/0e   3w/0e    211w/1e
2.6.0-test9-mm1   0w/0e     0w/0e   179w/ 1e  12w/0e   3w/0e    213w/1e
2.6.0-test8-mm1   0w/0e     0w/0e   183w/ 1e  13w/0e   3w/0e    223w/1e
2.6.0-test7-mm1   0w/0e     1w/0e   176w/ 1e   9w/0e   3w/0e    231w/1e
2.6.0-test6-mm4   0w/0e     1w/0e   179w/ 1e   9w/0e   3w/0e    234w/1e
2.6.0-test6-mm3   0w/0e     1w/0e   178w/ 1e   9w/0e   3w/0e    252w/2e
2.6.0-test6-mm2   0w/0e     1w/0e   179w/ 1e   9w/0e   3w/0e    252w/2e
2.6.0-test6-mm1   0w/0e     1w/0e   179w/ 1e   9w/0e   3w/0e    252w/2e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Version information for host [ cherrypit.pdx.osdl.net ]
 gcc:    3.2.2
 patch:  2.5.4

Kernel version: 2.6.0-test9-mm5
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allnoconfig): 0 warnings, 0 errors
   Making bzImage (allyesconfig): 172 warnings, 5 errors
   Making modules (allyesconfig): 12 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 211 warnings, 0 errors

Building directories:
   Building fs/adfs: clean
   Building fs/affs: clean
   Building fs/afs: clean
   Building fs/autofs: clean
   Building fs/autofs4: clean
   Building fs/befs: clean
   Building fs/bfs: clean
   Building fs/cifs: clean
   Building fs/coda: clean
   Building fs/cramfs: clean
   Building fs/devfs: clean
   Building fs/devpts: clean
   Building fs/efs: clean
   Building fs/exportfs: clean
   Building fs/ext2: clean
   Building fs/ext3: clean
   Building fs/fat: clean
   Building fs/freevxfs: clean
   Building fs/hfs: clean
   Building fs/hpfs: clean
   Building fs/hugetlbfs: clean
   Building fs/intermezzo: clean
   Building fs/isofs: clean
   Building fs/jbd: clean
   Building fs/jffs: clean
   Building fs/jffs2: clean
   Building fs/jfs: clean
   Building fs/lockd: clean
   Building fs/minix: clean
   Building fs/msdos: clean
   Building fs/ncpfs: clean
   Building fs/nfs: clean
   Building fs/nfsd: clean
   Building fs/nls: clean
   Building fs/ntfs: clean
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/ramfs: clean
   Building fs/reiserfs: clean
   Building fs/romfs: clean
   Building fs/smbfs: clean
   Building fs/sysfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/vfat: clean
   Building fs/xfs: clean
   Building drivers/i2c: clean
   Building drivers/net: 31 warnings, 0 errors
   Building drivers/media: 1 warnings, 0 errors
   Building drivers/base: clean
   Building drivers/pci: clean
   Building drivers/eisa: clean
   Building drivers/isdn: clean
   Building drivers/char: 1 warnings, 0 errors
   Building drivers/acpi: clean
   Building drivers/serial: 1 warnings, 0 errors
   Building drivers/fc4: clean
   Building drivers/parport: clean
   Building drivers/mtd: 23 warnings, 0 errors
   Building drivers/usb: clean
   Building drivers/block: 1 warnings, 0 errors
   Building drivers/pcmcia: 3 warnings, 0 errors
   Building drivers/input: clean
   Building drivers/atm: clean
   Building drivers/ide: 30 warnings, 0 errors
   Building drivers/pnp: clean
   Building drivers/oprofile: clean
   Building drivers/ieee1394: clean
   Building drivers/cdrom: 3 warnings, 0 errors
   Building drivers/md: clean
   Building drivers/message: 1 warnings, 0 errors
   Building drivers/cpufreq: clean
   Building drivers/sbus: clean
   Building drivers/bluetooth: clean
   Building drivers/telephony: 5 warnings, 0 errors
   Building drivers/zorro: clean
   Building drivers/acorn: clean
   Building drivers/tc: clean
   Building drivers/mca: clean
   Building drivers/nubus: clean
   Building drivers/misc: clean
   Building drivers/dio: clean
   Building drivers/scsi/aacraid: clean
   Building drivers/scsi/aic7xxx: clean
   Building drivers/scsi/pcmcia: 4 warnings, 0 errors
   Building drivers/scsi/sym53c8xx_2: clean
   Building drivers/video/aty: 3 warnings, 0 errors
   Building drivers/video/console: 2 warnings, 0 errors
   Building drivers/video/i810: clean
   Building drivers/video/logo: clean
   Building drivers/video/matrox: 5 warnings, 0 errors
   Building drivers/video/riva: clean
   Building drivers/video/sis: 1 warnings, 0 errors
   Building sound/core: clean
   Building sound/drivers: clean
   Building sound/i2c: clean
   Building sound/isa: 3 warnings, 0 errors
   Building sound/oss: 33 warnings, 0 errors
   Building sound/pci: clean
   Building sound/pcmcia: clean
   Building sound/synth: clean
   Building sound/usb: clean
   Building arch/i386: clean
   Building crypto: clean
   Building lib: clean
   Building net: 9 warnings, 0 errors
   Building security: clean
   Building sound: clean
   Building usr: clean
   Building fs: clean
   Building drivers/video: 8 warnings, 0 errors
   Building drivers/scsi: 44 warnings, 0 errors
   Building drivers/net: 0 warnings, 1 errors


Error Summary (individual module builds):

   drivers/net: 0 warnings, 1 errors


Warning Summary (individual module builds):

   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 1 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/media: 1 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 23 warnings, 0 errors
   drivers/net: 31 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi: 44 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   net: 9 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 33 warnings, 0 errors




