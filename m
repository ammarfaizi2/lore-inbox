Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVCYVXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVCYVXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVCYVXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:23:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8715 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261809AbVCYVWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:22:51 -0500
Date: Fri, 25 Mar 2005 21:22:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050325212234.F12715@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
	davem@davemloft.net, tony.luck@intel.com, benh@kernel.crashing.org,
	ak@suse.de, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>; from hugh@veritas.com on Wed, Mar 23, 2005 at 05:10:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 05:10:15PM +0000, Hugh Dickins wrote:
> Here's the recut of those patches, including David Miller's vital fixes.
> I'm addressing these to Nick rather than Andrew, because they're perhaps
> not fit for -mm until more testing done and the x86_64 32-bit vdso issue
> handled.  I'm unlikely to be responsive until next week, sorry: over to
> you, Nick - thanks.

I thought I'd try these out on ARM, but alas they don't apply to
2.6.12-rc1. ;(  This means I won't be testing them, sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
