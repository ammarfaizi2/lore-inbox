Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUBOQLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUBOQLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:11:32 -0500
Received: from web14903.mail.yahoo.com ([216.136.225.55]:65171 "HELO
	web14903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265071AbUBOQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:11:31 -0500
Message-ID: <20040215161130.44413.qmail@web14903.mail.yahoo.com>
Date: Sun, 15 Feb 2004 08:11:30 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [BK PATCHES] 2.6.x libata update
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is this right? My ATA drive is on ide0. Because of the RAID my IDE and SATA
drives should >have about the same number of interrupts. But half of my IDE
interrupts are showing up on >ide1, on CPU #1. There shouldn't be any interrupts
showing up on CPU#1 with hyperthreading.

I didn't read that right, half are on ide0 and half on ide1 and only one on CPU
#1. My drive is on ide0, is it right to get half on ide1?




=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
