Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWDQVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWDQVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDQVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:30:56 -0400
Received: from ns1.siteground.net ([207.218.208.2]:46533 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751285AbWDQVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:30:55 -0400
Date: Mon, 17 Apr 2006 14:32:01 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060417213201.GC3945@localhost.localdomain>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com> <20060329175446.67149f32.akpm@osdl.org> <1144660270.5816.3.camel@openx2.frec.bull.fr> <20060410012431.716d1000.akpm@osdl.org> <1144941999.2914.1.camel@openx2.frec.bull.fr> <20060417210746.GB3945@localhost.localdomain> <1145308176.2847.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145308176.2847.90.camel@laptopd505.fenrus.org>
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

On Mon, Apr 17, 2006 at 11:09:36PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> > 
> > 
> > I ran the same tests on a 16 core EM64T box very similar to the one
> > you ran
> > dbench on :). Dbench results on ext3 varies quite a bit.  I couldn't
> > get 
> > to a statistically significant conclusion  For eg,
> 
> 
> dbench is not a good performance benchmark. At all. Don't use it for
> that ;)

Agreed. (I did not mean to use it in the first place :).  I was just trying 
to verify the benchmark results posted earlier)

Thanks,
Kiran
