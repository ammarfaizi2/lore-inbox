Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTHYDaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTHYDaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:30:14 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:4758 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261465AbTHYDaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:30:06 -0400
Date: Mon, 25 Aug 2003 04:57:52 +0200 (CEST)
From: Aschwin Marsman <aschwin@marsman.org>
X-X-Sender: marsman@localhost.localdomain
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3+bk: ACPI does not switch off the computer (retry)
Message-ID: <Pine.LNX.4.44.0308250457120.1837-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Retry, the message I sent yesterday didn't appear on the list.

On Sun, 24 Aug 2003, Alex Riesen wrote:

> Aschwin Marsman, Sun, Aug 24, 2003 08:35:52 +0200:
> > On Fri, 22 Aug 2003, Alex Riesen wrote:
> > > Actually it started happening from -test3.
> > > The last I see on screen is "Power down." and the system is halted.
> > > CAD reboots it.
> > 
> > The latest acpi disables acpi for all bioses before Januari 1st 2001,
> > I have the same problem with 2.4.22-rc3. It was "solved" by adding:
> > acpi=force
> > to my kernel boot parameters. In /var/log/messages this hint is
> > given if that's the case.
> >  
> 
> Thank you, this is indeed the case. Somehow I didn't notice the messages
> in the syslog.
> 
> Can't say I like that decision: acpi always worked here, at least as far
> as power off was concerned.

I totally agree, but then again, I don't know the details.

> May it make sense to let the parts working for every vendor enabled?
> 
> P.S. Motherboard is ASUS CUV4X, Via Apollo PRO133Z.

My motherboard is a ASUS CUBX-L, Intel 440BX, I only use powerdown (that 
I'm aware of).
 
Have a nice weekend.
 
Aschwin Marsman
 
--
aschwin@marsman.org              http://www.marsman.org


