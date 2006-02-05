Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWBEVJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBEVJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWBEVJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:09:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42925 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750729AbWBEVJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:09:42 -0500
Date: Sun, 5 Feb 2006 22:09:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@mbligh.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: open bugzilla reports
Message-ID: <20060205210912.GA3509@elf.ucw.cz>
References: <20060203151150.3d9aa8b3.akpm@osdl.org> <20060204095023.GA11140@flint.arm.linux.org.uk> <20060204084729.defc7c19.mbligh@mbligh.org> <20060204231425.GA24887@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204231425.GA24887@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 04-02-06 23:14:26, Russell King wrote:
> On Sat, Feb 04, 2006 at 08:47:29AM -0800, Martin J. Bligh wrote:
> > 
> > > > [Bug 5958] CF bluetooth card oopses machine when
> > > > 	http://bugzilla.kernel.org/show_bug.cgi?id=5958
> > > 
> > > This isn't a serial bug - it's a bluetooth ldisc bug.  I reported it
> > > to the bluetooth folk back when it first got raised by Pavel.  However,
> > > they seem to be completely disinterested in fixing it.
> > > 
> > > Unfortunately, there isn't a category for bt crap in bugzilla, otherwise
> > > I'd reassign it.  Please kick the bt folk.
> > 
> > Stick it under Drivers/Other if you want ...
> 
> It _is_ under Networking/Other, yet akpm still thinks it's a serial
> bug.  I'm not sure why though, I've fully explained why it isn't
> a serial problem in the bug comments.
> 
> akpm is buggy and needs fixing.  Where do I file this bug? 8)

It would be nice to create Networking/Bluetooth category, so there's
logical place to file such bugs under...
								Pavel
-- 
Thanks, Sharp!
