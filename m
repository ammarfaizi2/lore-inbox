Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTDGVdY (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTDGVdY (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:33:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263676AbTDGVdI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:33:08 -0400
Subject: Re: Linux 2.5.67
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049752027.12743.11.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 14:47:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.67
Compiler: gcc 3.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh


                               2.5.66               2.5.67
                       --------------------    -----------------
bzImage (defconfig)          8 warnings           8 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      11 warnings          12 warnings
                             6 errors             6 errors

modules (allmodconfig)    2285 warnings        2240 warnings
                            96 errors            89 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.67
at: www.osdl.org/archive/cherry/stability  (will be updated by 6PM PST).


Failure summary:
   drivers/block: 12 warnings, 1 errors
   drivers/char: 369 warnings, 7 errors
   drivers/hotplug: 16 warnings, 2 errors
   drivers/i2c: 5 warnings, 1 errors
   drivers/isdn: 253 warnings, 6 errors
   drivers/macintosh: 1 warnings, 1 errors
   drivers/media: 132 warnings, 6 errors
   drivers/mtd: 32 warnings, 2 errors
   drivers/net: 502 warnings, 8 errors
   drivers/video: 151 warnings, 13 errors
   drivers/video/matrox: 61 warnings, 10 errors
   sound: 67 warnings, 30 errors
   sound/isa: 61 warnings, 26 errors
   sound/oss: 55 warnings, 4 errors

Warning summary:
   drivers/atm: 39 warnings, 0 errors
   drivers/cdrom: 37 warnings, 0 errors
   drivers/ide: 32 warnings, 0 errors
   drivers/ieee1394: 3 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/parport: 2 warnings, 0 errors
   drivers/pcmcia: 5 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 10 warnings, 0 errors
   drivers/usb: 28 warnings, 0 errors
   drivers/video/aty: 9 warnings, 0 errors
   drivers/video/i810: 1 warnings, 0 errors
   drivers/video/sis: 3 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/coda: 2 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   fs/xfs: 1 warnings, 0 errors
   net: 203 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/pci: 12 warnings, 0 errors


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



