Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277842AbRJ1Ipg>; Sun, 28 Oct 2001 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277833AbRJ1Ip0>; Sun, 28 Oct 2001 03:45:26 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:59876 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S277829AbRJ1IpQ>; Sun, 28 Oct 2001 03:45:16 -0500
Date: Sun, 28 Oct 2001 19:45:45 +1100
Message-Id: <200110280845.f9S8jjJ25269@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.LNX.4.33L.0110272259060.32445-100000@imladris.surriel.com>
In-Reply-To: <E15xaiJ-0001Na-00@localhost>
	<Pine.LNX.4.33L.0110272259060.32445-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Sat, 27 Oct 2001, Ryan Cumming wrote:
> 
> > It might be more productive to provide patches or at least generate
> > constructive ideas as how to fix these problems, as you are obviously
> > quite capable of doing so.
> 
> 1) yes, Al Viro is very capable of sending in devfs fixes
>    and he has done so in the past  (IIRC around 2 months ago)

A truely horrible, busy-wait patch that was quickly superceeded by a
much cleaner patch that I wrote shortly thereafter. And was applied by
Linus in due course.

> 2) Richard Gooch then told Al he'd just started working on
>    a patch to fix the problem and he'd rather fix things
>    himself ... as far as I can see this hasn't happened yet

Complete fucking bullshit. Over the last several months, I've been
sending a steady stream of bugfix patches to Linus and the list, and
if you'd been paying attention, you'd notice that in time they've been
applied.

Furthermore, I've nearly finished the big rewrite of devfs which adds
proper locking and refcounting. That work was progressing nicely (but
it's a big job), although it's temporarily stalled because of some
important travel. Work on that will resume in the next couple of
weeks. There's no point sending in an incomplete version of the code.

It's beyond me why you state that there has been no progress by me
when my announcements of new devfs patches have been posted to the
list and even Linus' ChangeLog messages have shown stuff going in. If
you don't actually know what's going on, why do you bother posting on
this subject in the first place? How would you like it if I started
flaming about how long the VM code was taking to get working? Our VM
has sucked for *years*.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
