Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTAUGew>; Tue, 21 Jan 2003 01:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbTAUGew>; Tue, 21 Jan 2003 01:34:52 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:32293 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265126AbTAUGev>; Tue, 21 Jan 2003 01:34:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Bisping <rbisping@mindspring.com>
Reply-To: rbisping@mindspring.com
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Fwd: belkin f5u022 pcmcia usb card
Date: Tue, 21 Jan 2003 01:36:20 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18as8b-0001FS-00@tisch.mail.mindspring.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: belkin f5u022 pcmcia usb card
Date: Mon, 20 Jan 2003 18:33:21 -0500
From: Robert Bisping <rbisping@mindspring.com>
To: debian-laptop@lists.debian.org

I am having problems getting this card to work on my thinkpad 760ED
I keep getting No IRQ known for interrupt pin A of device 04:00.0 Please try
using pci=biosirq

I have found out that the card does work under linux and it is supposed to
use IRQ 11 but how do I get it to set pin A to IRQ 11?

also what exactly is it refering to pci=biosirq where would I use that?
i have tried to use it in boot up but it does not seem to have any affect
unless I am using it wrong. if it supposed to be in a config file I need to
kow which one and where it should be put. if i need to RTFM i need to kow
which one to look at cause none of them seem to be helping. Thanx for your
assistance

Robert

added notes for kernel mailing list.
I am using 2.4.18 kernel I have recompiled multiple times trying to find what 
might be causing this and if i need to send my kernel parameters I can.  In 
the pcmcia-cs on sourceforge I was told i would probably have to ask here as 
this is handled by the yenta driver in the kernel.

thanx

