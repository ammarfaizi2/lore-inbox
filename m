Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTKPRTW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 12:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTKPRTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 12:19:22 -0500
Received: from smtp14.eresmas.com ([62.81.235.114]:51399 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S262575AbTKPRTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 12:19:14 -0500
Message-ID: <3FB7B181.5090001@wanadoo.es>
Date: Sun, 16 Nov 2003 18:18:57 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
CC: Tosatti <marcelo.tosatti@cyclades.com>
Subject: [summary] state of scsi drivers
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        * unofficial LiNUX kernel SCSI/RAID drivers list *

                        <xose@wanadoo.es>

                         linux-2.4.23-rc1
                   Sun Nov 16 17:38:00 CET 2003


x features:
   hot-plug vary_io highmem_io block_device_driver 64_bit_SG

o aacraid
   manufacturer: ADAPTEC
   kernel: 1.1.2 (15 May 2003)
   latest: 1.1.4 (31 Oct 2003)
   arch: i386 ia64 x86_64(amd64) alpha (sparc not confirmed, but expected)
   features: highmem_io 64_bit_SG
   maintainer: <Mark_Salyzyn*AT*adaptec.com> <markh*AT*osdl.org>
               <aacraid*AT*adaptec.com> <linux-aacraid-devel*AT*dell.com>
   url: http://linux.adaptec.com
        http://www.domsch.com/linux/#aacraid

o aic7xxx/aic79xx
   manufacturer: ADAPTEC
   kernel: 6.2.36/1.3.10 (03 Jun 2003)
   latest: 6.3.3 /2.0.4  (06 Nov 2003)
   arch: i386 ia64 powerpc
   features:
   maintainer: <gibbs*AT*scsiguy.com>
   url: http://people.freebsd.org/~gibbs/linux/SRC/

o cciss
   manufacturer: HP
   kernel: 2.4.50
   latest: 2.4.50
   arch: i386
   features: block_device_driver
   maintainer: <mike.miller*AT*hp.com> <arrays*AT*hp.com>
               <Cciss-discuss*AT*lists.sourceforge.net>
   url: http://sf.net/projects/cciss/

o DAC960
   manufacturer: LSI Logic
   kernel: 2.4.11 (11 Oct 2001)
   latest: 2.4.20 (01 May 2003)
   arch: i386 ia64 alpha
   features: block_device_driver
   maintainer: <dmo*AT*osdl.org>
   url: http://www.osdl.org/archive/dmo/DAC960/
        http://www.dandelion.com/Linux/DAC960.html

o dpt_i2o
   manufacturer: ADAPTEC
   kernel: 2.4.5 (25 Jul 2001)
   latest: 2.5.0 (11 Sep 2003)
   arch: i386 ia64 alpha sparc x86_64(amd64)
   features: highmem_io 64_bit_SG
   maintainer: <Mark_Salyzyn*AT*adaptec.com>
   url: http://linux.adaptec.com

o emulex
   manufacturer: EMULEX
   kernel: -
   latest: 1.23a
   arch: i386 ia64 ppc
   features:
   maintainer: <tech.support*AT*emulex.com>
   url: http://www.emulex.com/ts/docfc/linuxos.shtml

o feral_isp
   manufacturer: QLOGIC
   kernel: -
   latest: Linux Platform 2.1   Common Core Code 2.7 (13 Nov 2003)
   arch: i386 alpha sparc powerpc
   features: alternative driver for all qlogic products
   maintainer: <mjacob*AT*feral.com>
   url: http://www.feral.com/isp.html

o fusion
   manufacturer: LSI Logic
   kernel: 2.05.05+ (14 Apr 2003)
   latest: 2.05.10  (10 Oct 2003)
   arch: i386 alpha sparc ia64 x86_64
   features:
   maintainer: <emoore*AT*lsil.com> <mpt_linux_developer*AT*lsil.com>
   url: ftp://ftp.lsil.com/HostAdapterDrivers/linux/

o gdth
   manufacturer: ADAPTEC
   kernel: 2.05  (03 Oct 2002)
   latest: 2.06a (04 Aug 2003)
   arch: i386 alpha ia64
   features:
   maintainer: <achim.leubner*AT*intel.com> <johannes_dinner*AT*adaptec.com>
   url: http://www.icp-vortex.com/english/download/rz_neu/8x24/linux/linux_e.htm

o ips
   manufacturer: ADAPTEC
   kernel: 6.00.26
   latest: 6.00.26
   arch: i386 ia64
   features:
   maintainer: <david_jeffery*AT*adaptec.com> <ipslinux*AT*adaptec.com>
   url: -

o megaraid
   manufacturer: LSI Logic
   kernel: v1.18k/v2.00.9
   latest: v1.18k/v2.00.9
   arch: i386
   features:
   maintainer: <atulm*AT*lsil.com> <linux-megaraid-devel*AT*dell.com>
   url: ftp://ftp.lsil.com/pub/linux-megaraid/
        http://domsch.com/linux/#megaraid

o qla1280
   manufacturer: QLOGIC
   kernel: 3.23.37
   latest: 3.23.37
   arch: i386 alpha powerpc sparc
   features:
   maintainer: <jes*AT*wildopensource.com>
   url: -

o qla2x00
   manufacturer: QLOGIC
   kernel: -
   latest: 6.06.10
   beta:   8.00.00b6
   arch: i386
   features:
   maintainer: <andrew.vasquez*AT*qlogic.com>
   url: http://www.qlogic.com/support/product_resources.asp?id=339
        http://sf.net/projects/linux-qla2xxx/

o sym53c8xx_2
   manufacturer: LSI Logic
   kernel: 2.1.17a     (Dec 01 2001)
   latest: 2.1.19-pre3 (Nov 23 2002)
   arch: i386 alpha sparc powerpc ia64
   features:
   maintainer: <groudier*AT*free.fr>
   url: http://www.tux.org/pub/tux/roudier/drivers/linux/stable/

# EOT

