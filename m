Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTDURw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTDURw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:52:59 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261849AbTDURwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:52:55 -0400
Subject: Re: Linux 2.5.68
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050948298.2293.70.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Apr 2003 11:04:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.68
Compiler: gcc 3.2.2 (gcc 3.2 used prior to 2.5.68)
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh


                               2.5.67               2.5.68
                       --------------------    -----------------
bzImage (defconfig)          8 warnings           7 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      12 warnings          11 warnings
                             6 errors             6 errors

modules (allmodconfig)    2240 warnings        1975 warnings
                            89 errors            60 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.68
at: www.osdl.org/archive/cherry/stability  (will be updated by 6PM PST).

Failure summary:

   drivers/block: 8 warnings, 1 errors
   drivers/char: 342 warnings, 4 errors
   drivers/hotplug: 16 warnings, 2 errors
   drivers/ieee1394: 9 warnings, 2 errors
   drivers/isdn: 255 warnings, 6 errors
   drivers/media: 118 warnings, 5 errors
   drivers/mtd: 31 warnings, 1 errors
   drivers/net: 446 warnings, 8 errors
   drivers/video/matrox: 3 warnings, 10 errors
   drivers/video: 82 warnings, 13 errors
   net: 167 warnings, 2 errors
   sound/oss: 66 warnings, 3 errors
   sound: 5 warnings, 3 errors


Warning summary:

   drivers/atm: 39 warnings, 0 errors
   drivers/cdrom: 35 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 34 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/parport: 2 warnings, 0 errors
   drivers/pcmcia: 5 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 10 warnings, 0 errors
   drivers/usb: 19 warnings, 0 errors
   drivers/video/aty: 9 warnings, 0 errors
   drivers/video/riva: 3 warnings, 0 errors
   drivers/video/sis: 3 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfs: 1 warnings, 0 errors
   fs/nfsd: 4 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   fs/xfs: 1 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors


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


