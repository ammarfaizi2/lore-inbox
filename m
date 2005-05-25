Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVEYS3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVEYS3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVEYS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:26:26 -0400
Received: from mail.tyan.com ([66.122.195.4]:50698 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261476AbVEYSKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:10:31 -0400
Message-ID: <3174569B9743D511922F00A0C943142309F815C1@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: RT patch acceptance
Date: Wed, 25 May 2005 11:10:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

the 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB.

the Core id seems to be right now.

the core 0 of node 1 can not be started and hang there.

YH

CPU 0(2) -> Node 0 -> Core 0
enabled ExtINT on CPU#0
ENABLING IO-APIC IRQs
Using IO-APIC 4
...changing IO-APIC physical APIC ID to 4 ... ok.
Using IO-APIC 5
...changing IO-APIC physical APIC ID to 5 ... ok.
Using IO-APIC 6
...changing IO-APIC physical APIC ID to 6 ... ok.
Using IO-APIC 7
...changing IO-APIC physical APIC ID to 7 ... ok.
Synchronizing Arb IDs.
testing the IO APIC.......................




.................................... done.
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81007ff07f58
Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/2 rip 6000 rsp ffff81013ff11f58
Initializing CPU#2
masked ExtINT on CPU#2
