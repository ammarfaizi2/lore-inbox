Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSGSQJE>; Fri, 19 Jul 2002 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSGSQJE>; Fri, 19 Jul 2002 12:09:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45030 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316878AbSGSQJD>;
	Fri, 19 Jul 2002 12:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Date: Fri, 19 Jul 2002 11:08:44 -0400
User-Agent: KMail/1.4.1
References: <3D361091.13618.16DC46FB@localhost> <41821596.1026977488@[10.10.2.3]>
In-Reply-To: <41821596.1026977488@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207191108.44659.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 10:31 am, Martin J. Bligh wrote:
> > Do you think the breakdown is realistic?
>
> Here's a list of other things I am hoping to see merged:
>
> shared pagetables
> large page support
> NUMA aware multipath IO
> NUMA aware scheduler extensions
> ia32 discontigmem support for NUMA machines
> NUMA aware slab allocator
> CONFIG_NONLINEAR (in some form, quite possibly a cut down version)
> shared pagetables
> large page support
> rcu rtcache
> rcu dcache
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Thanks Martin.

I am confident that we will have large page support in 2.5 by then ready and 
tested as described at OLS.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
