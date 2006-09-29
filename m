Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWI2RuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWI2RuB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWI2RuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:50:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161309AbWI2RuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:50:00 -0400
Date: Fri, 29 Sep 2006 10:49:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Helge Hafting <helge.hafting@aitel.hist.no>, tglx@linutronix.de,
       Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159552021.13029.58.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609291030050.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <451798FA.8000004@rebelhomicide.demon.nl>  <17687.46268.156413.352299@cse.unsw.edu.au>
  <1159183895.11049.56.camel@localhost.localdomain> 
 <1159200620.9326.447.camel@localhost.localdomain>  <451CF22D.4030405@aitel.hist.no>
  <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org> <1159552021.13029.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2006, Alan Cox wrote:
> 
> That cuts both ways
> 
> "If you don't want to use all this handy free code then don't lock your
>  system down or go use OpenBSD"

That's a fallacious argument for two reasons:

 - the GPLv2 allows usage in any circumstances except the geographical 
   limitation that can be forced on it by other laws. No serious lawyer I 
   have ever met is even ambiguous about this. There's just no question - 
   people may not be happy about it, and iirc the FSF at some point tried 
   to claim somethign else, but this really isn't all that controversial.

   So the whole "If you don't want to use all this handy free code" 
   argument is simply WRONG. It's based on a premise that just isn't true. 
   All that handy free code is perfectly usable for things like a secure 
   terminal or something else that doesn't allow you to change its 
   behaviour because of some load-time consistency check.

   You cannot make a logical argument that as it's axiom takes something 
   that is patently false. It may still be "logically consistent", but it 
   has no _relevance_, since it has nothing to do with reality.

 - It tries to equate the word "free" (which means so many things that it 
   almost lacks meaning) with "not able to authenticate". Which is just 
   one of hundreds of ways to read it, and it is extremely irritating how 
   the FSF thinks that _its_ definition of the word free somehow trumps 
   everybody elses.

   We already had that discussion ten years ago, and it's why people who 
   want to be clear in their speaking (and thinking) use the term "Open 
   Source". Because the OSI rules generally speak about concrete things 
   that mean only one thing, which means that they actually have a 
   well-defined _meaning_ in any discussion between two parties.

A lot of people seem to think that the problem with "free" was just the 
confusion between "no cost" and "freedom". Those people seemed to never 
really understand an even deeper problem in the whole FSF language use.

In other words: anybody who wants to have a logical argument about the 
real world needs to start with (a) acknowledging facts and (b) avoid using 
words that may mean something else to the other side.

			Linus
