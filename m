Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTKMLR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTKMLR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:17:28 -0500
Received: from intra.cyclades.com ([64.186.161.6]:21645 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263909AbTKMLRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:17:23 -0500
Date: Thu, 13 Nov 2003 09:07:05 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "David S. Miller" <davem@redhat.com>
Cc: "Beau E. Cox" <beau@beaucox.com>, <linux-kernel@vger.kernel.org>,
       <netfilter-devel@lists.netfilter.org>
Subject: Re: PROBLEM: 2.4.23-rc4 -> rc1 hang with change to ip_nat_core.c
 made in pre4
In-Reply-To: <20031112212025.5eb29f52.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0311130850030.3878-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Nov 2003, David S. Miller wrote:

> On Wed, 12 Nov 2003 19:24:38 -1000
> "Beau E. Cox" <beau@beaucox.com> wrote:
> 
> > On Wednesday 12 November 2003 05:59 pm, David S. Miller wrote:
> > > Marcelo has reverted the change in question, so his current
> > > 2.4.x tree should be fine.
> > 
> > Thank you so much.
> > 
> > I guess this makes me an honary Linux kernel contribitor, er...
> > uncontributor... :)
> 
> I take what I said back temporarily, Marcelo didn't revert the
> change yet but I have just reminded him to do so.
> 
> It should be fixed by the time 2.4.23 final rolls out.

The mentioned change is already in bkbits.net.





