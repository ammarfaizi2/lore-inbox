Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279740AbRJYJtr>; Thu, 25 Oct 2001 05:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRJYJtg>; Thu, 25 Oct 2001 05:49:36 -0400
Received: from [213.236.192.200] ([213.236.192.200]:6821 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S279735AbRJYJtU>; Thu, 25 Oct 2001 05:49:20 -0400
Message-ID: <007101c15d3a$c6ae90e0$6ac0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl> <20011025112752.A4795@suse.de>
Subject: Asus CUV-266-D vs Intel NIC
Date: Thu, 25 Oct 2001 11:52:35 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Asus CUV266-d motherboard, and want to use my Intel NIC's..

2.4.10 & 2.4.12 hangs while "Setting up routing"
No error messages appear.

2.4.x(4 maybe?) has both officail Intel drivers and the tulip drivers.
When loading the tulip, it hangs just like with todays kernels.
When loading the Intel driver, everything works just fine for a short
while..
20-40seconds I guess.. Then the computer hangs.

When not loading any NIC drivers, everything works just fine.

The NIC's i've tried are named "Intel(R) PRO/100+ Dual Port Server Adapter"
Have also tried a "Intel(R) PRO/100+ Adapter"

Any ideas of what to test?
I have the latest bios and have tried just about all bios settings.
'noapic' doesn't help.

-=Dead2=-


