Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTETOoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTETOoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:44:20 -0400
Received: from smtp2.wanadoo.es ([62.37.236.136]:46577 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263804AbTETOoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:44:13 -0400
Message-ID: <3ECA41EA.3030206@wanadoo.es>
Date: Tue, 20 May 2003 16:55:38 +0200
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

more info is welcome. thanks


        * LiNUX kernel SCSI/RAID HBA drivers *

                <xose_AT_wanadoo.es>
               kernel 2.4.21-rc2-ac2
           Sun May 20 16:54:40 CEST 2003


x features:
 - 1 hot-plug
 - 2 vary_io
 - 3 highmem_io
 - 4 block device driver
 - more ?

o aacraid
 - manufacturer: ADAPTEC
 - kernel: 0.9.9ac6-TEST
 - latest: 1.1.2
 - arch: i386
 - features:
 - e-mail: <alan_AT_redhat.com> <aacraid_AT_adaptec.com>
 - url: http://www.domsch.com/linux/aacraid/

o aic7xxx/aic79xx
 - manufacturer: ADAPTEC
 - kernel: 6.2.8
 - latest: 6.2.33/1.3.8 2003/05/02 12:03:52
 - arch: i386
 - features:
 - e-mail: <gibbs_AT_scsiguy.com>
 - url: http://people.freebsd.org/~gibbs/linux/SRC/

o cciss
 - manufacturer: HP
 - kernel: 2.4.44
 - latest: in kernel ?
 - arch: i386
 - features: 4
 - e-mail: <Cciss-discuss_AT_lists.sourceforge.net>
 - url: http://sourceforge.net/projects/cciss

o cpqarray
 - manufacturer: HP
 - kernel: 2.4.25
 - latest: in kernel ?
 - arch: i386
 - features: 4
 - e-mail: <Cpqarray-discuss_AT_lists.sourceforge.net> <arrays_AT_compaq.com>
 - url: http://sourceforge.net/projects/cpqarray

o cpqfc
 - manufacturer: HP
 - kernel: 2.1.2 Jul 22, 2002
 - latest: in kernel ?
 - arch: i386
 - features:
 - e-mail: <cpqfc-discuss_AT_lists.sourceforge.net> <fibrechannel_AT_compaq.com>
 - url: http://sourceforge.net/projects/cpqfc

o DAC960
 - manufacturer: LSI Logic
 - kernel: 2.4.11 11 October 2001
 - latest: 2.4.20 4 December 2002
 - arch: i386
 - features: 4
 - e-mail: <dmo_AT_osdl.org>
 - url: http://www.osdl.org/archive/dmo/DAC960/
        http://www.dandelion.com/Linux/DAC960.html

o dpt_i2o
 - manufacturer: ADAPTEC
 - kernel: 2.4.5 30 July 01
 - latest: 2.4.5 30 July 01
 - arch: i386
 - features:
 - e-mail: <deanna_bonds_AT_adaptec.com>
 - url: http://linux.adaptec.com/linux_raid_unsupported.html
        http://linux.adaptec.com/Linux_drivers.html

o fusion
 - manufacturer: LSI Logic
 - kernel: 2.05.00+ 2003/01/28 21:31:56
 - latest: 2.05.00+ 2003/01/28 21:31:56
 - arch: i386
 - features:
 - e-mail: <Pam.Delaney_AT_lsil.com> <sjralston1_AT_netscape.net>
 - url: ftp://ftp.lsil.com/HostAdapterDrivers/linux/

o gdth
 - manufacturer: INTEL
 - kernel: 2.05
 - latest: 2.05
 - arch: i386
 - features:
 - e-mail: <achim.leubner_AT_intel.com> <boji.t.kannanthanam_AT_intel.com>
 - url: http://www.icp-vortex.com/english/download/rdrnrsrz/linux/linux_e.htm

o ips
 - manufacturer: ADAPTEC
 - kernel: 6.00.26
 - latest: in kernel ?
 - arch: i386
 - features:
 - e-mail: <ipslinux_AT_adaptec.com>
 - url: unknow ?

o megaraid
 - manufacturer: LSI Logic
 - kernel: v2.00.5 (Apr 24, 2003) / v1.18f Dec 10 2002
 - latest: v2.00.5 (Apr 24, 2003)
 - arch: i386
 - features:
 - e-mail: <atulm_AT_lsil.com>
 - url: ftp://ftp.lsil.com/pub/linux-megaraid/
        http://domsch.com/linux/megaraid/

o qla1280
 - manufacturer: QLOGIC
 - kernel: 3.00 Jan 17, 1999 -> very outdated !!
 - latest: 3.12 August 17, 2000
 - beta: 3.23 Beta January 12 , 2001
 - latest_25: kernel 2.5
 - arch: i386
 - features:
 - e-mail: same than qla2x00 ? <linux-scsi_AT_vger.kernel.org>
 - url: http://download.qlogic.com/drivers/2206/qla1x160src-3.12.tgz
        http://download.qlogic.com/drivers/2209/qla1x160src-3.23Beta.tgz

o qla2x00
 - manufacturer: QLOGIC
 - kernel: not in kernel !!
 - latest: 6.04.02 March 24, 2003
 - beta: 6.05.00b9 March 31, 2003
 - beta: 8.00.00b1 May 7, 2003
 - arch: i386
 - features:
 - e-mail: <andrew.vasquez_AT_qlogic.com> <duane.grigsby_AT_qlogic.com> <raj.gandhi_AT_qlogic.com>
           <sdake_AT_mvista.com> <arun.mittal_AT_qlogic.com> <ryan.klein_AT_qlogic.com>
 - url: http://sourceforge.net/projects/linux-qla2xxx/
        http://download.qlogic.com/drivers/10175/qla2x00src-v6.04.02.tgz
        http://download.qlogic.com/drivers/9646/qla2x00-v6.05.00b9-dist.tgz

o sym53c8xx_2
 - manufacturer: LSI Logic
 - kernel: 2.1.17a Sat Dec 01 18:00 2001
 - latest: 2.1.19-pre3 Sat Nov 23 20:00 2002
 - arch: i386
 - features:
 - e-mail: Gerard Roudier <groudier_AT_free.fr>
 - url: ftp://ftp.tux.org/roudier/drivers/linux/stable/

# EOF

regards,
-- 
Software is like sex, it's better when it's bug free.


