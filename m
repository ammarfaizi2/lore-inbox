Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDIBme (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDIBme (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:42:34 -0400
Received: from mail.casabyte.com ([209.63.254.226]:59406 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262689AbTDIBmb (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 21:42:31 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Larry McVoy" <lm@bitmover.com>, "Jamie Lokier" <jamie@shareable.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: BitBucket: GPL-ed KitBeeper clone
Date: Tue, 8 Apr 2003 18:43:43 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEMBCGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030409004718.GA1855@work.bitmover.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would agree if-and-only-if you can demonstrate that you came to the field
a virgin.  That is, if your own software doesn't rely on anything you have
"mimicked" from another source then you are right to believe that your work
should be immune from idea-harvest.

I suspect however, that you didn't think you were "stealing" when you
started with the concept of comparing a new file to an old one. (doing a
diff) or whenever, in any project, you used buffering, look ahead, look
behind, regular expressions, sorting, ignoring white space, soundex,
encryption, sockets, menus, command line interfaces, typing, function keys,
etc, etc, etc.

All of those things are now in the common consciousness, but they didn't
start there.  Was the first person to go "hmm, good idea, but I can make it
better" for each of those and every other idea, a-priori a thief?  By using
that "stolen thought" are you supporting "theft".

Nope.

All of our computer concepts, whether you realize it or not, come from our
base language skills.  "To Compare" is an English verb, it is also a verb in
many other languages, any expression of comparison in any form "steals" from
the root concept.

So your ideas, once expressed, are irrecoverably contributed to the set of
all ideas, regardless of how you do that expression.  That fact, that
process, is wired inextricably into the human brain.  Railing for injunctive
relief (etc 8-) because of any follow on act is pointless and nonsensical.

The particular crime of derivation without permission and recompense ends,
in fact *must* end, well short of "took the idea".  Its domain plays out
somewhere around "copied some of my (literal) code."

If you want to possess an idea, don't disclose it.  IF your product requires
disclosure for use, you either play in public or take your ball and stay
home.  That's just the facts organic cognition.

Euphemistically: "Monkey See, Monkey Do."  There is a surprising amount of
simple biological truth to that old saw.  (ask any second-grader. 8-)

Also, for all that "to steal" and "theft" are feel good rhetoric words, "to
steal" and idea you have to deprive the original owner of it, the "it" being
the idea, not the money it could make.  That's why copyright lawyer-speak
never uses the theft-words.  There is infringement and non-infringement, and
derivation, but not theft.

Don't get me wrong.

I make software for a living, and I recognize that it would be hypocritical
beyond measure to not pay for a commercial package that I use.  I have more
versions of Microsoft Windows than I can shake a stick at, each lawfully
bought/upgraded etc.  When I left my last employer I removed the copy of
office that I was entitled to have on my home computer as their employee.
Yes, I am that kind of nut.  I am not perfect at it, but I get as close as I
can manage.

I have written a novel, I expect that if I can get it published, I deserve
commensurate compensation.  I would be angry if someone use some/all of my
book and published it as their own.  I would even take steps to redress such
infringement.

But, if the book is good and it gets out there, I *expect* that people of
various levels of talent will mimic it either consciously or unconsciously.
I *equally* expect to have some people talk about the similarities between
it an Robert Jordan (though I think it is less influenced by him and more by
some of our common antecedents going back for centuries.)

The whole reason d'arte behind the "open software" process is that it gives
people a way to take advantage of the monkey-see-monkey-do effect, a
recompense that previously wasn't available at all.  Of course I am not
expecting my next GNU contribution to pay my bills.

Yep, a fine line, but deep.

Did they copy your code?  Go get some relief...
Did they copy your idea?  Take the hit and move on...
Was "your idea" conceived in a vacuum?  If not, bow your head in shame for
yelling at others for doing "to you" what you yourself have done in greater
orders of magnitude to all those who came before you.  (that being building
on someone else's ideas, if you haven't kept up... 8-)

To dip back into that pre-school bin-o-truth: "Turn about is fair play."

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Larry McVoy
Sent: Tuesday, April 08, 2003 5:47 PM
To: Jamie Lokier
Cc: Larry McVoy; linux-kernel
Subject: Re: BitBucket: GPL-ed KitBeeper clone


On Wed, Apr 09, 2003 at 12:19:49AM +0100, Jamie Lokier wrote:
> Larry McVoy wrote about unreleased improvements to Bitkeeper:
> > [...] we're worried about the open source guys stealing them.
>
> Seriously, do you see it as "stealing" if someone mimics your best ideas?

Yes.  It is not clear to me that open source community has realized that
it is much harder to come up with the ideas than it is to copy them.
Much of the activity in open source community is copying, providing a
GPLed version of some commercial tool.

The problem is that that those things which you wish to copy represent
easily 10x-100x more work than it would take to copy them.   So we spend
the order[s] of magnitude more money to get a good answer and you copy it.
In many cases, before we can recoup our investment.

The short answer is yes, it's stealing in our eyes.  If you're such a
good programmer, how about you go figure out the SCM answers without
leveraging our work?  By not honoring that request, you are begging us
to stop improving the free version of BK.  Also known as "cutting off
your nose to spite your face".
--
---
Larry McVoy              lm at bitmover.com
http://www.bitmover.com/lm
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

