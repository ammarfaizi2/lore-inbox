Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265264AbRF0FXt>; Wed, 27 Jun 2001 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbRF0FXk>; Wed, 27 Jun 2001 01:23:40 -0400
Received: from ns.asml.nl ([195.109.200.66]:13808 "EHLO pollux.asml.nl")
	by vger.kernel.org with ESMTP id <S265264AbRF0FXc>;
	Wed, 27 Jun 2001 01:23:32 -0400
From: Tim Timmerman <Tim.Timmerman@asml.com>
Message-ID: <15161.28095.801407.427346@asml.nl>
Date: Wed, 27 Jun 2001 07:23:11 +0200
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
X-Mailer: VM 6.90 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "kees" == kees  <kees@schoen.nl> writes:

kees> Hi,

kees> I tried 2.4.5 but after a couple of hours I lost all network
kees> connectivety.  The log shows:
<snip>
	Can I just add a me too here ?

	System: Abit BP6, Dual Celeron, Ne2k-pci, usb ohci and
	scanner; 128 Mb Ram, Nvidia TNT2 graphics. Kernel 2.4.5

	After scanning a couple of images (scanner is a Mustek 1200cu)
	using Xsane, the system simply hangs. All network connectivity
	dies, and the system basically stops responding. I can switch
	consoles, and maybe log in[1], but that's basically it.

	Debugging this is a bit beyond me, but it is fairly
	reproducible, so let me know what I need to do to provide
	useful information (The system is not critical, though I'd
	prefer not to break it)

	Sorry, no logs.. 

	TimT. 
	
[1] /var/spool/mail is NFS mounted, so a check for mail times out. 

-- 
tim.timmerman@asml.nl                              040-2683613
timt@timt.org   Voodoo Programmer/Keeper of the Rubber Chicken
I've been doing a lot of abstract painting lately, extremely
abstract. No brush, no paint, no canvas, I just think about it. 

