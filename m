Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVKOI6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVKOI6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKOI6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:58:07 -0500
Received: from [218.25.172.144] ([218.25.172.144]:46866 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751392AbVKOI6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:58:06 -0500
Date: Tue, 15 Nov 2005 16:58:02 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] oops-tracing: mention digital photos
Message-ID: <20051115085802.GA3320@localhost.localdomain>
References: <200511140302.jAE32voh027313@hera.kernel.org> <20051114215229.GA9043@redhat.com> <Pine.LNX.4.58.0511141354570.8548@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511141354570.8548@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 01:56:03PM -0800, Randy.Dunlap wrote:
> On Mon, 14 Nov 2005, Dave Jones wrote:
> 
> > On Sun, Nov 13, 2005 at 07:02:57PM -0800, Linux Kernel wrote:
> >  > tree 849707fda27c41466eabae0119d6386826ddb7dc
> >  > parent 113fab1386f0093602d9f48b424b945cafd3db23
> >  > author Diego Calleja <diegocg@gmail.com> Mon, 14 Nov 2005 08:07:40 -0800
> >  > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 14 Nov 2005 10:14:17 -0800
> >  >
> >  > [PATCH] oops-tracing: mention digital photos
> >  >
> >  > Signed-off-by: Andrew Morton <akpm@osdl.org>
> >  > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> > Something I've found handy countless times when users do this..
> >
> > Signed-off-by: Dave Jones <davej@redhat.com>
> 
> I've mentioned that a few times also (to bug reporters),
> but your doc. is better than mine was.

I had come up to this idea before too, but never tried it. The higher
resolution mode is ugly and fb was buggy at that time (not sure now).

I wonder if it's feasible to implement panic messages showing cyclically,
or better like more (1).

	Coywolf
