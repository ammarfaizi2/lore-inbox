Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWJEOEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWJEOEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWJEOEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:04:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:263 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751209AbWJEOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:04:13 -0400
Date: Thu, 5 Oct 2006 16:04:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1: known regressions
Message-ID: <20061005140411.GH16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005042816.GD16812@stusta.de> <1160023503.22232.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160023503.22232.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:45:03PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
> > Contrary to popular belief, there are people who test -rc kernels
> > and report bugs.
> > 
> > And there are even people who test -git kernels.
> > 
> > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you was declared guilty for a breakage or I'm considering you in any
> > other way possibly involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> 
> Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
> yet.
>...

Thanks, added.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

