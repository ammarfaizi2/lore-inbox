Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271069AbTG2AKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271113AbTG2AKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 20:10:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:12945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271069AbTG2AKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 20:10:51 -0400
Subject: Re: Linux v2.6.0-test2 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059437647.10207.14.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jul 2003 17:14:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.6.0-test2
Compiler: gcc 3.2.2
Script: http://developer.osdl.org/~cherry/compile/compregress.sh

               bzImage       bzImage        modules
             (defconfig)  (allmodconfig) (allmodconfig)

2.6.0-test2  0 warnings     7 warnings   1201 warnings
             0 errors       9 errors       43 errors

2.6.0-test1  0 warnings     8 warnings   1319 warnings
             0 errors       9 errors       38 errors

2.5.75       0 warnings     8 warnings   1296 warnings
             0 errors       9 errors       39 errors



Compile statistics for 2.5 kernels and 2.6 kernels are at:
http://developer.osdl.org/~cherry/compile/


Failure summary:

   drivers/block: 2 warnings, 1 errors
   drivers/char: 200 warnings, 4 errors
   drivers/isdn: 212 warnings, 5 errors
   drivers/media: 103 warnings, 6 errors
   drivers/mtd: 42 warnings, 1 errors
   drivers/net: 226 warnings, 11 errors
   drivers/net: 40 warnings, 11 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/scsi: 101 warnings, 10 errors
   drivers/video: 101 warnings, 3 errors
   sound/oss: 51 warnings, 2 errors
   sound: 2 warnings, 2 errors

Warning summary:

   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 28 warnings, 0 errors
   drivers/ieee1394: 1 warnings, 0 errors
   drivers/md: 3 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 9 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 35 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors

John


