Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIVMFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIVMFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUIVMFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:05:54 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264795AbUIVMFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:05:52 -0400
Date: Wed, 22 Sep 2004 08:05:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
 <1095803902.1942.211.camel@bach> <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
 <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Martin Josefsson wrote:

> On Wed, 22 Sep 2004, Richard B. Johnson wrote:
>
> > > Sure, but you have to start somewhere.  Next step will be #error.  Then
> > > finally remove the whole thing (I don't want to remove the whole thing
> > > to start with, since that would create a silent failure).
> > >
> > > Cheers,
> > > Rusty.
> > > --
> >
> > What replaces the firewall stuff? It can't just "go away"!
>
> Ever heard of iptables?
>
> /Martin

I guess I'll have to convert 1340 lines of ipchains commands to
iptables -yech!

I had convert something to ipchains a couple of years ago.
That's when I only had to kill-off only about 100 spam-hosts.

Now I gotta convert again. Soon they'll be replacing `ls`
with `echo *` and nothing will work.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

