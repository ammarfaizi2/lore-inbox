Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275120AbTHAGZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275122AbTHAGZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:25:58 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:32993 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S275120AbTHAGZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:25:55 -0400
Date: Fri, 1 Aug 2003 08:25:50 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test2-mm2 Still No Penguin Logo
Message-ID: <20030801062550.GD21437@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030801005737.72096.qmail@web13301.mail.yahoo.com> <200308010124.01632.gene.heskett@verizon.net> <20030801060600.GB21437@charite.de> <3F2A064F.3070609@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2A064F.3070609@longlandclan.hopto.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stuart Longland <stuartl@longlandclan.hopto.org>:

> | Same here. I have all the logo options activated, yet I only get a
> | black bar on top of the screen when booting with a fraembuffer console.
> |
> 
> I've had it work on my main machine, which uses the Radeon framebuffer,
> but on my laptop, which uses the VESA framebuffer, I get the same thing.

I use the neofb (see my bugreport about various issues with that beast).

> I might try again later using the NeoMagic framebuffer and see if the
> fault still exists.  If it works on the laptop using the neomagic
> framebuffer, that might point to a problem with the VESA driver.

Sounds interesting!

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
