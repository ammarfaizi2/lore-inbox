Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264721AbSJUDnt>; Sun, 20 Oct 2002 23:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264720AbSJUDns>; Sun, 20 Oct 2002 23:43:48 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:28312 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264717AbSJUDnk> convert rfc822-to-8bit; Sun, 20 Oct 2002 23:43:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: nwourms@netscape.net, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.44 - and offline for a week
Date: Sun, 20 Oct 2002 17:49:41 -0500
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0210182117500.12531-100000@penguin.transmeta.com> <aorjq3$3dm$1@main.gmane.org>
In-Reply-To: <aorjq3$3dm$1@main.gmane.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201749.41625.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 07:41, Nicholas Wourms wrote:
> Linus Torvalds wrote:
> > Ok, I've merged stuff from more people, and 2.5.44 is out there. We're
> > getting closer, folks.
> >
> > And for the ext 8 days (starting _now_) it is totally unnecessary to try
> > to send me patches or cc me on the discussions about what needs to be
> > merged or not. I won't read it, and when I get back I will likely just
> > flush the whole inbox, since there's no way I can try to catch up _and_
> > try to merge some final pieces before the feature freeze at the same
> > time.
>
> Perhaps this is good reason to delay the freeze for an additional 2 weeks
> or so?

No, it isn't.

> I fail to see the necessity of rushing into a freeze,

The freeze date freeze was set and publicized more than 6 months ago.  Define 
"rushing".

> especially
> when it seems obvious that people are trying to merge code which hasn't
> been adequately tested.

There will always be code that's not ready before the freeze, and that won't 
make it in.  If this wasn't the case, there wouldn't be a need for a cutoff 
date, would there?  "Oh, development is over, there are no more interesting 
new patches anywhere, we can all go home now."  Doesn't happen.

Thawing the freeze won't help.  As time approaches zero, effort approaches 
infinity.  (Remember college?  How many papers did you hand in BEFORE they 
were due?)

Meaningful deadlines have a nice motivating effect.  Endless extensions are 
just sloppy.

>  I think Hans Reiser and others have brought up
> valid points that the freeze is happening too soon.  I tend to agree,
> especially looking back at the timetable surrounding 2.1.X development. 

2.1.X had a timetable?

(I mean, retroactively it had a time table, sure.  But are you implying there 
was some sort of planned schedule anybody paid attention to at the time?  I 
must have missed it.  There was a lot of "we really mean it this time, 
honestly", and "just this once, but don't do it again".  But I don't remember 
anybody actually paying attention after the first couple of times...)

> Since I'm not a contributor, I know my opinion doesn't count for much. 
> Still, as a user I think it is important not to write of new features just
> because they didn't make the "arbitrary" freeze date.  Again, I really
> don't see what the rush is all about.

Who says anything about writing off features?  3.0 isn't the end of the world.  
The kernel team is trying to get it out now so people don't have to wait 
another year or more to use the new features that have ALREADY gotten in.

With a snappy enough cycle time, it's possible to get this stable series into 
the hands of users, open the next development branch, and have that one 
stabilised and released before a traditional "two years plus" development 
cycle like 2.3 or 2.1 would get to its FIRST dot-0 release (with the 
obligatory brown paper bag bugs, since it's been so long since anybody 
actually used the thing in production..).

Slowing down the development cycle does not speed the introduction of 
features.  Really.

Rob
