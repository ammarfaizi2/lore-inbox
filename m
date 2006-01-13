Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWAMMKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWAMMKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWAMMKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:10:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29391 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932715AbWAMMKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:10:10 -0500
Date: Fri, 13 Jan 2006 13:09:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Place for userland swsusp parts
Message-ID: <20060113120958.GJ10088@elf.ucw.cz>
References: <20060111221511.GA8223@elf.ucw.cz> <200601122113.24461.rjw@sisk.pl> <20060113002138.GE10088@elf.ucw.cz> <200601131225.51635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601131225.51635.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > IMHO uswsusp.sf.net would be too similar to swsusp.sf.net, especially that
> > > swsusp.sf.net is redirected to www.suspend2.net.
> > 
> > Or maybe we can get hosting on suspend2.net? Or create
> > userswsusp.sf.net (that name is ugly :-().
> 
> suspend.sf.net seems to be available.  We can use it, I think.

Ok. <evil>Or we can register suspend2.sf.net, and manage exchange for
swsusp.sf.net :-)))))</evil>

> > ...some revision control would be nice, but perhaps revision control
> > is enough and we can just put git tree on kernel.org?
> 
> IMHO quilt will suffice to manage patches, at least for starters, but we'll
> need a mailing list and an intro web page.

Well, we'll just get the kernel patch merged, so I don't see a need
for quilt. But we'll need some CVS/SVN/something for userland parts.

Do you want to register suspend.sf.net, or should I do it?
								Pavel
-- 
Thanks, Sharp!
