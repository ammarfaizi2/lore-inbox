Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUGWUAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUGWUAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUGWUAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:00:49 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:10377 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S267961AbUGWUAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:00:44 -0400
Subject: Re: A users thoughts on the new dev. model
From: Tim Wright <timw@splhi.com>
To: Xiong Jiang <linuster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9b5164430407231206fd5c045@mail.gmail.com>
References: <20040723152421.52282.qmail@web52904.mail.yahoo.com>
	 <41013F49.7030902@blue-labs.org> <9b5164430407231206fd5c045@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1090612841.6113.135.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 23 Jul 2004 13:00:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a dumb end user, what reason would you have for wishing to grab a
kernel.org kernel? A true "dumb end user" cares about the applications
they intend to run and doesn't give a hoot about the kernel. Provided
that the kernel supports the applications they wish to use, and it's
stable, it should not be relevant. There are people out there using
Linux 2.0.X, 2.2.X, 2.4.X etc. etc. and who are perfectly happy because
it does what they need it to do. If you care about the latest 2.6.X
kernel version, you're *not* "a dumb end user" :-)

Anyway, as hpa kindly pointed out, the 2.6.X kernels are still intended
to be stable. The proving ground will be in the -mm series. So carry on
using 2.6.X and be happy. It's been a great deal more stable than 2.4.X
was for a long time at least for me.

Regards,

Tim

On Fri, 2004-07-23 at 12:06, Xiong Jiang wrote:
> Forgive me if I missed any points earlier in the list since I am not a
> frequent reader here.
> 
> As a dumb end user I DO need people to tell me which .x version in
> 2.6.x series is STABLE.
> 
> I understand it is important to get new features in as
> soon as possible, but it is same important that we end users could
> sleep well with the version running on our systems.
> 
> If every 2.6.x version is so solid then I wouldn't say anything, but I
> am afraid it is not true. I think it still very important to
> distinguish between _bug_fix_ release and _feature_devel_ release,
> being it
> 2.6.x vs 2.7.x, or
> 2.6.x.1 vs 2.6.x+1, or
> 2.6.x vs 2.6.x+1-pre/-rc/-mm
> 
> I am optimistic that this issue could be settled down fairly easily by
> such an open development process.
> 
> Sincerely,
> 
> A dumb end user
> 
> On Fri, 23 Jul 2004 12:39:37 -0400, David Ford
> <david+challenge-response@blue-labs.org> wrote:
> > This is malarkey, 99.9% pure FUD.  I personally use just about every
> > kernel revision there is that is "newest", i.e. I use 2.4.x until 2.5
> > appears then I switch to 2.5.x.  I may skip a few versions here and
> > there due to frequent releases or a known brown bag release.  However by
> > far and large even the development or "unstable" line of releases as
> > some people have a bad habit of calling them, are far more reliable than
> > Windows.
> > 
> > I use odd.x releases even on my servers.  Every once in a while there's
> > a significant bug in code that I'll have an issue with that can't be
> > worked around.  So I avoid that version.
> > 
> > In short, your statement is pure bullsh*t, because there is very little
> > code put out that is actually a messy or unstable release.  Most bugs
> > are quickly fixed, worked around, or avoided for that person because
> > that feature isn't really such a necessity.  Linux (*nix) gives you a
> > LOT of ways to get a particular task done but people have this penchant
> > for finding a way that is broken and hyping/harping it up to make a big
> > issue out of it instead of just reporting the bug and getting the job
> > done in a different fashion.
> > 
> > "Oh my gawd it's a bug, let me piss on everyone's doorstep and make
> > caustic remarks on LKML about horribly broken code.  Never mind you that
> > I can probably get it done another way."
> > 
> > Give the developers a little credit, we all make mistakes; they happen
> > to fix theirs pretty fast and they're downright honest about fessing up
> > to them.
> > 
> > David
> > 
> > 
> > 
> > >>From the LWM story i understood that linux will be like windows:
> > >lots of "features" but no stability, except if you use a
> > > distribution kernel. And that seriously made me think about
> > > using another free *nix for a stable system.
> > >
> > 
> > 
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Tim Wright <timw@splhi.com>
Splhi
