Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287342AbSACPv0>; Thu, 3 Jan 2002 10:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287341AbSACPvS>; Thu, 3 Jan 2002 10:51:18 -0500
Received: from svr3.applink.net ([206.50.88.3]:26896 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287342AbSACPvH>;
	Thu, 3 Jan 2002 10:51:07 -0500
Message-Id: <200201031550.g03FoeSr025794@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Daniel Phillips <phillips@bonn-fries.net>, timothy.covell@ashavan.org,
        Jonathan Amery <jdamery@chiark.greenend.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Date: Thu, 3 Jan 2002 09:46:57 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu> <200201022021.g02KL8Sr021924@svr3.applink.net> <E16LzQ6-00011Q-00@starship.berlin>
In-Reply-To: <E16LzQ6-00011Q-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 22:23, Daniel Phillips wrote:
> On January 2, 2002 09:17 pm, Timothy Covell wrote:
> > On Wednesday 02 January 2002 11:17, Jonathan Amery wrote:
> > > In article <3C2315D6.40105@purplet.demon.co.uk> you write:
> > > >Engineers not (yet) being familiar with the relatively new SI (and
> > > > IEEE) binary prefixes is just about acceptable. "Engineers" that
> > > > misuse k/K and (worse!) m/M should be in a different field entirely.
> > > > The SI system is generally taught as basic science to pre-teenagers.
> > > > There is no excuse!
> > >
> > >  How many of them learn it though?
> > >
> > >  Jonathan (occasionally guilty of s/kB/KB/ himself).
> >
> > For the 10th time, the K v. k issue is due to the standards
> > body ignoring common sense and following tradition instead.
> > All positive powers of ten should have upper-case letters
> > 	(D,H,K,M,T,P)
> > and negative powers of ten should use lower-case letters.
> > 	(d,c,m,n,p)
>
> So if the box says '16 mB' flash, that's 16 millibytes, right?

Of course that's what it should mean, but obviously the folks
who packaged it were not too up on things.  And, let's face
the music here, if we as group of supposedly smart people
can't come close to reaching any consensus, can we blame
marketing folks for mislabeling something???

>
> > The KB meaning 2^10 B instead of 10^3 B is just plain dumb,
> > and that's why the standards body tried to fix it with KiB.
> > But again, this solution was considered to look and sound
> > goofy and to be based on stupid mathematical games;
> > hence this whole long thread.   <rant>A thread which has shown
> > to me that most comp. sci. folks lack common sense and
> > are pendantic to the max.</rant>
>
> Yes, true, and?

Sorry, I was feeling frustrated and should've kept that internal.
<rant>
But the fact is that I've presented what I think are good arguments
on how to "fix" things in a rational and _consistant_ manner.  
That is the point of metrics after all, to have a simple, rational,
and consistant set of units of measurement to replace the
inconsistant units that were previously used.   If we can't do
this, then there is no point in converting.   Americans are right
to continue using English/America/Imperial units if even the
so called cognescenti can't get metrics right.
</rant>

-- 
timothy.covell@ashavan.org.
