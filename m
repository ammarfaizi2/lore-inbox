Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTBQTYO>; Mon, 17 Feb 2003 14:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTBQTYO>; Mon, 17 Feb 2003 14:24:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267410AbTBQTYL>;
	Mon, 17 Feb 2003 14:24:11 -0500
Subject: Re: Linux v2.5.61
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1045510507.3406.12.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 11:35:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.61

Note that gcc 3.2 was used for all of these statistics. 

                               2.5.60               2.5.61
                       --------------------    -----------------
bzImage (defconfig)         21 warnings          19 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      34 warnings          33 warnings
                             9 errors             9 errors

modules (allmodconfig)    3060 warnings        2531 warnings
                           222 errors           176 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.61
at: www.osdl.org/archive/cherry/stability

Warning summary
   drivers/atm: 49 warnings, 0 errors
   drivers/bluetooth: 15 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 42 warnings, 0 errors
   drivers/md: 18 warnings, 0 errors
   drivers/message: 8 warnings, 0 errors
   drivers/parport: 10 warnings, 0 errors
   drivers/pcmcia: 13 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 9 warnings, 0 errors
   drivers/usb: 18 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/riva: 7 warnings, 0 errors
   fs/cifs: 4 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/ntfs: 2 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   fs/xfs: 1 warnings, 0 errors
   net: 285 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/pci: 7 warnings, 0 errors

Failure summary
   drivers/block: 11 warnings, 2 errors
   drivers/char: 357 warnings, 8 errors
   drivers/hotplug: 18 warnings, 3 errors
   drivers/ieee1394: 17 warnings, 2 errors
   drivers/isdn: 282 warnings, 5 errors
   drivers/macintosh: 1 warnings, 2 errors
   drivers/media: 123 warnings, 7 errors
   drivers/mtd: 29 warnings, 2 errors
   drivers/net: 488 warnings, 12 errors
   drivers/video: 209 warnings, 32 errors
   drivers/video/matrox: 61 warnings, 20 errors
   drivers/video/sis: 37 warnings, 4 errors
   sound: 94 warnings, 62 errors
   sound/isa: 80 warnings, 54 errors
   sound/oss: 134 warnings, 8 errors

John

