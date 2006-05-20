Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWETV1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWETV1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWETV1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:27:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:50847 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932375AbWETV1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:27:41 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Date: Sat, 20 May 2006 23:27:18 +0200
User-Agent: KMail/1.9.1
Cc: Mel Gorman <mel@csn.ul.ie>, davej@codemonkey.org.uk, tony.luck@intel.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
References: <20060508141030.26912.93090.sendpatchset@skynet> <20060508141151.26912.15976.sendpatchset@skynet> <20060520135922.129a481d.akpm@osdl.org>
In-Reply-To: <20060520135922.129a481d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605202327.19606.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway.  From the implementation I can see what the code is doing.  But I
> see no description of what it is _supposed_ to be doing.  (The process of
> finding differences between these two things is known as "debugging").  I
> could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough. 
> I look forward to the next version ;)

Or we could just keep the working old code.

Can somebody remind me what this patch kit was supposed to fix or improve again? 

-Andi
