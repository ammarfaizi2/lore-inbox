Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVJCBKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVJCBKz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJCBKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:10:55 -0400
Received: from free.hands.com ([83.142.228.128]:5575 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932103AbVJCBKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:10:54 -0400
Date: Mon, 3 Oct 2005 02:10:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003011041.GN6290@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <54300000.1128297891@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54300000.1128297891@[10.10.2.4]>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 05:04:51PM -0700, Martin J. Bligh wrote:
> --Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote (on Monday, October 03, 2005 00:05:45 +0100):
> 
> > On Sun, Oct 02, 2005 at 05:05:42PM -0400, Rik van Riel wrote:
> >> On Sun, 2 Oct 2005, Luke Kenneth Casson Leighton wrote:
> >> 
> >> > and, what is the linux kernel?
> >> > 
> >> > it's a daft, monolithic design that is suitable and faster on
> >> > single-processor systems, and that design is going to look _really_
> >> > outdated, really soon.
> >> 
> >> Linux already has a number of scalable SMP synchronisation
> >> mechanisms. 
> > 
> >  ... and you are tied in to the decisions made by the linux kernel
> >  developers.
> 
> Yes. As are the rest of us. So if you want to implement something 
> different, that's your perogative. So feel free to go do it 
> somewhere else, and quit whining on this list. 
> 
> We are not your implementation bitches. If you think it's such a great
> idea, do it yourself.
 
 martin, i'm going to take a leaf from the great rusty russell's book,
 because i was very impressed with the professional way in which he
 dealt with someone who posted such immature and out-of-line comments:
 he rewrote them in a much more non-hostile manner and then replied to
 that.

 so, here goes: i'm copying the above few [relevant] paragraphs
 below, then rewriting them, here:

> > 
> >  ... and you are tied in to the decisions made by the linux kernel
> >  developers.
> 
> Yes, this is very true: we are all somewhat at the mercy of their
> decisions.  However, fortunately, they had the foresight to work
> with free software, so any of us can try something different, if
> we wish.
>
> i am slightly confused by your message, however: forgive me for
> asking this but you are not expecting us to implement such a radical
> redesign, are you?

 martin, hi, thank you for responding.

 well... actually, as it turns out, the l4linux and l4ka people have
 already done most of the work!!

 i believe you may have missed part of my message (it was a bit long, i
 admit) and i thank you for the opportunity, that your message presents,
 to reiterate this: l4linux _exists_ - last time i checked (some months
 ago) it had a port of 2.6.11 to the L4 microkernel.

 so, in more ways than one, no i am of course not expecting people to
 just take orders from someone as mad as myself :)

 i really should reiterate this: i _invite_ people to _consider_ the
 direction that processor designs - not just any "off-the-wall"
 processor designs but _mainstream_ x86-compatible processor designs -
 are likely to take.  and they are becoming more and more parallel.

 the kinds of questions that the experienced linux kernel
 maintainers and developers really need to ask is: can the
 present linux kernel design _cope_ with such parallelism?

 is there an easier way?

 that's mainly why i wished you "good luck" :)

 l.

 p.s. martin.  _don't_ do that again.  i don't care who you are:
 internet archives are forever and your rudeness will be noted
 by google-users and other search-users - long after you are dead.

