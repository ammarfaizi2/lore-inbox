Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVJFPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVJFPPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVJFPPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:15:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:3028 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751085AbVJFPPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:15:16 -0400
Date: Thu, 6 Oct 2005 16:15:15 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Paul Jackson <pj@sgi.com>
Cc: linux-mm@kvack.org, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/7] Fragmentation Avoidance V16: 001_antidefrag_flags
In-Reply-To: <20051006081128.62c9ab1f.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0510061614370.1255@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
 <20051005144552.11796.52857.sendpatchset@skynet.csn.ul.ie>
 <20051006081128.62c9ab1f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Paul Jackson wrote:

> Mel wrote:
> > +/* Allocation type modifiers, group together if possible */
>
> Isn't that "if possible" bogus.  I thought these two bits
> _had_ to be grouped together, at least with the current code.
>
> What happened to the comment that Joel added to gpl.h:
>

My bad. I missed it while resyncing with Joel. I have it in now.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
