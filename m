Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKCFOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKCFOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKCFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:14:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:31496 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750726AbVKCFOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:14:07 -0500
Date: Thu, 3 Nov 2005 06:02:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: David Stevens <dlstevens@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Yan Zheng <yzcorp@gmail.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Message-ID: <20051103050222.GA19095@alpha.home.local>
References: <20051102092959.GA15515@alpha.home.local> <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com> <20051102205926.GB5078@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102205926.GB5078@logos.cnet>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 06:59:26PM -0200, Marcelo Tosatti wrote:
> On Wed, Nov 02, 2005 at 09:42:37AM -0800, David Stevens wrote:
> > Willy Tarreau <willy@w.ods.org> wrote on 11/02/2005 01:29:59 AM:
> >  
> > > Marcelo, David, does this backport seem appropriate for 2.4.32 ? I 
> > verified
> > > that it compiles, nothing more.
> > 
> >         Yes.
> > 
> > > If it's OK, I've noticed another patch that
> > > Yan posted today and which might be of interest before a very solid 
> > release.
> > 
> >         I think they should be reviewed first. :-)
> 
> Alright, then let it be tested in v2.6 first. Willy, can you queue for
> 2.4.33-pre ?

OK.

Willy

