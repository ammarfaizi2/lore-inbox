Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDGFOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDGFOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 01:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVDGFOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 01:14:42 -0400
Received: from CPE-144-136-221-26.sa.bigpond.net.au ([144.136.221.26]:48139
	"EHLO modra.org") by vger.kernel.org with ESMTP id S261251AbVDGFOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 01:14:41 -0400
Date: Thu, 7 Apr 2005 14:44:39 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Marty Ridgeway <mridge@us.ibm.com>,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
Subject: Re: [ANNOUNCE] April Release of LTP now Available
Message-ID: <20050407051439.GK29412@bubble.modra.org>
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com> <20050406043001.3f3d7c1c.akpm@osdl.org> <16980.33841.943558.94159@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16980.33841.943558.94159@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:52:01AM +1000, Paul Mackerras wrote:
> Looks to me like gcc is objecting to our (ppc64's) _syscall2
> definition; Alan Modra (cc'd) can probably say what we're doing wrong.

I can't spot anything wrong.  Take a look at preprocessed source.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
