Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVB1OEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVB1OEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVB1ODh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:03:37 -0500
Received: from gprs215-69.eurotel.cz ([160.218.215.69]:31619 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261623AbVB1ODU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:03:20 -0500
Date: Mon, 28 Feb 2005 12:37:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Update suspend-to-RAM vs. video documentation
Message-ID: <20050228113734.GA1312@elf.ucw.cz>
References: <20050228012218.GA2014@elf.ucw.cz> <1109565762.16374.9.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109565762.16374.9.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A few corrections, nothing major.

Thanks a lot, applied.

> > +eMachines athlon64 machines	vbetool needed (6) (someone please get me model #s)
> > +HP NC6000			s3_bios, may not use radeonfb (2)
> > +HP NX7000			??? (*)
> > +HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
> > +HP Omnibook XE3	  		none (1)
> 
> Which XE3? My 4304 revision with an i830 video card doesn't meet this
> category.

I had XE3 with athlon 900. i830 sounds like Intel version;
unfortunately HP marked them almost the same way.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
