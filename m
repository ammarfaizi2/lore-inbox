Return-Path: <linux-kernel-owner+w=401wt.eu-S1161192AbWLPQtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWLPQtz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWLPQtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:49:55 -0500
Received: from 1wt.eu ([62.212.114.60]:1546 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161192AbWLPQty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:49:54 -0500
Date: Sat, 16 Dec 2006 17:49:47 +0100
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061216164947.GB31013@1wt.eu>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 08:28:20AM -0800, Linus Torvalds wrote:
> On Sat, 16 Dec 2006, Willy Tarreau wrote:
> > 
> > All this is about "fair use", and "fair use" comes from compatibility
> > between the author's intent and the user's intent.
> 
> No. "fair use" comes from an INcompatibility between the author's intent 
> and the users intent. 
> 
> In other words, "fair use" kicks in EXACTLY when an author says "you can't 
> copy this except when you [payme, stand on your head for two hours, give 
> your modifications back]", and the user _disagrees_.
> 
> Users still have rights under copyright law even when the author tries to 
> deny them those rights.

I understand your point, but not completely agree with the comparison,
because I think that you (as the "author") are in the type of authors
you describe below :

> Of course, all reasonable true authors tend to agree with fair use. People 
> who actually do "original work" tend to all realize that everybody really 
> feeds off of each others works, and that we're all inspired by authors etc 
> that went before us. So I doubt a lot of real authors, musicians or 
> computer programmers will actually disagree with the notion of fair use, 
> but it's important to realize that fair use is exactly for when the users 
> and the authors rights clash, and the user DOES have rights. Even rights 
> that weren't explicitly given to them by the author.

And it is in this situation that I see the compatibility between the user's
and the author's intent : if the user doubts about his fair use and asks the
author, generally the author agrees to extend his fair use perimeter.

(...)

> I think it would be a hell of a lot better idea if people just realized 
                                                  ^^^^^^^^^^^^^^^^^^^^^^^
> that they have "fair use" rights whether the authors give them or not, and 
> that the authors copyrights NEVER extend to anything but a "derived work".
> 
> I find the RIAA's position and the DMCA distasteful, and in that I 
> probably have a lot of things in common with a lot of people on this list. 
> But by _exactly_ the same token, I also find the FSF's position and a lot 
> of GPL zealots' position on this matter very distasteful.
     ^^^^^^^^^^^

You see my point ? The users generally understand "fair use" easier than
the GPL zealots which pollute the list or strip down kernel drivers to
save users' freedom. And it is to protect fair users from those people
that I explicited my intent along with the license.

> Because "fair use" is NOT somethng that should be specified in the 
> license. It's very much something that people have DESPITE any license 
> claiming otherwise.
> 
> And I'd rather teach people that fundamental fact, than try to confuse the 
> issue EVEN MORE by saying that my copyright only extends to derived works 
> in the license text. That will just make people think that if the license 
> does NOT say that, they don't have fair use. AND THAT IS WRONG.

That's a valid point. What is really needed is to tell them that if they
doubt, they just have to ask the author and not be advised by any GPL zealot.

> 			Linus

Regards,
Willy

