Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274959AbTHATmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTHATkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:40:04 -0400
Received: from smtp14.eresmas.com ([62.81.235.114]:58583 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S270678AbTHATfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:35:55 -0400
Message-ID: <3F2AC10D.9000600@wanadoo.es>
Date: Fri, 01 Aug 2003 21:35:41 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: [scsi drivers summary]
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        * LiNUX kernel SCSI/RAID drivers *

                <xose_AT_wanadoo.es>
                    2.4.22-pre8
            Fri Aug  1 19:16:38 CEST 2003


x features:
 - 1 hot-plug
 - 2 vary_io
 - 3 highmem_io
 - 4 block device driver
 - more ?

o aacraid
 - manufacturer: ADAPTEC
 - kernel: 1.1.2
 - latest: 1.1.2
 - arch: i386
 - features:
 - maintainer: <alan_AT_redhat.com> <aacraid_AT_adaptec.com> <linux-aacraid-devel_AT_dell.com>
 - url: http://www.domsch.com/linux/aacraid/

o aic7xxx/aic79xx
 - manufacturer: ADAPTEC
 - kernel: 6.2.36/1.3.10
 - latest: 6.2.36/1.3.10
 - arch: i386 ia64 powerpc
 - features:
 - maintainer: <gibbs_AT_scsiguy.com>
 - url: http://people.freebsd.org/~gibbs/linux/SRC/

o cciss
 - manufacturer: HP
 - kernel: 2.4.47
 - latest: 2.4.47
 - arch: i386
 - features: 4
 - maintainer: <arrays_AT_hp.com> <steve.cameron_AT_hp.com>
 - url: http://sf.net/projects/cciss/

o DAC960
 - manufacturer: LSI Logic
 - kernel: 2.4.11 (11 Oct 2001)
 - latest: 2.4.20  (1 May 2003)
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
 - url: http://linux.adaptec.com/linux_raid_unsupported.html
        http://linux.adaptec.com/Linux_drivers.html

o feral_isp
 - manufacturer: QLOGIC
 - kernel: not in kernel
 - latest: Linux Platform 2.1 - Common Core Code 2.7, 14 Jun 2003
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
 - kernel: 2.05
 - latest: 2.05
 - arch: i386 alpha ia64
 - features:
 - maintainer: <achim.leubner_AT_intel.com> <boji.t.kannanthanam_AT_intel.com>
 - url: http://www.icp-vortex.com/english/download/rdrnrsrz/linux/linux_e.htm

o ips
 - manufacturer: ADAPTEC
 - kernel: 6.00.26
 - latest: 6.00.26
 - arch: i386 ia64
 - features:
 - maintainer: <ipslinux_AT_adaptec.com>
 - url: unknow ?

o megaraid
 - manufacturer: LSI Logic
 - kernel: v1.18f (Dec 10 2002)
 - latest: v1.18i (Jun 20 2003) / v2.00.6 (Jul 30 2003)
 - arch: i386
 - features:
 - maintainer: <atulm_AT_lsil.com> <linux-megaraid-devel_AT_dell.com>
 - url: ftp://ftp.lsil.com/pub/linux-megaraid/
        http://domsch.com/linux/megaraid/

o qla1280
 - manufacturer: QLOGIC
 - kernel: 3.00 (Jan 17, 1999)-> DANGER !! very outdated
 - latest: 3.12 (Aug 17, 2000)
 - beta:   3.23 (Jan 12, 2001)
 - arch: i386 alpha powerpc sparc
 - features:
 - maintainer: same peple than qla2x00 :-? or <linux-scsi_AT_vger.kernel.org>
 - url: http://download.qlogic.com/drivers/2206/qla1x160src-3.12.tgz
        http://download.qlogic.com/drivers/2209/qla1x160src-3.23Beta.tgz

o qla2x00
 - manufacturer: QLOGIC
 - kernel: not in kernel
 - latest: 6.05.00   (Apr 30, 2003)
 - alpha:  8.00.00b5 (Jul 30, 2003)
 - arch: i386
 - features:
 - maintainer: <andrew.vasquez_AT_qlogic.com> <duane.grigsby_AT_qlogic.com> <raj.gandhi_AT_qlogic.com>
               <sdake_AT_mvista.com> <arun.mittal_AT_qlogic.com> <ryan.klein_AT_qlogic.com>
 - url: http://sf.net/projects/linux-qla2xxx/
        http://download.qlogic.com/drivers/11631/qla2x00src-v6.05.00.tgz

o sym53c8xx_2
 - manufacturer: LSI Logic
 - kernel: 2.1.17a     (Dec 01 2001)
 - latest: 2.1.19-pre3 (Nov 23 2002)
 - arch: i386 alpha sparc powerpc ia64
 - features:
 - maintainer: <groudier_AT_free.fr>
 - url: http://www.tux.org/pub/tux/roudier/drivers/linux/stable/

#EOT

