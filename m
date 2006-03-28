Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWC1O0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWC1O0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWC1O0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:26:41 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:14466 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932183AbWC1O0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:26:41 -0500
Date: Tue, 28 Mar 2006 16:26:39 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060328142639.GE14576@MAIL.13thfloor.at>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4428FB29.8020402@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 07:00:25PM +1000, Nick Piggin wrote:
> Herbert Poetzl wrote:
> 
> >well, that largely depends on the 'use' ...
> >
> >I don't think that vps providers like lycos would be
> >very happy if they had to multiply the ammount of
> >machines they require by 10 or 20 :)
> >
> >and yes, running 100 and more Linux-VServers on a
> >single machine _is_ realistic ...
> >
> 
> Yep.
> 
> And if it is intrusive to the core kernel, then as always we have to
> try to evaluate the question "is it worth it"? How many people want it
> and what alternatives do they have (eg. maintaining seperate patches,
> using another approach), what are the costs, complexities, to other
> users and developers etc.

my words, but let me ask, what do you consider 'intrusive'?

best,
Herbert

> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 
