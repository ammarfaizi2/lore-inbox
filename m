Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVH3FsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVH3FsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVH3FsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:48:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45235 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750786AbVH3FsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:48:09 -0400
Date: Tue, 30 Aug 2005 07:48:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7-rt4, fails to build
Message-ID: <20050830054852.GA5743@elte.hu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu> <20050829083541.GA21756@elte.hu> <1125334627.7631.21.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125334627.7631.21.camel@cmn37.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Mon, 2005-08-29 at 01:35, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > I'm getting a build error for 2.6.13-rc7-rt4 with PREEMPT_DESKTOP for 
> > > i386:
> > 
> > hm, cannot reproduce this build problem on my current tree - could you 
> > try 2.6.13-rt1? (and please send the 2.6.13-rt1 .config if it still 
> > occurs)
> 
> I had to redo two chunks (this also happened to me in rc7-rt3):

hm, what is the problem with these two chunks? (they apply fine here, 
and the patched file builds fine too.)

	Ingo
