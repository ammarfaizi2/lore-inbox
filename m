Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278710AbRJ1WbA>; Sun, 28 Oct 2001 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278708AbRJ1Wav>; Sun, 28 Oct 2001 17:30:51 -0500
Received: from mailin10.bigpond.com ([139.134.6.87]:5357 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S278703AbRJ1Wah>; Sun, 28 Oct 2001 17:30:37 -0500
Date: Mon, 29 Oct 2001 09:31:09 +1100
Message-Id: <200110282231.f9SMV9U26740@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110280348320.23288-100000@weyl.math.psu.edu>
In-Reply-To: <200110280845.f9S8jjJ25269@mobilix.atnf.CSIRO.AU>
	<Pine.GSO.4.21.0110280348320.23288-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 28 Oct 2001, Richard Gooch wrote:
> 
> > Complete fucking bullshit. Over the last several months, I've been
> > sending a steady stream of bugfix patches to Linus and the list, and
> > if you'd been paying attention, you'd notice that in time they've been
> > applied.
> 
> OK, _now_ I'm really pissed off.  As far as I can see there is only
> one way to get you fix anything - posting to l-k.  This "steady
> stream" consists of what?  Let's see:
[...]
> Oh, and before that we have a (finally, only after a year of mentioning
> the crap in question, heavy-weight rant on l-k when I've finally ran out
> of patience _and_ detailed discussion on the possible fixes) fix for
> expand-entry-table races.
> 
> So far all I see is that beating you hard enough in public can make
> you fix the bugs explicitly pointed to you.  That's it.  As far as I
> can see you don't read your own code, judging by the fact that every
> damn look at fs/devfs/base.c shows a new hole within a couple of
> minutes _and_ said holes stay until posted on l-k.  Private mail
> doesn't work.  You read it, reply and ignore.  About hundred
> kilobytes of evidence available at request.

You don't get to see the bug reports or questions I respond to which
are sent to me privately or on the devfs list (I know you're not
subscribed:-). And you seem to have forgotten that I've responded to
questions or bug reports *from you* that you send privately to me,
sometimes Cc:ed to Linus. I've even responded to questions that you've
placed in the code. So it's simply not true that I only respond if
beat upon in public. Progress *is* being made, irrespective of your
"input".

As for the recent bug reports, yes, I've just seen them. I'll respond
(not because you've been flaming about it on the list) later this week
once I clear through my email backlog which accumulated while I was
off the 'net for a week. Yeah, it does take time to wade through all
the email, especially when I get greeted with a huge pile of flames.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
