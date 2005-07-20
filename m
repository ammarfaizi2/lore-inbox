Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVGTBWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVGTBWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 21:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGTBWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 21:22:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11006 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261735AbVGTBWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 21:22:08 -0400
Subject: Re: Interbench real time benchmark results
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <200507201104.48249.kernel@kolivas.org>
References: <200507200816.11386.kernel@kolivas.org>
	 <20050719223216.GA4194@elte.hu>
	 <1121819037.26927.75.camel@dhcp153.mvista.com>
	 <200507201104.48249.kernel@kolivas.org>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 19 Jul 2005 18:22:04 -0700
Message-Id: <1121822524.26927.85.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 11:04 +1000, Con Kolivas wrote:
> On Wed, 20 Jul 2005 10:23 am, Daniel Walker wrote:
> > On Wed, 2005-07-20 at 00:32 +0200, Ingo Molnar wrote:
> > >  - networking is another frequent source of latencies - it might make
> > >    sense to add a workload doing lots of socket IO. (localhost might be
> > >    enough, but not for everything)
> >
> > The Gnutella test?
> 
> I've seen some massive latencies on mainline when throwing network loads from 
> outside, but with my limited knowledge I haven't found a way to implement 
> such a thing locally. I'll look at this gnutella test at some stage to see 
> what it is and if I can adopt the load within interbench. Thanks for the 
> suggestion.

There isn't actually a test called "The Gnutella test" , but I think
Gnutella clients put lots of network load on a system (Lee was talking
about that not to long ago). I was thinking that type of load may have
been what Ingo was talking about.

Daniel 

