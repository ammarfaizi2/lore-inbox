Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVIAPLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVIAPLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVIAPLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:11:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23537 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932249AbVIAPLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:11:21 -0400
Subject: Re: FW: [RFC] A more general timeout specification
From: Daniel Walker <dwalker@mvista.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Joe Korty <joe.korty@ccur.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509011610570.3743@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
	 <Pine.LNX.4.61.0509010136350.3743@scrub.home>
	 <20050901135049.GB1753@tsunami.ccur.com>
	 <Pine.LNX.4.61.0509011610570.3743@scrub.home>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 08:11:08 -0700
Message-Id: <1125587468.32005.12.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 16:32 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 1 Sep 2005, Joe Korty wrote:
> 
> > > When you convert a user time to kernel time you can
> > > automatically validate
> > 
> > Kernel time sucks.  It is just a single clock, it may not have
> > the attributes of the clock that the user really wished to use.
> 
> Wrong. The kernel time is simple and effective for almost all users.
> We are talking about _timeouts_ here, what fancy "attributes" does that 
> need that are just not overkill?

Or rather, posix timers ?

Daniel

