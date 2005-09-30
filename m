Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVI3UL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVI3UL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVI3UL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:11:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:38325 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030381AbVI3UL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:11:26 -0400
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Date: Fri, 30 Sep 2005 22:11:15 +0200
User-Agent: KMail/1.8
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       vandrove@vc.cvut.cz, clameter@engr.sgi.com, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, ananth@in.ibm.com
References: <20050919112912.18daf2eb.akpm@osdl.org> <20050930062853.GB3599@localhost.localdomain> <1128093382.10913.92.camel@serpentine.pathscale.com>
In-Reply-To: <1128093382.10913.92.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509302211.16259.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 17:16, Bryan O'Sullivan wrote:
> On Thu, 2005-09-29 at 23:28 -0700, Ravikiran G Thirumalai wrote:
> > Yes.
>
> Kiran, your patch works for me, too.  I can boot 2.6.14-rc2 with your
> patch, but not without it.
>
> Thanks for your help.

It's already on its way to Linus. Thanks Kiran.

BTW for my defense: my NUMA boxes booted just fine with the original patchkit.

-Andi
