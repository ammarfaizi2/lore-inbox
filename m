Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136427AbRD3BLR>; Sun, 29 Apr 2001 21:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136425AbRD3BK6>; Sun, 29 Apr 2001 21:10:58 -0400
Received: from saloma.stu.rpi.edu ([128.113.199.230]:6404 "EHLO incandescent")
	by vger.kernel.org with ESMTP id <S136427AbRD3BKz>;
	Sun, 29 Apr 2001 21:10:55 -0400
Date: Sun, 29 Apr 2001 21:10:49 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: deregister?
Message-ID: <20010429211049.A17111@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux incandescent 2.4.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm kind of curious; "deregister" is used quite often in the kernel:

pcmcia_deregister_client
pcmcia_deregister_erase_queue
misc_deregister
atm_dev_deregister
atm_proc_dev_deregister
usb_deregister_bus
usb_deregister
usb_serial_deregister
scsi_deregister_blocked_host
matroxfb_dh_deregisterfb

Not to mention in various comments and documentation.  Deregister,
according to www.m-w.com (and many other dictionaries), is not a word.
Is there some sort of historical significance to this being used, in
place of "unregister"?


-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
