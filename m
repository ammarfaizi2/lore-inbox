Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUCDEKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCDEHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:07:16 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48316 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261448AbUCDEGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:06:35 -0500
Date: Wed, 3 Mar 2004 23:07:12 -0500
From: Hui Zhou <zhouhui@wam.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: Slow wireless network after enable acpi
Message-ID: <20040304040712.GA22070@turquoise.nrockv01.md.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for bothering you.

I recently installed redhat 9 on my laptop- HP/ZE1115 with duron
processor, every thing with via chipsets, using SMC 802.11b pcmcia
card.

Some how the bios doesn't boot from hardrive (must be bad sectors),
installed redhat and boot from grub floppy. Compiled kernel with
2.4.25. The wiless card uses tainted driver ADM8211. First-time
compiled with apm, every thing is OK, but the laptop gets so hot
without the support of apm. Recompiled with acpi, now the laptop cools
down, but the network get very slow. Still pings my desktop with 1~2
ms, but ssh to it waits for ever. Same thing for internet browsing.

Every thing is compiled into kernel, except the wireless driver
8211.o. The computer runs other program seems OK.

Let me know if I should post more infomation and thanks for attention.

-Hui
