Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284415AbRLDAUs>; Mon, 3 Dec 2001 19:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284924AbRLDASY>; Mon, 3 Dec 2001 19:18:24 -0500
Received: from dsl-213-023-038-044.arcor-ip.net ([213.23.38.44]:40719 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284550AbRLCNS3>;
	Mon, 3 Dec 2001 08:18:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Subject: Re: Coding style - a non-issue
Date: Mon, 3 Dec 2001 14:20:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Larry McVoy <lm@bitmover.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011130200239.A28131@hq2> <E16AhO2-0000C2-00@starship.berlin> <20011203050410.D16148@hq2>
In-Reply-To: <20011203050410.D16148@hq2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16At1U-0000GF-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 3, 2001 01:04 pm, Victor Yodaiken wrote:
> On Mon, Dec 03, 2001 at 01:55:08AM +0100, Daniel Phillips wrote:
> > I'm sure Linus does have quite considerable talent for design, but I haven't 
> > seen him exercise it much.  Mostly he acts as a kind of goodness daemon, 
> > sitting in his little pinhole and letting what he considers 'good' stuff pass 
> > into the box.  There's no doubt about it, it's different from the way you 
> > like to develop, you and me both.  Equally clearly, it works pretty well.
> 
> This is a good explanation of why Linux may fail as a project, but it is
> pure fantasy as to how it has so far succeeded as a project. 
> 
> The tiny part of system I wrote directly and the larger part that
      ^^^^^^^^^
> I got to see up close involved a great deal of design, old fashioned 
> careful engineering, and even aesthetic principles of what wasgood
> design. 

You're just supporting the point of view that Linus has been espousing, and 
I personally support:  Linux is engineered at a micro level[1] but evolves
on its own at a macro level.

Sure, Linux evolves with help from Linus, but he acts as a filter, not a 
designer.  When Linus does on rare occasions forget himself and actually 
design something, its micro-engineering like you or I would do.  So if Linux 
is designed, who does do the designing, can you name him?  I can tell you for 
sure it's not Linus.

> Don't drink the cool aid. Go back and look in the kernel archives and 
> you will see extensive design discussions among all the core developers.
> Linus has a point about the development of Linux not being in
> accord with some master plan (at least not one anyone admits to) , but 
> that's about as far as it goes.

Don't worry about me drinking the cool aid, first I already drank it and 
second I'm personally already fully devoted to the notion of design process, 
including all the usual steps:  blue sky, discussion, requirements, data 
design, detail design, prototype, etc. etc.  You'll find the 'paper trails' 
in the archives if you've got the patience to go spelunking, and you'll have 
a hard time finding one of those designs that became a dead end.  This design 
thing does work for me.  It doesn't change the fact that what I'm doing is 
micro-engineering.

I'll get really worried if Linus wakes up one day and decides that from now 
on he's going to properly engineer every aspect of the Linux kernel.  The 
same way I'd feel if Linux got taken over by a committee.

--
Daniel

[1] In places.  All those little warts and occasional pools of sewage are 
clearly not 'engineered'.
