Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFAPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFAPDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVFAPBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:01:47 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:11455 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261407AbVFAPAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:00:00 -0400
Date: Wed, 1 Jun 2005 16:59:06 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050601144612.GJ5413@g5.random>
Message-Id: <Pine.OSF.4.05.10506011656280.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> On Wed, Jun 01, 2005 at 04:32:02PM +0200, Andrea Arcangeli wrote:
> > years of doing that in linux. I'm not a lawyer but you may want to
> > check before investing too much on this for the next 15 years. The
> 
> Here's a link that may be of interest:
> 
> http://www.fsmlabs.com/openpatentlicense.html
> http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=12&f=G&l=50&co1=AND&d=ptxt&s1=5,995,745&OS=5,995,745&RS=5,995,745
>
preempt RT doesn't use the described method. Thus no infringement.
 
> This means all preempt-RT users are forced to release all their userland
> code that runs with RT prio as GPL (not just the preempt-RT kernel
> patch). This is not the case with RTAI. This will expire in a matter of
> about 15 years so it's not too bad, and I was approximative when I've
> said preempt-RT infringe on the patent. You Ingo are perfectly safe,
> it's only the preempt-RT users that will infringe unless all their RT
> code is GPL'd.
> 
> This is JFYI.
> 

Maybe you should get yourself a job as FUD'er? You surely have the
qualifications jumping to conclusions like that.
Ok, now you are FUD'ing on behalf on RTAI, but that doesn't make any less
disgracefull.

Esben

