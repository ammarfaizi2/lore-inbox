Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275389AbTHITgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275391AbTHITgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:36:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20166 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275389AbTHITgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:36:45 -0400
Date: Sat, 9 Aug 2003 21:36:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: spse@secret.org.uk, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030809193638.GL16091@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <1060452295.29776.1.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060452295.29776.1.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 07:04:55PM +0100, David Woodhouse wrote:
> On Sun, 2003-07-27 at 16:31, Adrian Bunk wrote:
> 
> > A first patch is at
> >   http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0770.html
> > 
> > I'll send an updated patch against -test2 or -test3.
> 
> Please don't make blkmtd depend on CONFIG_BROKEN. Its maintainer sent a
> patch to Linus recently -- further resends seem to be required.

If it will be merged, my CONFIG_BROKEN patch will be merged soon before 
2.6.0 and it seems that's still a few months from now. When I'll resend 
the next version I'll double-check that all BROKEN drivers are still 
broken.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

