Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVBDRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVBDRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbVBDRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:01:55 -0500
Received: from sd291.sivit.org ([194.146.225.122]:50314 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261596AbVBDRBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:01:35 -0500
Date: Fri, 4 Feb 2005 18:03:07 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204170306.GB3467@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204160631.GB26748@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Taking hpa out of CC:, I don't think he is interested anymore]

On Fri, Feb 04, 2005 at 08:06:31AM -0800, Larry McVoy wrote:

> You need to rethink your math, you are way off.  I'll explain it so that
> the rest of the people can see this is just pure FUD.  

There is no FUD in all what I said, for the simple reasons that we
are saying exactly the same thing: 
	* the data is there
	* the metadata is there
	* all that is missing is some metadata boundaries.

> My good friend Stelian would have you believe that you are missing 50%
> of your data when in fact you are missing NONE of your data, you have 
> ALL of your data in an almost the identical form.

My good friend Larry would have you believe that I said something
I just never did. Go back and read the archives.

> What Stelian is complaining about is the patch set which is easily 
> extractable from CVS is at a coarser granularity than the patch set
> extractable from BK.  That's true [...]

Exactly. You see, you understood exactly what I did say. And I'm pretty
sure all the audience did.

> [...] but so what?  Before BK you only
> a handful of patches between releases, now you have thousands.

I'm not interested in ranting. I already did say that BK was good
for the kernel development, what more would you like me to say ?

> 
> I suppose what we could do is stick the BK changeset key into the 
> delta history so that if you really wanted to get the BK level
> granularity you could.

This would be nice indeed and I think it would end up all whinning
since using that, one could be able to get the full history from the
bkcvs repository. But would you do that ?

> > [describes violating the license]
> > But you may consider this contrary to the 'non competitor' clause of
> > the BKL (clause 3d), that's why I need some authorization from you
> > before starting.
> 
> And you most certainly do not have it, as you are aware it is a
> violation of the license.

I was merely proposing my help to do something you said you don't
wanna do because it would consume too much resources. Does this
proposal deserves such a rude answer ? 

Moreover, I said "you may consider...", not "I am aware it is...".
Using BK to write a script which helps extracting the metadata is not
clearly a violation, since the script itself does not "compete with
the BitKeeper Software.". This part a clarification, and this is
what I asked for.

The distribution of the metadata is clearly a violation, but you
didn't quote that part of the proposal...

> Asking for an exception is about as polite as
> me asking for an exception from the GPL's requirements.

I don't see what 'polite' has to do with it. If one of us tends to
be rude I would say that's you...

Anyway, it is perfectly valid to ask the author(s) for an exception 
to the distribution license. The author is free to reject the demand,
or to accept it if there is some interest in doing so.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
