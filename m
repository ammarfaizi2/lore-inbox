Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUKWOtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUKWOtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUKWOtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:49:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261275AbUKWOst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:48:49 -0500
Date: Tue, 23 Nov 2004 15:48:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: umbrella-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Umbrella-0.5.1 stable released
Message-ID: <20041123144812.GB13174@suse.de>
References: <200411231544.09701.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411231544.09701.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23 2004, Kristian Sørensen wrote:
> Hi all!
> 
> We are pleased to inform you that Umbrella 0.5.1 is now released. This is a 
> very stable release, which has been tested on our workstations for 6+ days 
> continously.
> 
> Get the release here: 
> http://prdownloads.sourceforge.net/umbrella/umbrella-0.5.1.tar.bz2?download
> 
> The strategy of the further development of Umbrella is to have
> * STABLE and well tested Umbrella as patches 
> * UNSTABLE bleeding edge technology in the CVS module umbrella-devel
> 
> 
> We have lots of new stuff and optimizations in the CVS, which slowley will be 
> applied and tested before getting realeased as patches. Currently we have 
> these in the CVS:
> * New, small and efficient bit vector
> * New datastructure for storing restrictions
>    See this thread for details: 
>    http://sourceforge.net/mailarchive/forum.php?thread_id=5886152&forum_id=42079
> * Restrictions on process signaling
> * Authentication of binaries (still under development for the 0.6 release)

And umbrella is?

-- 
Jens Axboe

