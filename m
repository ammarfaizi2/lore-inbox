Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUEXVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUEXVUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUEXVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:20:24 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:14720 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S264693AbUEXVUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:20:15 -0400
Message-Id: <200405242119.i4OLJR901548@pincoya.inf.utfsm.cl>
To: Andi Kleen <ak@muc.de>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission 
In-reply-to: Your message of "Mon, 24 May 2004 21:57:31 +0200."
             <m3fz9pd2dw.fsf@averell.firstfloor.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 24 May 2004 17:19:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> said:

[...]

> e.g. consider some first contributor sends a maintainer a patch to be
> incorporated.  Do you expect people now to send them this
> Certification of Origin back and ask "Do you agree to this?"  
> and only add the patch after they sent back an email "Yes I agree to
this"?

Yep. That's exactly the point: That they don't come back later and scream
they just patented the for loop, and that its inclusion wasn't legitimate.

> That sounds quite involved to me. I bet in some companies this 
> Certificate would first be sent to the legal department for approval,
> delaying the patch for a long time

Tough luck, IMEHO.

> Even without such an explicit agreement it could get quite
> complicated to figure out what to put into the Signed-off-by
> lines if they're not already there.
> 
> e.g. normally the maintainer would just answer "ok, looks good,
> applied". Now they would need to ask "ok, did you write this. if not
> through which hands did it pass"? and wait for a reply and then only
> add the patch when you know whom to put into all these Signed-off-by
> lines.

I'd hope this gets part of the normal patch flow sooner or later, so that
this will only have to be done on occasion.

> This is not unrealistic, For example for patches that are "official
> projects" by someone it often happens that not the actual submitter
> sends the patch, but his manager (often not even cc'ing the original
> developer). In some cases companies even go through huge efforts to
> keep the original developers secret (I won't give names here, but it
> happens). That's of course not because they stole anything, but
> because they have some silly NDAs in place regarding not giving out
> names of partners they're talking to or they just don't want you to
> learn too much about their internals.

What should be done is that Someone In Power signs off the patch(es)
contributed by said company. This is to have a way to trace to someone who
willingly (and taking responsibility) contributed each patch. Sure, it'd be
nice to also know who commited some heinous crime(s), but...

Remember, what Linus wants is that no onne can pull an SCOX on Linux: If
they come screaming that it contains preciousss IP, you can show in detail
where it came from and make sure it is legitimate (or whom to blame, as the
case may be).

> I would have no problems with just putting a Signed-Off-By for me
> and for the person who sent me the patch, but trying to find out
> all the people through whose mailboxes the patch travelled earlier
> is potentially quite a lot of work. I am not sure I really 
> want to get into that business.

What you should care about is that the next in line signed off their
contribution(s) or certifies the origin.

> I also don't think it's realistic to expect that everybody who
> submits patches will put in all the right Signed-Off-Bys on their own,
> so requiring the full path would put the maintainers into the 
> situation outlined above.

Much less hassle than FSF's paperwork, to be sure.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
