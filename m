Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312853AbSDCBPE>; Tue, 2 Apr 2002 20:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312871AbSDCBOy>; Tue, 2 Apr 2002 20:14:54 -0500
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:40630 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S312853AbSDCBOl>; Tue, 2 Apr 2002 20:14:41 -0500
Message-ID: <001f01c1daad$be80e440$1fe03218@clvhoh.adelphia.net>
From: "Jeffrey Folkman" <jmfolkman@adelphia.net>
To: <linux-kernel@vger.kernel.org>
Subject: Procomp BVK1A mainboard 
Date: Tue, 2 Apr 2002 20:20:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What follows is the text of an e-mail that you wrote in 2001.  I have the
same problem. Did anyone offer you any solutions or have you discovered a
solution?  All help would be much appreciated.

Thank you,

Jeffrey Folkman
jmfolkman@adelphia.net


Hello,

My system has a Procomp BVK1A mainboard sporting one of those dreaded =
VIA KX133 chipsets. I have been a virtual lurker, monitoring the =
archives, and have heard plenty of horror stories about this chipset, =
but let me make clear that this board was rock-solid for the better part =
of a year. It would go for weeks without a power-off or reboot. People =
would look at me funny, and ask, "Doesn't your computer *crash*?" (Of =
course not; it runs Linux!)

Then, a couple of months ago, I installed 2.4.4. And that, as Stevie B. =
once said, was where the heartache began.

Every time I use X, given sufficient time (between 15 minutes and 24 =
hours), the system would freeze. Solid. I haven't tried the Magic SysRq =
key, but heck, my CapsLock won't even go on and off. Usually it takes a =
while but the problem seems to be exacerbated by heavy-load, =
graphics-intensive applications (GIMP and Mozilla come to mind). Console =
mode seems to run okay, but in the Real World sometimes a GUI is =
necessary.

That's not the half of it. Sometimes, Windows freezes in identical =
fashion. I've even experienced it occasionally under NetBSD, but that =
usually takes quite a long while. I've tried 2.4.4, 2.4.5, several AC =
patches to 2.4.5, then I went back and tried 2.4.1. I've compiled it for =
an Athlon, a PII, a Pentium, and a 486. I suspected the AGPGART and DRI =
drivers and so I unloaded those as well. I'm typing this message to you =
under kernel 2.2.19. I am still experiencing freezes. Remember, this box =
was incredibly stable before 2.4.4 and I really don't want to give up =
this mainboard and CPU; it's got some nice things (like 2 serial ports!) =
that are hard to find anymore.

The CPU is not overclocked and I have ruled out cooling problems (the =
fans hum nicely at top speed). I was wondering if anyone knew what's =
going on, and if there's some patch I need to apply. Did I tickle some =
sort of schroedinbug in the chipset that was kind of hiding there, =
waiting to make things fail? If anyone has any answers, please CC me =
personally. Thanks for all your time and patience.
--=20

