Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUHUOOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUHUOOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUHUOOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:14:34 -0400
Received: from waste.org ([209.173.204.2]:23432 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266453AbUHUOOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:14:32 -0400
Date: Sat, 21 Aug 2004 09:14:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ketchup - support new -post releases
Message-ID: <20040821141417.GR31237@waste.org>
References: <1093021608.15662.1228.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093021608.15662.1228.camel@nighthawk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:06:48AM -0700, Dave Hansen wrote:
> Since 2.6.8.1 came out, I'm sure a lot of automated tools stopped
> working, ketchup included. 
> 
> I'm sure this patch isn't complete, but it does work to patch from 2.6.8
> -> 2.6.8.1 or 2.6.8.1-mm*, so it is at least a start. 

Unfortunately, we don't yet know how deltas from x.y.z.1 to x.y.z.2
will be handled in the archives, eg relative to x.y.z or incrementally.

-- 
Mathematics is the supreme nostalgia of our time.
