Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUAYTnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUAYTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:43:31 -0500
Received: from web12304.mail.yahoo.com ([216.136.173.102]:48985 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265181AbUAYTna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:43:30 -0500
Message-ID: <20040125194329.59773.qmail@web12304.mail.yahoo.com>
Date: Sun, 25 Jan 2004 11:43:29 -0800 (PST)
From: Mike Keehan <mike_keehan@yahoo.com>
Subject: 2.6.2-rc1-bk3 patch fails
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applying the above patch to 2.6.1 gets failure in:-

. Makefile
. arch/i386/kernel/cpu/mcheck/non-fatal.c
. drivers/cdrom/cdrom.c
. drivers/input/joydev.c
. drivers/input/keyboard/atkbd.c
. drivers/md/Kconfig
. drivers/md/raid6.h  (doesn't exist)

I control C'd out of the rest.  The BK snapshots on 
kernel.org aren't meant to be applied cumulatively, 
are they?

Mike

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
