Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVI3UXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVI3UXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVI3UXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:23:33 -0400
Received: from serv01.siteground.net ([70.85.91.68]:8350 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030384AbVI3UXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:23:32 -0400
Date: Fri, 30 Sep 2005 13:23:21 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Andrew Morton <akpm@osdl.org>,
       vandrove@vc.cvut.cz, clameter@engr.sgi.com, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, ananth@in.ibm.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-ID: <20050930202321.GB3669@localhost.localdomain>
References: <20050919112912.18daf2eb.akpm@osdl.org> <20050930062853.GB3599@localhost.localdomain> <1128093382.10913.92.camel@serpentine.pathscale.com> <200509302211.16259.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509302211.16259.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 10:11:15PM +0200, Andi Kleen wrote:
> On Friday 30 September 2005 17:16, Bryan O'Sullivan wrote:
> > On Thu, 2005-09-29 at 23:28 -0700, Ravikiran G Thirumalai wrote:
> > > Yes.
> >
> > Kiran, your patch works for me, too.  I can boot 2.6.14-rc2 with your
> > patch, but not without it.
> >
> > Thanks for your help.
> 
> It's already on its way to Linus. Thanks Kiran.

Thanks are also due to Alok for spending long hours trying out all combinations
on Petr's box.  Thanks Alok.

Kiran
