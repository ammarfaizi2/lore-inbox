Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIVLrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIVLrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIVLrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:47:25 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:39851 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264571AbUIVLrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:47:24 -0400
Date: Wed, 22 Sep 2004 13:47:21 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se>
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
 <1095803902.1942.211.camel@bach> <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Richard B. Johnson wrote:

> > Sure, but you have to start somewhere.  Next step will be #error.  Then
> > finally remove the whole thing (I don't want to remove the whole thing
> > to start with, since that would create a silent failure).
> >
> > Cheers,
> > Rusty.
> > --
>
> What replaces the firewall stuff? It can't just "go away"!

Ever heard of iptables?

/Martin
