Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVLAUnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVLAUnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbVLAUnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:43:49 -0500
Received: from mx1.suse.de ([195.135.220.2]:27303 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751721AbVLAUnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:43:49 -0500
Date: Thu, 1 Dec 2005 21:43:39 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Display HPET timer option
Message-ID: <20051201204339.GC997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com> <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org> <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> On Thu, 1 Dec 2005, Linus Torvalds wrote:
> 
> > 
> > 
> > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > >
> > > Currently the HPET timer option isn't visible in menuconfig.
> > 
> > Do you want it to?
> > 
> > Why would you ever compile it out?
> 
> For timer testing purposes i sometimes would like not to use the HPET. 
> Would a runtime switch be preferred?

nohpet already exists.

-Andi
