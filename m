Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262216AbSJFWAZ>; Sun, 6 Oct 2002 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262222AbSJFWAZ>; Sun, 6 Oct 2002 18:00:25 -0400
Received: from bitmover.com ([192.132.92.2]:36753 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262221AbSJFWAX>;
	Sun, 6 Oct 2002 18:00:23 -0400
Date: Sun, 6 Oct 2002 15:05:54 -0700
From: Larry McVoy <lm@bitmover.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021006150554.T29486@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <20021006075627.I9032@work.bitmover.com> <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain> <anqa2m$cr4$2@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <anqa2m$cr4$2@ncc1701.cistron.net>; from miquels@cistron.nl on Sun, Oct 06, 2002 at 09:31:02PM +0000
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 09:31:02PM +0000, Miquel van Smoorenburg wrote:
> In article <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain>,
> Ingo Molnar  <mingo@elte.hu> wrote:
> >so BK cannot be used to access the kernel tree in that case, correct? I'm
> >just wondering where the boundary line is. Eg. if i started working on a
> >versioned filesystem today, i'd not be allowed to use BK. I just have to
> >keep stuff like that in mind when using BK.
> 
> And what if that versioning filesystem got accepted into mainline?
> Every kernel developer would have to buy a BK license.
> 
> Either that or a versioning filesystem cannot get into mainline.
> Sorry Hans, no reiser4 in the kernel.

If Hans decides to get into the version control space and compete directly
against us, your position is that we should be obligated to give him free
seats?  And that's reasonable in your mind?

At the end of the day, we're doing the best that we can to help out the
most that we can.  If you were in my shoes I think you'd have the same
concerns and issues I have.  I'm more than willing to believe you could
handle them better than I do but the issues wouldn't change.

Let's talk about why that clause is in the license.  There are two
possible problems: a commercial company decides to replicate BK or
an open source project tries to replicate BK.  Either path has the
strong likelihood of putting us out of business if they execute 
better than we have.

If it's the commercial path, you know they aren't going to give you what
they build for free like we did, especially after seeing the problems it
has caused us.  The *only* reason anyone would do what we are doing is
if they really wanted to help the kernel.  The so called PR value that
we supposedly get is simply dwarfed by the PR problems it has caused,
the time it has wasted, and the salaries it has cost us.  So the business
guys aren't a good choice, they won't treat you anywhere near as well
as we treat you because they are not part of your community.  I am.
Maybe not a well loved part, but a part non the less.

If it is an open source project, they'll replicate what we have,
which would drop our revenue stream to zero, and BK development stops.
The replica won't be any better than BK, it will be worse.  It won't
have the same level of polish or architecture, that's too much work.
Subversion is a funded project, they have had way more money than we had
when we started, and they aren't anywhere near to being a BK replacement.
The open source route isn't a good choice because it costs too much to
do this and it's just not very fun work.  Look at all the "projects"
on source forge to see data which supports my point of view.

Some people say "I don't care, BK is good enough, a replica would be fine".
Actually, it wouldn't.  No more so than CVS is.  BK as it stands has real
limitations, those need to be fixed.  Linus or one of the other kernel
hackers will be happy to list those limitations and I can fill in the 
problems they haven't hit yet but certainly will.

The real question is: if you want us to allow things that we believe
will put us out of business, then where are you going to get tools like
BK from?  Complain all you want about the license, but it's clear that BK
has helped.  Going back to diff&patch would suck.  BK is a competitive
advantage for the kernel as it stands.  We're making it better so it
won't fall over dead 3 years from when the history gets to big or some
other problem occurs.

If you could have figured out a way to do the same amount of good that
we are providing but in a more politically correct (i.e. GPLed) way,
then why the hell haven't you?  And if you can't, how about easing off
a bit and letting us do what we can?  If you have suggestions on how we
could do things in a nier way without putting the company, and therefor
the kernel team, at risk, then make them.  I'm one of you.  We're helping
as best we are able.  You might stop to realize that we've been doing
this for 5 years, we never took VC, we never sold out, even though we had
multiple chances to do both, because that would put helping you at risk.
You don't like my choices?  Put on my shoes, suggest better choices.
I'll listen.  But you have to really think it through.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
