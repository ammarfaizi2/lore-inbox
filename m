Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317607AbSFNOjq>; Fri, 14 Jun 2002 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSFNOjp>; Fri, 14 Jun 2002 10:39:45 -0400
Received: from mtvwca1-smrly1.gtei.net ([128.11.176.196]:24479 "HELO
	mtvwca1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id <S317607AbSFNOjo>; Fri, 14 Jun 2002 10:39:44 -0400
To: linux-kernel@vger.kernel.org
Cc: nick@coelacanth.com
Subject: Arkeia Back + v2.4.18
From: Nick Papadonis <nick@bose.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: Thu, 13 Jun 2002 14:00:24 -0400
Message-Id: <m38z5jvz2f.fsf@noop.bombay>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.1 (Cuyahoga Valley,
 i686-pc-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone having kernel lock ups using 'Arkeia backup' with kernel
v2.4.18?

Network backups start out fine, however cause the kernel to lock up
half way through.  I read that v2.2.16 solved problems for the
v2.2.x series kernel, but haven't read anything on v2.4.x.

Were there any big changes in memory management between v2.2 and v2.2?

Thanks

- Nick

My configuration is:
--------------------
Linux v2.4.18
RH 7.2-en

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: HP        Model: C1537A            Rev: L812
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 32)

arkeia-arkc-4.2.1-1.i386.rpm
arkeia-client-4.2.17-2.i386.rpm
arkeia-gui-4.2.7-2.i386.rpm    
arkeia-server-shareware-4.2.10-1.i386.rpm


