Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVKCB4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVKCB4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCB4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:56:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:40363 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030265AbVKCB4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:56:50 -0500
Date: Wed, 2 Nov 2005 18:59:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Stevens <dlstevens@us.ibm.com>
Cc: Willy Tarreau <willy@w.ods.org>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Yan Zheng <yzcorp@gmail.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Message-ID: <20051102205926.GB5078@logos.cnet>
References: <20051102092959.GA15515@alpha.home.local> <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:42:37AM -0800, David Stevens wrote:
> Willy Tarreau <willy@w.ods.org> wrote on 11/02/2005 01:29:59 AM:
>  
> > Marcelo, David, does this backport seem appropriate for 2.4.32 ? I 
> verified
> > that it compiles, nothing more.
> 
>         Yes.
> 
> > If it's OK, I've noticed another patch that
> > Yan posted today and which might be of interest before a very solid 
> release.
> 
>         I think they should be reviewed first. :-)

Alright, then let it be tested in v2.6 first. Willy, can you queue for
2.4.33-pre ?
