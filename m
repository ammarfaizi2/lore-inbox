Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWG3VC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWG3VC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWG3VC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:02:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:55452 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932297AbWG3VC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:02:26 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Rene Rebe <rene@exactcode.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <200607302209.09735.rene@exactcode.de>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <200607301937.15414.rene@exactcode.de>
	 <1154282618.13635.41.camel@localhost>
	 <200607302209.09735.rene@exactcode.de>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 23:02:13 +0200
Message-Id: <1154293333.13635.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 22:09 +0200, Rene Rebe wrote:
> HI,
> 
> On Sunday 30 July 2006 20:03, Kasper Sandberg wrote:
> 
> > > it would be totally ok if the kernel had a country= command line switch
> > > and the driver limitting functionality due that.
> > or simply state this in the help in Kconfig?
> > > 
> > > People that want to violate the local regulations would require to lie to
> > > the kernel as they could install other country windows and drivers as
> > > well.
> > besides, im not even sure that specifying in Kconfig is necessary,
> > wouldnt it only be illegal in countries, if people actually modified the
> > source?
> 
> I proposed a kernel command so distributors have a way to run-time
> change this.
> 
> However now that I think about it a bit more, a simple sysfs attribute
> would be way more useful so the gui tool of the the distribution can
> switch the country immediatly and do not require a windows-al-like reboot.
> 
or perhaps people should just not install/use stuff illegal in their
country.

> Yours,
> 

