Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWGKQQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGKQQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWGKQQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:16:12 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:63435
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750762AbWGKQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:16:11 -0400
Date: Tue, 11 Jul 2006 18:16:39 +0200
From: andrea@cpushare.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711161639.GL7192@opteron.random>
References: <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <20060711160236.GX13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711160236.GX13938@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:02:36PM +0200, Adrian Bunk wrote:
> And it was you who said just a few days ago [1]:
> 
> <--  snip  -->
> 
> ...
> If I've to keep reading these threads about CONFIG_SECCOMP every few
> months then set it to N (even if I disagree with that setting). Like
> Alan said, what really matters is what distro will choose in their
> config, not the default (and I doubt fedora ships with cifs=Y like the
> default where only the required stuff is set to Y, please focus on the
> big stuff first ;).
> 
> <--  snip  -->

The above was in the context of the mainline kernel in case you didn't
notice (when I wrote the above I expected fedora to set it to Y even if
the main kernel was set to N, imagine how way off I was when I wrote the
above ;).
