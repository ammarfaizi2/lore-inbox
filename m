Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262839AbTCWGWB>; Sun, 23 Mar 2003 01:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTCWGWA>; Sun, 23 Mar 2003 01:22:00 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:30848 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262839AbTCWGV7>; Sun, 23 Mar 2003 01:21:59 -0500
Date: Sun, 23 Mar 2003 15:32:07 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.65-ac3] Updates for PC-9800 related (0/5) summary
Message-ID: <20030323063207.GA2803@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for merging.
These are the update patch for NEC PC-9800 subarchitecture related files
against 2.5.65-ac3. Please apply.

Description:
 o alsa-update.patch (1/5)
   Update sound/core/Makefile. Restore missing target for PC-98.

 o boot98-update.patch (2/5)
   Update arch/i386/Makefile and arch/i386/boot98/*.

 o floppy98-update.patch (3/5)
   Update PC98 standard floppy driver.

 o network_card-update.patch (4/5)
   Update drivers/net/Kconfig. Remove duplicated entry for PC-98.

 o video_card-update.patch (5/5)
   Add missing files for PC98 Standard text mode video driver.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

