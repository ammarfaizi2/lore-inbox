Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVH0BQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVH0BQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 21:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVH0BQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 21:16:25 -0400
Received: from waste.org ([216.27.176.166]:61572 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S965188AbVH0BQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 21:16:24 -0400
Date: Fri, 26 Aug 2005 18:15:37 -0700
From: Matt Mackall <mpm@selenic.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com
Subject: Re: 2.6.13-rc6-rt1
Message-ID: <20050827011537.GC27787@waste.org>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <20050815111804.GA26161@elte.hu> <20050816084116.GA16772@elte.hu> <4301DCC1.5060409@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4301DCC1.5060409@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 02:32:01PM +0200, Michal Schmidt wrote:
> Ingo Molnar wrote:
> >i've released the 2.6.13-rc6-rt1 tree, which can be downloaded from the 
> >usual place:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> >
> >as the name already suggests, i've switched to a new, simplified naming 
> >scheme, which follows the usual naming convention of trees tracking the 
> >mainline kernel. The numbering will be restarted for every new upstream 
> >kernel the -RT tree is merged to.
> 
> Great! With this naming scheme it is easy to teach Matt Mackall's 
> ketchup script about the -RT tree.
> The modified ketchup script can be downloaded from:
> http://www.uamt.feec.vutbr.cz/rizeni/pom/ketchup-0.9+rt
> 
> Matt, would you release a new ketchup version with this support for 
> Ingo's tree?

Thanks. I've put this in my version, which is now exported as a
Mercurial repo at:

 http://selenic.com/repo/ketchup

This version also has -git support, finally.

-- 
Mathematics is the supreme nostalgia of our time.
