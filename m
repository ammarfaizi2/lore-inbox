Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSJUHzY>; Mon, 21 Oct 2002 03:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbSJUHzY>; Mon, 21 Oct 2002 03:55:24 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:58621 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261263AbSJUHzW> convert rfc822-to-8bit; Mon, 21 Oct 2002 03:55:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Date: Sun, 20 Oct 2002 22:00:22 -0500
User-Agent: KMail/1.4.3
Cc: boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org> <200210210731.g9L7V8p21199@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200210210731.g9L7V8p21199@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202200.22313.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 07:23, Denis Vlasenko wrote:
> On 20 October 2002 21:49, Rob Landley wrote:
> > When Linus comes back, at best he's going to give a thumbs up or
> > thumbs down to each patch currently sitting there in front of him,
> > and then it's on to the feature freeze.  He may not take any of them,
> > or he may just take one or two.  But the best we can hope to do is
> > present him with a nice (short) list of tested patches. (Remember,
> > the less work Linus has to do, the higher the percentage of it that
> > will actually get done.)
>
> Well, maybe it makes sense to reduce flow of non-features patches
> for a couple of days to let Linus feel less buried in email?
> I think VM tweaking and such... It could be done after Linus
> say what got in and what did not.

It would also be nice to buy the dude his own private jet, but I'm not sure 
it's a practical suggestion in the short term. :)

Linus has already said he intends to read his mail with the "D" key when he 
gets back.  The point of collating the pending feature list is to pluck stuff 
out of the mess, shake it off a bit, and present him with a nice menu to make 
choices from on his return.

Deciding not to include stuff is Linus's perogative.  (More than that, it's 
more or less his JOB in kerneldom, acting as goalie for the main tree.)  Once 
again, we're just trying to make sure nothing gets dropped because he didn't 
see it rather than because he saw it and went "no".

In the past half-hour, the MMU-less patch and unlimited groups support have 
been fielded as "ready for 2.5", although I haven't seen URLs to either yet.  
Add Rusty's three items and we're up to... 19?  Plus Hans Reiser said reiser4 
will be ready around the 27th, so that's 20.

I don't think half that many will make it into 2.5, but some of them are 
small, so...

Oh, and of course one more little item that only Linus can merge (speaking of 
small, yet still important):

The version number: is it 2.6 or 3.0?

So that's 21. :)

Rob
