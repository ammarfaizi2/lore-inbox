Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSLRQvf>; Wed, 18 Dec 2002 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSLRQvf>; Wed, 18 Dec 2002 11:51:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:36251 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265378AbSLRQve>;
	Wed, 18 Dec 2002 11:51:34 -0500
Date: Wed, 18 Dec 2002 16:58:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021218165838.GD27695@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	Andrew Morton <akpm@digeo.com>
References: <20021218164119.GC27695@suse.de> <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 08:49:37AM -0800, Linus Torvalds wrote:

 > >  > What happened to "feature freeze"?
 > > *bites lip* it's fairly low impact *duck*.
 > However, it's a fair question.

Indeed. Were you merging something like preempt at this stage, I'd be wondering
if you'd broken out the eggnog a little too soon.

 > I just don't know what that "something" should be. Any ideas? I thought
 > about the code freeze require buy-in from three of four people (me, Alan,
 > Dave and Andrew come to mind) for a patch to go in, but that's probably
 > too draconian for now. Or is it (maybe start with "needs approval by two"
 > and switch it to three when going into code freeze)?

You'd likely need an odd number of folks in this cabal^Winner circle
though, or would you just do it and be damned if you got an equal
number of 'aye's and 'nay's ? 8-)

Other than that, it reminds me of the way the gcc folks work, with a
number of people reviewing patches before acceptance [not that this
doesn't happen on l-k already], and at least 1 approval from someone
prepared to approve submissions.

The approval process does seem to be quite a lot of work though.
I think it was rth last year at OLS who told me that at that time
he'd been doing more approving of other peoples stuff than coding himself.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
