Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270523AbRHSOnk>; Sun, 19 Aug 2001 10:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270520AbRHSOnb>; Sun, 19 Aug 2001 10:43:31 -0400
Received: from mailgw3.netvision.net.il ([194.90.1.11]:56495 "EHLO
	mailgw3.netvision.net.il") by vger.kernel.org with ESMTP
	id <S270519AbRHSOnP>; Sun, 19 Aug 2001 10:43:15 -0400
From: "Ori Hanegby" <ori@exanet.com>
To: "'RAPHEAD'" <raphead@dimensions.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: System Freeze after booting the kernel
Date: Sun, 19 Aug 2001 17:42:05 +0200
Message-ID: <000001c128c5$7ff4c2e0$54f5fea9@exanet>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <01081911514000.00854@raphead>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you use LILO?
What you describe happens if you replace the image file but don't run "lilo"
again.
check that you haven't forgot that bit :)

Ori


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of RAPHEAD
Sent: Sunday, August 19, 2001 11:52 AM
To: linux-kernel@vger.kernel.org
Subject: System Freeze after booting the kernel


--->My Hardware:

P200, 128 Meg Ram, 128 KB Cache on a SuperMicro Board.
Seagate IDE Drive with 13Gig


--->Detailed Report

[1.] Linux freezes after Uncompressing Linux... OK, booting the kernel (no
numlock posssible)

[2.] Wheter I boot with initrd or without, with incompiled reiserfs or as
module or in the initrd I've tried everything
the system freezes after the above given line. I've the same system as
desktop system (the problem occurs on the 'server')
which works fine (Celeron 400 on a Siemens Board with BX440 Chipset, SCSI,
197 Meg RAM)

So what can I do?


