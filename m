Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTE0U3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTE0U3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:29:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264107AbTE0U3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:29:40 -0400
Subject: Re: Linux 2.5.70
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054071760.2289.150.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 May 2003 14:42:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ompile statistics: 2.5.70
Compiler: gcc 3.2.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh

          bzImage       bzImage        modules
        (defconfig)  (allmodconfig) (allmodconfig)

2.5.70  7 warnings    10 warnings   1366 warnings
        0 errors       0 errors       57 errors

2.5.69  7 warnings    11 warnings   1366 warnings
        0 errors       0 errors       57 errors

2.5.68  7 warnings    11 warnings   1975 warnings
        0 errors       6 errors       60 errors

2.5.67  8 warnings    12 warnings   2136 warnings
        0 errors       6 errors       89 errros


Compile statistics have been for kernel releases from 2.5.46 to 2.5.70
at: www.osdl.org/archive/cherry/stability

Failure summary:

   drivers/block: 2 warnings, 1 errors
   drivers/char: 237 warnings, 4 errors
   drivers/isdn: 237 warnings, 8 errors
   drivers/media: 102 warnings, 5 errors
   drivers/mtd: 31 warnings, 1 errors
   drivers/net: 336 warnings, 6 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/video/i810: 3 warnings, 4 errors
   drivers/video/matrox: 3 warnings, 10 errors
   drivers/video: 81 warnings, 17 errors
   sound/oss: 49 warnings, 3 errors
   sound: 5 warnings, 3 errors


Warning summary:


   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/hotplug: 1 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 32 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 10 warnings, 0 errors
   drivers/usb: 13 warnings, 0 errors
   drivers/video/aty: 4 warnings, 0 errors
   drivers/video/sis: 3 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/cifs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 30 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/pci: 1 warnings, 0 errors
   sound/usb: 2 warnings, 0 errors



Other stability-related links:
   OSDL Stability page:
       http://osdl.org/projects/26lnxstblztn/results/
   Nightly linux-2.5 bk build:
       www.osdl.org/archive/cherry/stability/linus-tree/running.txt
   2.5 porting items:
       www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt
   2.5 porting items history:
       www.osdl.org/archive/cherry/stability/linus-tree/port_history.txt

John



