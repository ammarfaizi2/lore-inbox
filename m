Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTFQOxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbTFQOwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:52:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10634 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264777AbTFQOmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:42:19 -0400
Subject: Re: Linux v2.5.72 and a move to OSDL
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306162131350.1644-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306162131350.1644-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055861922.13400.3.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Jun 2003 07:58:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.72
Compiler: gcc 3.2.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh

          bzImage       bzImage        modules
        (defconfig)  (allmodconfig) (allmodconfig)

2.5.72  2 warnings     8 warnings   1335 warnings
        0 errors       0 errors       48 errors

2.5.71  6 warnings    11 warnings   1347 warnings
        0 errors       0 errors       57 errors

2.5.70  7 warnings    10 warnings   1366 warnings
        0 errors       0 errors       57 errors

2.5.69  7 warnings    11 warnings   1567 warnings
        0 errors       0 errors       57 errors

2.5.68  7 warnings    11 warnings   1975 warnings
        0 errors       6 errors       60 errors

2.5.67  8 warnings    12 warnings   2136 warnings
        0 errors       6 errors       89 errros


Compile statistics have been for kernel releases from 2.5.46 to 2.5.72
at: www.osdl.org/archive/cherry/stability (will be posted by 9AM)

BTW, welcome to OSDL Linus.

Error Summary:
 
   drivers/block: 2 warnings, 1 errors
   drivers/char: 231 warnings, 6 errors
   drivers/isdn: 219 warnings, 7 errors
   drivers/media: 102 warnings, 5 errors
   drivers/mtd: 53 warnings, 3 errors
   drivers/net: 27 warnings, 6 errors
   drivers/net: 328 warnings, 6 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/scsi: 112 warnings, 14 errors
   drivers/video: 75 warnings, 3 errors
   sound/oss: 49 warnings, 3 errors
   sound: 5 warnings, 3 errors
 
                                                                                
Warning Summary:
                                                                                
   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 29 warnings, 0 errors
   drivers/ieee1394: 1 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pci: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 10 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 2 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 27 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors

John

