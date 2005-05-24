Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVEXRcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVEXRcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVEXRcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:32:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51443 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261812AbVEXRcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:32:06 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: "K.R. Foley" <kr@cybsft.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
In-Reply-To: <42934B3E.10106@cybsft.com>
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
	 <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>
	 <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>
	 <4292E559.3080302@yahoo.com.au> <42930E79.1030305@cybsft.com>
	 <42934674.30406@yahoo.com.au>  <42934B3E.10106@cybsft.com>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 10:31:55 -0700
Message-Id: <1116955916.31174.19.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 10:41 -0500, K.R. Foley wrote:
> Nick Piggin wrote:
> > K.R. Foley wrote:
> > 
> >>
> >> There are definitely those who would prefer to have the functionality,
> >> at least as an option, in the mainline kernel. The group that I contract
> >> for get heartburn about having to patch every kernel running on every
> >> development workstation and every production system. We need hard RT,
> >> but currently when we have to have hard RT we go with a different
> >> product.
> > 
> > 
> > Well, yes. There are lots of things Linux isn't suited for.
> > There are likewise a lot of patches that SGI would love to
> > get into the kernel so it runs better on their 500+ CPU
> > systems. My point was just that a new functionality/feature
> > doesn't by itself justify being included in the kernel.org
> > kernel.
> 
> Agreed. Maybe the Linux kernel can't be all things to all of us, even as 
> configuration options. I am certainly not the one who is going to make 
> that decision either. I just wanted voice my opinion from a 
> user/developer perspective.

I disagree .. The perspective I got from Andrew Morton was that if
enough people want a feature it will/should go in. I agree with that. If
a new feature is added , it just makes a larger download (as long as
it's a configure option). I don't see a downside.


Daniel

