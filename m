Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUGZNov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUGZNov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUGZNov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:44:51 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26564 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265359AbUGZNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:43:32 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 15:53:09 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <4104E863.6070102@kolivas.org> <4104EF5F.9070405@yahoo.com.au>
In-Reply-To: <4104EF5F.9070405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407261553.09594.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 of July 2004 13:47, Nick Piggin wrote:
> Con Kolivas wrote:
> > Nick Piggin wrote:
> >> Con Kolivas wrote:
> >>> In my ideal, nonsensical, impossible to obtain world we have an
> >>> autoregulating operating system that doesn't need any knobs.
> >>
> >> Some thinks are fundamental tradeoffs that can't be autotuned.
> >>
> >> Latency vs throughput comes up in a lot of places, eg. timeslices.
> >>
> >> Maximum throughput via effective use of swap, versus swapping as
> >> a last resort may be another.
> >
> > As I said... it was ideal, nonsensical, and impossible. Doesn't sound
> > like you're arguing with me.
>
> No, you're right. My ideal operating system knows what the user
> wants too ;)

Well, what I hate about various computer programs is that they seem to assume 
to know what I (the USER) want and they don't let me do anything else that 
they "know" what I should/would do. ;-)

> Most of the time though, you are right. The quality/desirability of an
> implementation will be inversely proportional to the number of knobs
> sticking out of it (with bonus points for those that are meaningful to
> 2 people on the planet).

Can you please tell me why you think that the least tunable implementation 
should be the best/most desirable one?  I always prefer the most tunable 
implementations which is quite opposite to what you have said, but this is my 
personal opinion, of course.

Yours,
rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
