Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbTCNTag>; Fri, 14 Mar 2003 14:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263474AbTCNTag>; Fri, 14 Mar 2003 14:30:36 -0500
Received: from poup.poupinou.org ([195.101.94.96]:55341 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S263473AbTCNTaf>; Fri, 14 Mar 2003 14:30:35 -0500
Date: Fri, 14 Mar 2003 20:40:50 +0100
To: Valdis.Kletnieks@vt.edu
Cc: Bongani Hlope <bonganilinux@mweb.co.za>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 XFree and nvidia geforce.
Message-ID: <20030314194050.GA8814@poup.poupinou.org>
References: <3E70086B.6080408@lemur.sytes.net> <20030313201624.GA29107@suse.de> <Pine.LNX.4.51.0303132026210.24455@dns.toxicfilms.tv> <20030313231615.07563914.bonganilinux@mweb.co.za> <200303132155.h2DLtsRU015899@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303132155.h2DLtsRU015899@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:55:54PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 13 Mar 2003 23:16:15 +0200, Bongani Hlope said:
> 
> > If you don't inteand to run 3d applications, then you don't need the
> > nvidia drivers (both for 2.4 and 2.5), but if you want 3d acceleration,
> > the you best bet is 2.4 + nvidia
> 
> For reasons I don't claim to understand, the nvidia drivers have much
> better 2D acceleration as well.  And with the patches from www.minion.de
> they work acceptably under 2.5.64, modulo a few issues:
> 
> At least on my Dell laptop (GeForce 440 2Go), the 'GLX' extension will wedge up
> the X server (ctl-alt-del still reboots, so the kernel is still there).
> 
> Restarting the X server hangs the machine sometimes.
> 
> I'm going to take a shot at debugging those two issues now that my office is
> remodelled and I have a fighting chance of hooking something to the serial
> port for debugging. ;)
> 

One of the main issue for me (I don't want flame please) is
that it kill acpi and/or apm.  Since it's more important for
for me to get suspension working, I can not use any
 drivers provided by nVidia unless of course they implement
necessary support.

BTW, XFree4.3.0 is out, and your GeForce is supported.


-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
