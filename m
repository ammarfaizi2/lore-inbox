Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWGMM6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWGMM6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWGMM6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:58:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31763 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030185AbWGMM6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:58:47 -0400
Date: Tue, 11 Jul 2006 15:54:49 +0000
From: Pavel Machek <pavel@ucw.cz>
To: andrea@cpushare.com
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711155449.GA8230@ucw.cz>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711141709.GE7192@opteron.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > and both are pledged and available to GPL users. [..]
> > > 
> > > If the GPL offered any protection to my system software I would 
> > > consider it too, but the GPL can't protect software that runs behind 
> > > the corporate firewall. [...]
> > 
> > so you admit and confirm that you explicitly and intentionally do not 
> > pledge your patent to GPL users. [..]
> 
> How many times do I need to say it. The pending patent has nothing to do
> with the kernel, and it is _not_ pledged under the GPL.
...
> Talking about patents when submitting seccomp, would be like talking
> about mp3 patents when submitting alsa code or talking about google

Well, if mp3 was only known user of alsa, yes that would be relevant
discussion... and that seems to be the case here.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
