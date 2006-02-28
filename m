Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWB1Whi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWB1Whi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWB1Whi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:37:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52710 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932653AbWB1Whh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:37:37 -0500
Date: Tue, 28 Feb 2006 23:37:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: col-pepper@piments.com
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-ID: <20060228223710.GB5831@elf.ucw.cz>
References: <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca> <1141048228.2992.106.camel@laptopd505.fenrus.org> <1141049176.18855.4.camel@imp.csi.cam.ac.uk> <1141050437.2992.111.camel@laptopd505.fenrus.org> <1141051305.18855.21.camel@imp.csi.cam.ac.uk> <op.s5ngtbpsj68xd1@mail.piments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.s5ngtbpsj68xd1@mail.piments.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I agree completely which is why we hack the system to remove the o_sync
> > on our distro derivative.  (-:
> >
> > But my point was that your solution of "don't do that then" is not much
> > use to your average user who sits in front of such distro in graphical
> > desktop as they are not technical enough to find and hack their hotplug
> > system to work properly...
> >
> > Best regards,
> >
> >         Anton
> 
> >> If you don't want it *DO NOT USE IT AT THE MOUNT COMMAND LINE* !!!
> 
> Yeah, cleaver.
> That is not really a constructive responce. I dont use , I do use command  
> line mount all the time. I never was in danger of damaging my drive with  
> this new "feature".
> 
> Telling a user who has just burnt out a brand new 1GB usb device he should  
> have RTFM and modified that HAL configuration to insure it did not use  
> sync it not likely to win much confidence in the linux kernel.

Return that 1GB usb device to manufacturer, it was broken.

> The point of raising this is that the vast majority of linux users have no  
> awareness of this. If there is a danger of this sync implementation  
> damaging hardware it should be done differently.

Fix the distribution, then.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
