Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUGKOHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUGKOHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 10:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUGKOHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 10:07:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59660 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266599AbUGKOHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 10:07:12 -0400
Date: Sun, 11 Jul 2004 10:07:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Hisaaki Shibata <shibata@luky.org>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Genesys Logic and Kernel 2.4
In-Reply-To: <20040711.052727.607952779.shibata@luky.org>
Message-ID: <Pine.LNX.4.44L0.0407111005490.8383-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Hisaaki Shibata wrote:

> Hi Alan,
> 
> I have just subscribed Linux-usb-users tonight.
> 
> I found your message
> > Re: [Linux-usb-users] Genesys Logic and Kernel 2.4
> on the web.
> 
> > > I have a USB-IDE-Enclosure using the buggy Genesys chipset. My system
> > > has a 2.4 kernel and I cannot update soon for various reasons.
> 
> I maybe have almost the same enclosure using Genesys chip.
> 
> > I backported the 2.6 patch to 2.4.27, but I haven't tried compiling it so 
> > there might be an error or two lurking.  Please try it out and tell us 
> > if it works.
> 
> I tried following patch with a little change.

...

> Before I patched the kernel, I met many errors and hangups
> with big files writing into the enclosure.
> 
> After with your patch, It works fine for me.
> 
> My kernel is linux-2.4.27-rc3 with video4linux2 patch.
> HDD in the enclosure is HGST Deskstar 7K250.
> 
> Just a report.
> 
> Best Regards,
> Hisaaki Shibata

Thanks for testing, and thanks for the correction.  I'll submit the 
corrected patch for inclusion in 2.4.

Alan Stern

