Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTKTWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTKTWyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:54:43 -0500
Received: from gprs147-68.eurotel.cz ([160.218.147.68]:49536 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263102AbTKTWyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:54:33 -0500
Date: Thu, 20 Nov 2003 23:55:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: driver model for inputs
Message-ID: <20031120225504.GG196@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com> <20031120222825.GE196@elf.ucw.cz> <55080000.1069368524@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55080000.1069368524@w-hlinder>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> tree.  Hanna Linder is working on the input sysfs patches, and has
> >> posted some work in the past.
> > 
> > I could only find 2.5.70 patches, and those did not seem "good enough"
> > to do power managment with them. Do you have some newer version?
> > 
> > [One of machines near me needs keyboard to be reinitialized after S3
> > sleep... And users are starting to hit that, too.]
> 
> I have test8 version of the patch which mostly works. The only problem now
> is a panic when I remove the mouse... The input layer is sorta hard to follow
> you know :) Im guessing it is a reference counting issue. Do you want what I
> have now or can I update it to test9 and see if taking a break from staring
> at it has helped?

If you could post -test8 version, that would be great.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
