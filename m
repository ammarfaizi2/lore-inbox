Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUKGR2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUKGR2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUKGR2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:28:08 -0500
Received: from ozlabs.org ([203.10.76.45]:60289 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261658AbUKGRZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:25:51 -0500
Date: Mon, 8 Nov 2004 04:20:30 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107172030.GA16976@krispykreme.ozlabs.ibm.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029034817.GY12934@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Further consolidation is premature given that outstanding hugetlb bugs
> have the implication that architectures' needs are not being served by
> the current arch/core split. I have at least two relatively major hugetlb
> bugs outstanding, the lack of a flush_dcache_page() analogue first, and
> another (soon to be a reported to affected distros) less well-understood.
> Unless they're directly toward the end of restoring hugetlb to a sound
> state, they're counterproductive to merge before patches doing so.

Could you point me at a summary of these 2 issues? 

Anton
