Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVEBQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVEBQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVEBQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:58:33 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:6109 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261521AbVEBQz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:55:57 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 2 May 2005 09:56:00 -0700
From: Tony Lindgren <tony@atomide.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to coordinate moving subprojects to git
Message-ID: <20050502165600.GC16366@atomide.com>
References: <20050502163206.GA16366@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502163206.GA16366@atomide.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, incorrect address for Linus. Corrected in this one.

Tony

* Tony Lindgren <tony@atomide.com> [050502 09:41]:
> Hi Linus, Andrew & Len,
> 
> Here's a slightly modified repost of my earlier message
> that got eaten by the mailing list filter :)
> 
> I'm trying to summarize some earlier dicussions on how to
> coordinate moving BK projects over to git. This is probably
> of interest to many other subprojects as well.
> 
> My main problem is where to host git trees for subprojects.
> 
> Here's how I see the move to git happening for various
> subprojects:
> 
> - Somebody is rumored to offer a git project site soonish.[1]
>   When that is available, subprojects can configure git
>   trees there.
>   
> - Meanwhile, there should also be a BK repo for the latest
>   kernel changes available soon.[2] Once that is available,
>   it can be used for updating various trees.
> 
> Now I wonder if anybody has more news on the following:
> 
> - Who is working on setting a site available for git
>   projects, and when is that site estimated to be available?
>   
> - Is anybody working on mirroring git changes in a BK tree?
> 
> I'm afraid I can't be much of help here setting up these sites
> with my 128Kbps upstream speed...
> 
> Regards,
> 
> Tony
> 
> [1] http://lkml.org/lkml/2005/4/23/27
> [1] http://lkml.org/lkml/2005/4/26/32
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
