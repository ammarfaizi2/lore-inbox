Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTG0PQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTG0PQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:16:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47050 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270831AbTG0PQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:16:10 -0400
Date: Sun, 27 Jul 2003 17:31:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030727153118.GP22218@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 08:20:44AM -0400, Robert P. J. Day wrote:
> 
>   i've mentioned this before, but in a perfect world, should it
> be possible to build a release version of the kernel with
> "make allyesconfig".  this is generally not possible, since there's
> always the occasional broken driver that just won't compile.
> 
>   more to the point, there are drivers that seem to be perpetually
> broken.  as an example, the riscom8 driver has been borked for as 
> long as i can remember.  at some point, shouldn't something like
> this either be fixed or just removed?  what's the point of 
> perpetually bundling a driver that doesn't even compile?

A first patch is at
  http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0770.html

I'll send an updated patch against -test2 or -test3.

Ideally, these drivers will be fixed during 2.6 when more people start 
using 2.6...

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

