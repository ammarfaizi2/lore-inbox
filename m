Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWC1GQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWC1GQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 01:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC1GQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 01:16:43 -0500
Received: from relay01.pair.com ([209.68.5.15]:11274 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1750984AbWC1GQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 01:16:43 -0500
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: ck@vds.kolivas.org
Subject: Re: [ck] swap prefetching merge plans
Date: Tue, 28 Mar 2006 00:16:15 -0600
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603280016.38327.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 01:04, Con Kolivas wrote:
> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.  I've come
> to depend on it with my workloads now so I'm never dropping it. There's no
> point me explaining how it is useful yet again, though, because I just end
> up looking like I'm handwaving. It seems a shame for it not to be available
> to all linux users.

Another happy prefetch user chiming in (sadly, without rigorous scientific 
research -- my team of monkeys is too busy at the moment). In my case, I have 
a gig of RAM, but I'm a pig when it comes to leaving applications open. 

Testimonials may not meet the appropriate criteria for merging a patch; I 
hope, though, that the aggregate value of these messages, in considering this 
issue, is more than that of mere noise.

> Cheers,
> Con

Thanks,
Chase
