Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUKGVXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUKGVXs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKGVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:23:47 -0500
Received: from ozlabs.org ([203.10.76.45]:53637 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261681AbUKGVXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:23:46 -0500
Date: Mon, 8 Nov 2004 08:22:12 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107212212.GD16976@krispykreme.ozlabs.ibm.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com> <20041107192024.GM2890@holomorphy.com> <20041107193007.GC16976@krispykreme.ozlabs.ibm.com> <20041107210943.GN2890@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107210943.GN2890@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Nov 08, 2004 at 06:30:07AM +1100, Anton Blanchard wrote:
> > OK. We have not seen a similar issue on ppc64 even with extensive
> > testing (although with HPC apps). The question is how long we should
> > hold off on further hugetlb development waiting for this one bug report
> > on a single architecture to be chased.
> 
> Until it's fixed. Until then I'm considering it a byproduct of that same
> development. And with your report, that makes it two architectures, not
> one.

We _arent_ seeing it on ppc64. Can we at least have a complete bug
report if we are to halt all hugetlb development? At the moment we dont
have much information to go on at all.

Anton
