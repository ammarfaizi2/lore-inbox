Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTDTBjC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 21:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbTDTBjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 21:39:02 -0400
Received: from [62.37.236.142] ([62.37.236.142]:61391 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263507AbTDTBiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 21:38:51 -0400
Message-ID: <3EA1FCF4.5000800@wanadoo.es>
Date: Sun, 20 Apr 2003 03:50:44 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: [report about real state of scsi drivers]
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I have made a mini-report about scsi drivers.
More information is welcome.

-thanks-

--cut--
        * LiNUX kernel SCSI/RAID HBA drivers *

                <xose_AT_wanadoo.es>
           v1 Sun Apr 20 03:26:45 CEST 2003
              kernel 2.4.21-pre7-ac1

x aacraraid
 - kernel: 0.9.9ac6-TEST
 - latest: in kernel ??
 - e-mail: <alan_AT_redhat.com> <aacraid_AT_adaptec.com>
 - url:    http://ftp.linux.org.uk/pub/linux/alan/Kernel/Drivers/AACRAID/
           http://www.domsch.com/linux/aacraid/alan/

x aic7xxx/aic79xx
 - kernel: 6.2.28/1.3.0 2003/01/21 18:26:00
 - latest: 6.2.32/1.3.7 2003/04/16 15:54:11
 - e-mail: Justin T. Gibbs <gibbs_AT_scsiguy.com>
 - url:    http://people.freebsd.org/~gibbs/linux/SRC/

x cciss
 - kernel: 2.4.42
 - latest: 2.4.44
 - e-mail: <Mike.Miller_AT_hp.com>
 - url:    http://sourceforge.net/projects/ccissa
           http://www.ussg.iu.edu/hypermail/linux/kernel/0304.2/0120.html

x cpqfc
 - kernel: 2.1.2 Jul 22, 2002
 - latest: in kernel ??
 - e-mail: <Charles.White_AT_hp.com> Amy Vanzant-Hodge <fibrechannel_AT_compaq.com>
 - url:    http://sourceforge.net/projects/cpqfc

x DAC960
 - kernel: 2.4.11 11 October 2001
 - latest: 2.4.20 2003
 - e-mail: Dave Olien dmo_AT_osdl.org
 - url:    http://lists.debian.org/debian-alpha/2003/debian-alpha-200301/msg00020.html
           http://www.ussg.iu.edu/hypermail/linux/kernel/0302.0/0829.html
           http://www.dandelion.com/Linux/DAC960.html
           http://www.osdl.org/archive/dmo/DAC960/

x dpt_i2o
 - kernel: 2.4 25 July 01
 - latest: 2.4 25 July 01
 - e-mail: <deanna_bonds_AT_adaptec.com>
 - url:    http://linux.adaptec.com/linux_raid_unsupported.html
           http://linux.adaptec.com/Linux_drivers.html

x fusion
 - kernel: 2.05.00+ 2003/01/28 21:31:56
 - latest: 2.05.00+ 2003/01/28 21:31:56
 - e-mail: <Pam.Delaney_AT_lsil.com> <sjralston1_AT_netscape.net>
 - url:    ftp://ftp.lsil.com/HostAdapterDrivers/linux/

x ips
 - kernel: 6.00.26
 - latest: in kernel ??
 - e-mail: <ipslinux_AT_adaptec.com>
 - url:    unknow ??

x gdth
 - kernel: 2.05
 - latest: 2.05
 - e-mail: <achim.leubner_AT_intel.com> <boji.t.kannanthanam_AT_intel.com>
 - url:    http://www.icp-vortex.com/english/download/rdrnrsrz/linux/linux_e.htm

x megaraid

 - kernel: v1.18f (Dec 10, 2002)
 - latest: v2.00.3 (Feb 19, 2003)
 - beta:   v2.00.4-beta1 (Apr 15, 2003)
 - e-mail: Atul Mukke <atulm_AT_lsil.com>
 - url:    ftp://ftp.lsil.com/pub/linux-megaraid/
           http://domsch.com/linux/megaraid/

x qla1280

 - kernel: 3.00 Jan 17, 1999
 - latest: 3.12 August 17, 2000
 - beta:   3.23 Beta January 12 , 2001
 - e-mail: someone at qlogic
 - url:    http://www.qlogic.com/support/retired/qla1280_drvrs/linux/qla1x160src-3.12.tgz
           http://download.qlogic.com/drivers/2209/qla1x160src-3.23Beta.tgz

x qla2x00
 - kernel: not in kernel !!
 - latest: 6.04.00 January 20, 2003
 - beta:   6.05.00b9 March 31, 2003
 - e-mail: someone at qlogic
 - url :   http://download.qlogic.com/drivers/9626/qla2x00-v6.04.00-dist.tgz
           http://download.qlogic.com/drivers/9646/qla2x00-v6.05.00b9-dist.tgz

x qla4xxx
 - kernel: not in kernel !!
 - latest: 1.14 12/13/2002
 - e-mail: someone at qlogic
 - url: i  http://download.qlogic.com/drivers/7506/

x sym53c8xx_2
 - kernel: 2.1.17a Sat Dec 01 18:00 2001
 - latest: 2.1.19-pre3 Sat Nov 23 20:00 2002
 - e-mail: Gerard Roudier <groudier_AT_free.fr>
 - url:    ftp://ftp.tux.org/roudier/drivers/linux/stable/

# EOF
--the-end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

