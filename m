Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbVBDSkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbVBDSkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbVBDSkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:40:23 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:57027 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S266088AbVBDSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:39:29 -0500
Date: Fri, 4 Feb 2005 10:39:22 -0800
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204183922.GC27707@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com> <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204170306.GB3467@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My good friend Stelian would have you believe that you are missing 50%
> > of your data when in fact you are missing NONE of your data, you have 
> > ALL of your data in an almost the identical form.
> 
> My good friend Larry would have you believe that I said something
> I just never did. Go back and read the archives.

Come on, claiming that you are only getting 50% of the information is 
just blatent FUD.  If you can't see that I can't help you.

> > I suppose what we could do is stick the BK changeset key into the 
> > delta history so that if you really wanted to get the BK level
> > granularity you could.
> 
> This would be nice indeed and I think it would end up all whinning
> since using that, one could be able to get the full history from the
> bkcvs repository. But would you do that ?

You get a commitment from the group of BK complainers that that is good 
enough and we'll do it.  It may take a while because in the current way
that BK stores metadata it would be prohibitively expensive.  But we
want to change that anyway so we can prototype it on an internal tree
and see how well it works.

If/when we do this we'll reexport the 2.4 and 2.5 histories from scratch
so you get the info going backwards in time.

So, do you think you can sign up the usual suspects to being happy with
this answer?  And do you mind spelling out exactly what it is that you
think is being offered so there is no confusion later?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
