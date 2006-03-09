Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWCILdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWCILdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWCILdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:33:09 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:10880 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750717AbWCILdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:33:08 -0500
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
From: Kasper Sandberg <lkml@metanurb.dk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Maier <Thomas.Maier@uni-kassel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060308122500.GB3274@elf.ucw.cz>
References: <200603071005.56453.nigel@suspend2.net>
	 <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de>
	 <20060308122500.GB3274@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 09 Mar 2006 12:33:10 +0100
Message-Id: <1141903990.1745.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:25 +0100, Pavel Machek wrote:
> On Út 07-03-06 14:14:00, Thomas Maier wrote:
> > Hi Nigel,
> > 
> > congratulations and all the best, although this sounds like a sad
> > goodbye and resignation.  I always hoped for inclusion in mainline and
> > followed the "discussions" on lkml, although Pavel never made an effort
> > to hide his ignorant arrogance.  
> 
> At least you can't say I was dishonest :-/.
> 
> > Mainline swsusp never worked for me and
> > so with you leaving I am tempted to leave Linux behind after more than
> > ten years and switch to that other OS that at least has working suspend
> > and resume.  
didnt work on my laptop either, or one of my friends where i tried..
however, swsusp2 does..

> 
> Your choice... But it would be more productive to read the docs, go to
> the latest kernel, and if it does not work there, file
> bugzilla.kernel.org report.
yeah well.. IMO merging suspend2 is more productive, as i see it, it has
no downsides as to software suspend as of now, except IA64 support, and
it has ALOT of upsides.
> 
> [stripped suspend2 lists -- I guess that's offtopic there.]
> 								Pavel

