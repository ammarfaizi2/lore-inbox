Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWCIOzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWCIOzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWCIOzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:55:38 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:2182 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751508AbWCIOzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:55:37 -0500
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
From: Kasper Sandberg <lkml@metanurb.dk>
To: Pavel Machek <pavel@suse.cz>
Cc: Thomas Maier <Thomas.Maier@uni-kassel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060309114556.GE2813@elf.ucw.cz>
References: <200603071005.56453.nigel@suspend2.net>
	 <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de>
	 <20060308122500.GB3274@elf.ucw.cz> <1141903990.1745.5.camel@localhost>
	 <20060309114556.GE2813@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 15:55:44 +0100
Message-Id: <1141916144.1745.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 12:45 +0100, Pavel Machek wrote:
> > > > Mainline swsusp never worked for me and
> > > > so with you leaving I am tempted to leave Linux behind after more than
> > > > ten years and switch to that other OS that at least has working suspend
> > > > and resume.  
> > didnt work on my laptop either, or one of my friends where i tried..
> > however, swsusp2 does..
> 
> bugzilla IDs?
have none, and i know this is very bad, however i didnt feel like i had
any useful information to contribute, all i get is black screen, nothing
to syslog, i have no serial port on my laptop..
> 
> > > Your choice... But it would be more productive to read the docs, go to
> > > the latest kernel, and if it does not work there, file
> > > bugzilla.kernel.org report.
> > yeah well.. IMO merging suspend2 is more productive, as i see it, it has
> > no downsides as to software suspend as of now, except IA64 support, and
> > it has ALOT of upsides.
> 
> Except that suspend2 is not going to be merged, for variety of
> reasons. One of them is that noone is working on merging it...
> 
one of them being the operative word, afaik, nigel was unwilling to work
on the issues needed for merging for the reason that it wouldnt be
merged..

out of personal interrest, why is it that prevents suspend2 from being
merged?

> So yes, filling bugzilla entries would be more productive than flaming
> me.
my post wasnt flaming, and wasnt intended to do so either.
> 								Pavel

