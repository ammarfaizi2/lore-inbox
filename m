Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTJMQSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJMQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:18:04 -0400
Received: from smtp12.eresmas.com ([62.81.235.112]:19655 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S261895AbTJMQR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:17:26 -0400
Message-ID: <3F8ACFE2.1080708@wanadoo.es>
Date: Mon, 13 Oct 2003 18:16:34 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [summary] state of scsi drivers
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        * LiNUX kernel SCSI/RAID drivers *
                <xose_AT_wanadoo.es>

                 linux-2.4.23-pre7
             Mon Oct 13 16:51:46 CEST 2003


x features:
 - 1 hot-plug
 - 2 vary_io
 - 3 highmem_io
 - 4 block device driver
 - more ?

o aacraid
 - manufacturer: ADAPTEC
 - kernel: 1.1.2 (2003-05-15)
 - latest: 1.1.4 (2003-10-08)
 - arch: i386
 - features:
 - maintainer: <Mark_Salyzyn_AT_adaptec.com> <aacraid_AT_adaptec.com>
               <linux-aacraid-devel_AT_dell.com>
 - url: http://www.domsch.com/linux/aacraid/

o aic7xxx/aic79xx
 - manufacturer: ADAPTEC
 - kernel: 6.2.36/1.3.10 (03-Jun-2003)
 - latest: 6.2.36/1.3.11 (15-Sep-2003)
 - arch: i386 ia64 powerpc
 - features:
 - maintainer: <gibbs_AT_scsiguy.com>
 - url: http://people.freebsd.org/~gibbs/linux/SRC/

o cciss
 - manufacturer: HP
 - kernel: 2.4.50
 - latest: 2.4.50
 - arch: i386
 - features: 4
 - maintainer: <mike.miller_AT_hp.com> <arrays_AT_hp.com>
               <Cciss-discuss_AT_lists.sourceforge.net>
 - url: http://sf.net/projects/cciss/

o DAC960
 - manufacturer: LSI Logic
 - kernel: 2.4.11 (11 Oct 2001)
 - latest: 2.4.20 (01 May 2003)
 - arch: i386 ia64 alpha
 - features: 4
 - maintainer: <dmo_AT_osdl.org>
 - url: http://www.osdl.org/archive/dmo/DAC960/
        http://www.dandelion.com/Linux/DAC960.html

o dpt_i2o
 - manufacturer: ADAPTEC
 - kernel: 2.4.5
 - latest: 2.4.5
 - arch: i386 ia64 alpha sparc
 - features:
 - maintainer: <deanna_bonds_AT_adaptec.com>
 - url: http://linux.adaptec.com

o feral_isp
 - manufacturer: QLOGIC
 - kernel: -
 - latest: Linux Platform 2.1 - Common Core Code 2.7 (2003-10-01)
 - arch: i386 alpha sparc powerpc
 - features: alternative driver for all qlogic products
 - maintainer: <mjacob_AT_feral.com>
 - url: http://www.feral.com/isp.html

o fusion
 - manufacturer: LSI Logic
 - kernel: 2.05.05+
 - latest: 2.05.05+
 - arch: i386 alpha sparc ia64 x86_64
 - features:
 - maintainer: <lstephen_AT_lsil.com> <sjralston1_AT_netscape.net>
 - url: ftp://ftp.lsil.com/HostAdapterDrivers/linux/

o gdth
 - manufacturer: ADAPTEC
 - kernel: 2.05 (2002/10/03)
 - latest: 2.06 (2002/11/08)
 - arch: i386 alpha ia64
 - features:
 - maintainer: <achim.leubner_AT_intel.com> <boji.t.kannanthanam_AT_intel.com>
 - url: http://www.icp-vortex.com/english/download/rz_neu/linux/linux_e.htm

o ips
 - manufacturer: ADAPTEC
 - kernel: 6.00.26
 - latest: 6.00.26
 - arch: i386 ia64
 - features:
 - maintainer: <david_jeffery_AT_adaptec.com> <ipslinux_AT_adaptec.com>
 - url: unknow ?

o megaraid
 - manufacturer: LSI Logic
 - kernel: v1.18k/v2.00.9
 - latest: v1.18k/v2.00.9
 - arch: i386
 - features:
 - maintainer: <atulm_AT_lsil.com> <linux-megaraid-devel_AT_dell.com>
 - url: ftp://ftp.lsil.com/pub/linux-megaraid/
        http://domsch.com/linux/megaraid/

o qla1280
 - manufacturer: QLOGIC
 - kernel: 3.23.37
 - latest: 3.23.37
 - arch: i386 alpha powerpc sparc
 - features:
 - maintainer: <jes_AT_wildopensource.com>
 - url: unknow ?

o qla2x00
 - manufacturer: QLOGIC
 - kernel: -
 - latest: 6.06.00   (Aug 08, 2003)
 - alpha:  8.00.00b5 (Jul 30, 2003)
 - arch: i386
 - features:
 - maintainer: <andrew.vasquez_AT_qlogic.com> <duane.grigsby_AT_qlogic.com> <sdake_AT_mvista.com>
               <raj.gandhi_AT_qlogic.com> <arun.mittal_AT_qlogic.com> <ryan.klein_AT_qlogic.com>
 - url: http://sf.net/projects/linux-qla2xxx/
        http://download.qlogic.com/drivers/13619/qla2x00-v6.06.00-dist.tgz

o sym53c8xx_2
 - manufacturer: LSI Logic
 - kernel: 2.1.17a     (Dec 01 2001)
 - latest: 2.1.18f     (Oct 13 2003)
 - beta:   2.1.19-pre3 (Nov 23 2002)
 - arch: i386 alpha sparc powerpc ia64
 - features:
 - maintainer: <matthew_AT_wil.cx>
 - url: http://www.tux.org/pub/tux/roudier/drivers/linux/stable/
        http://ftp.linux.org.uk/pub/linux/willy/patches/

# EOT

