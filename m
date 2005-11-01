Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVKAOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKAOvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKAOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:51:12 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:57760 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750822AbVKAOvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:51:11 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0511011358520.14884@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org>
	 <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au>
	 <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <Pine.LNX.4.58.0511011358520.14884@skynet>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:50:58 +0100
Message-Id: <1130856658.14475.79.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 14:41 +0000, Mel Gorman wrote:
> o Mechanism for taking regions of memory offline. Again, I think the
>   memory hotplug crowd have something for this. If they don't, one of them
>   will chime in.

I'm not sure what you're asking for here.

Right now, you can offline based on NUMA node, or physical address.
It's all revealed in sysfs.  Sounds like "regions" to me. :)

-- Dave

