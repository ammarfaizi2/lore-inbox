Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFXRJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFXRJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:09:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262185AbTFXRJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:09:28 -0400
Subject: 2.5.73 compile results
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Jun 2003 10:26:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.73
Compiler: gcc 3.2.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh

          bzImage       bzImage        modules
        (defconfig)  (allmodconfig) (allmodconfig)

2.5.73  2 warnings    11 warnings   1347 warnings
        0 errors       9 errors       43 errors

2.5.72  2 warnings     8 warnings   1335 warnings
        0 errors       0 errors       48 errors

2.5.71  6 warnings    11 warnings   1347 warnings
        0 errors       0 errors       48 errors

2.5.70  7 warnings    10 warnings   1366 warnings
        0 errors       0 errors       57 errors


Compile statistics have been for kernel releases from 2.5.46 to 2.5.73
at: www.osdl.org/archive/cherry/stability (will be posted by 11AM)

Error Summary:
                                                                                
   drivers/block: 2 warnings, 1 errors
   drivers/char: 234 warnings, 5 errors
   drivers/isdn: 216 warnings, 6 errors
   drivers/media: 102 warnings, 5 errors
   drivers/mtd: 53 warnings, 3 errors
   drivers/net: 29 warnings, 6 errors
   drivers/net: 314 warnings, 6 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/scsi: 114 warnings, 11 errors
   drivers/video: 75 warnings, 3 errors
   sound/oss: 49 warnings, 3 errors
   sound: 5 warnings, 3 errors
                                                                                
                                                                                
Warning Summary:
                                                                                
   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 29 warnings, 0 errors
   drivers/ieee1394: 2 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pci: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 5 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 9 warnings, 0 errors
   drivers/usb: 1 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 2 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs2: 1 warnings, 0 errors
   fs/jffs: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 35 warnings, 0 errors
   sound/isa: 16 warnings, 0 errors

John

