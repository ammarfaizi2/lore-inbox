Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313836AbSDIKTw>; Tue, 9 Apr 2002 06:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313837AbSDIKTv>; Tue, 9 Apr 2002 06:19:51 -0400
Received: from vivi.uptime.at ([62.116.87.11]:40666 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S313836AbSDIKTu>;
	Tue, 9 Apr 2002 06:19:50 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <linux-kernel@vger.kernel.org>
Subject: Compaq Alpha DS10 - Kernel 2.4.18
Date: Tue, 9 Apr 2002 12:19:37 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000d01c1dfb0$0da74a30$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <1018346790.680.10.camel@ADMIN>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I've got a really big problem with kernel 2.4.18 and 2.4.17 on
an Alpha.

I can compile, install and boot the kernel on my Alpha.
But if I shutdown the machine without shutting down the
system - I know this is crazy, but sometimes this happens...

So if I'm this mad and restart the machine afterwards, I get
a lot of fsck errors 'til the system give up and tell's me,
that I have to check it with fsck myself.

OK, I did so... fsck -y /dev/sda1 -> Works perfectly. After
fsck has corrected more than 1000 errors I'm able to
reboot the machine.

And than: MY SYSTEM IS NO LONGER BOOTABLE. It's totally
currupted...

I never saw the filesystem curruption bug on Intel, but it
sounds like this.

Is this the same bug that was on Intel?
Have I done something wrong?

Are there any alpha-users in this list? :o))))

Greetz, I look forward for answers,
 Oliver


