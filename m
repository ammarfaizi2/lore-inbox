Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314398AbSD0TAn>; Sat, 27 Apr 2002 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSD0TAm>; Sat, 27 Apr 2002 15:00:42 -0400
Received: from CPE0f1029959677.cpe.net.cable.rogers.com ([24.100.146.229]:6409
	"HELO luna.sol.icu.on.ca") by vger.kernel.org with SMTP
	id <S314398AbSD0TAk>; Sat, 27 Apr 2002 15:00:40 -0400
From: "Gordon Gray" <gord@icu.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Motzilla crashes system
Date: Sat, 27 Apr 2002 15:00:39 -0400
Message-ID: <NABBKHMDBHEGCPLPEPAEIEIFEKAA.gord@icu.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bug you folks, but I appear to have multiple problems, one of which
sounds like a kernel problem.

I upgraded from RedHat 7.1 (2.2.19smp kernel) to redhat 7.2 (2.4.7-10smp).
I had some Ximian red carpet enhancements, and after the upgrade (and after
resolving some bios issues), I applied the upgrades recommended by ximian
red carpet.

2 bugs have made themselves visible to me.  First, cron emails me every 10
minutes telling me that /usr/lib/sa/sa1 1 1 "Cannot append to that file"
(what ever that file is).

The second problem (and more disturbing), is that when I run Netscape (as a
user, not as root) the entire system crashes (won't even answer to ping).
When I re-boot, grub no longer load and I have to re-install grub from the
distribution CD.  What is most troubling, is that everything in my /boot
partition is write protected to all but root.  So how can a user application
change anything in there?

I realize I have probably not given you enough info, but I am not
experienced enough to know what info would be useful, nor how to find much
of anything.

If I am directing this question to the wrong place, please accept my
apologies, and just point me in the right direction.

I thank you for any help you can offer.

Gordon Gray.

