Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319658AbSH3T3V>; Fri, 30 Aug 2002 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319659AbSH3T3V>; Fri, 30 Aug 2002 15:29:21 -0400
Received: from mz01.hal9001.net ([80.16.61.154]:45964 "EHLO server.hal9001.net")
	by vger.kernel.org with ESMTP id <S319658AbSH3T3V>;
	Fri, 30 Aug 2002 15:29:21 -0400
Message-ID: <3D6FC85D.67286B32@hal9001.net>
Date: Fri, 30 Aug 2002 21:32:45 +0200
From: Stefano Biella <sbiella@hal9001.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic: no init found with 2.5.32
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a slackware 8.1 machine that works fine with 2.4.18/19 kernels,
but,when I reboot with the 2.5.31/32 kernels, the system have a "kernel
panic: no init found. try passing init= option to kernel" The fs is a
reisersfs v.3.6 on Intel PIIX4 chipset with udma33 disk.
The disk is not corrupted because if I back to 2.4.X the machine boot
fine.

what's wrong?

