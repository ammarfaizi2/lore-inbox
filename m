Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317973AbSFSSg6>; Wed, 19 Jun 2002 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317974AbSFSSg5>; Wed, 19 Jun 2002 14:36:57 -0400
Received: from pool-141-155-119-31.ny5030.east.verizon.net ([141.155.119.31]:5249
	"EHLO mylaptop.gatworks.com") by vger.kernel.org with ESMTP
	id <S317973AbSFSSg5>; Wed, 19 Jun 2002 14:36:57 -0400
Message-ID: <3D10836F.33E42F14@voicenet.com>
Date: Wed, 19 Jun 2002 09:13:19 -0400
From: Uncle George <gatgul@voicenet.com>
Organization: GatWorks.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: linux.dev.kernel
CC: linux-kernel@vger.kernel.org
Subject: Kernel Profiling a device driver
References: <pan.2002.05.16.14.10.05.542669.21313@sysk-net.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on my laptop i have a xircom 100 credit kard pcmcia device.

Unfortunately, at 100mbps, the system time goes up to nearly 100% usage.
( the on-board ethernet at 100mbps gets around 25% system usage )

Is there a way to profile the device driver so that i can zero in on the
section of code that may be spinning, doing inefficient things ?

