Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVI3G3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVI3G3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVI3G3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:29:14 -0400
Received: from serv01.siteground.net ([70.85.91.68]:50157 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932396AbVI3G3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:29:13 -0400
Date: Thu, 29 Sep 2005 23:28:53 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: vandrove@vc.cvut.cz, clameter@engr.sgi.com, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, ananth@in.ibm.com, ak@suse.de
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-ID: <20050930062853.GB3599@localhost.localdomain>
References: <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz> <20050930054556.GA3599@localhost.localdomain> <20050929230540.6a8651fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929230540.6a8651fa.akpm@osdl.org>
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

On Thu, Sep 29, 2005 at 11:05:40PM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> Is this fix independent from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/x86_64-fix-the-bp-node_to_cpumask.patch
> ?

Yes. 
