Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJJBC5>; Wed, 9 Oct 2002 21:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbSJJBC5>; Wed, 9 Oct 2002 21:02:57 -0400
Received: from bitmover.com ([192.132.92.2]:15290 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262788AbSJJBCw>;
	Wed, 9 Oct 2002 21:02:52 -0400
Date: Wed, 9 Oct 2002 18:08:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: BK is *evil* corporate software
Message-ID: <20021009180834.A9206@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20021007204830.00b8b460@pop.gmx.net> <20021007143134.V14596@work.bitmover.com> <ao2ee1$l0c$1@forge.intermeta.de> <20021009.165003.103179484.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021009.165003.103179484.davem@redhat.com>; from davem@redhat.com on Wed, Oct 09, 2002 at 04:50:03PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:50:03PM -0700, David S. Miller wrote:
>    From: "Henning P. Schmiedehausen" <hps@intermeta.de>
>    Date: Wed, 9 Oct 2002 23:34:25 +0000 (UTC)
>    
>    For the vast number of three to five developers enterprises, it's
>    simply unreasonably priced.
> 
> Larry is trying to tell you that BK isn't for you.
> It costs too much to support small numbers of groups
> which is why he can't price it the way you want.

One of the other BitMover founders, Andrew Chang, told me a few months
ago that he realized that CVS was our "low end entry level product".
He's right.  Much like I suck at public relations (and boy do I suck,
smacks head for Nth time), we also could be better at sales.  Our sales
pitch is "does anything hurt?  No?  Go use CVS.  Come back when it hurts.
If it never hurts you should never pay for BK".  

I learned this the one time we ever did any marketing, which was way back
in 1999 or 1998 at Linux Expo.  I was program chair for the technical
conference and Red Hat kindly gave us a booth.  So we printed out the
BK logo on a big sheet of paper and sat at a booth and answered questions,
all of which went like this for the first 10 or 15 people:

	Random Person: "Why should I use BitKeeper instead of CVS?"
	Larry: <insert long winded, rambling answer extolling the BK virtues>
	Random Person: <eyes glaze over, walks away>

I'm slow so it took me at least 10 of those to realize that I just wasn't
getting through these people.  And in true "larry form" I got pissed off.
So with the next guy it went like this:

	Random Person: "Why should I use BitKeeper instead of CVS?"
	Larry: "If you have to ask that stupid question, you haven't
	    suffered enough.  Go away, come back when it hurts."
	Random Person: "Well, actually, renames under CVS really hurt, do 
	    you fix that?"
	Larry: "You bet we do, it works like ...."

Very important lesson.  People don't give a rats ass about how cool your
technology is, how elegant it is, or any other thing that makes engineers
get excited.  What they care about is pain or the lack thereof.

So these days we bill ourselves as "Novacaine for source management".  If
you are suffering then we may be able to help and the price will look cheap.
If you aren't suffering you should stay with what you have.

The same thing applies to the Linux Kernel team.  It's an absolute
fact that the BK license isn't what you want, it's not open source,
it's evil corporate software, at least in the view of any open source
fanatic and a lot of fairly reasonable people.  If you are using it,
it's because it makes your pain go away.  Or at least partially go away.

If I could have figured out a way to do that with a GPLed license I would
have done so, but I couldn't, so the license is what it is.  The bad
news is that the license isn't what you want.  The good news is that
*all* of us at BitMover are hackers just like you and we hate tools that
cause pain, so we are very motivated & committed to make BK an even more
effective tool.  We want you to do what you can do what you do best: code.
The less than ideal license is, in our opinion, what allows us to help
you do that.  It's entirely possible that there is a better licensing
answer, we just don't see it.  On the other hand, I swear to you that
there is no development team anywhere on the planet more committed to
making your work pleasant.  If you can look past the license, we're the
best thing that has ever happened to you, we are here to make you happy.
The license sucks, we can't help that.  The software doesn't suck a lot
and we are trying to make it not suck at all.  To steal a line from Mutt,
"All SCM systems suck, BK just sucks less".

I'm really sorry the license has caused this much fuss.  We'll try
to make it more acceptable to the extent that we can.  On the other
hand, those of you who are flaming should be ashamed of yourselves
for attacking a group of engineers doing everything they can to help
make things better for the kernel.  We've been here for a long time;
throwing stones at us and saying we're just out to make a quick buck
is nonsense, we're here to help and our track record speaks for itself.
I do understand that our choices aren't popular with the GPL fans, but
that doesn't make us evil.  We're doing what we need to do in order to
help.  This market space, as Henning has pointed out, is very cost
sensitive and there is no hope, in our opinion, that a GPLed answer 
could do what we are doing.  If it could, we'd be doing it that way.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
