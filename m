Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWH2EPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWH2EPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWH2EPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:15:20 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:54437 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750776AbWH2EPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:15:18 -0400
Date: Tue, 29 Aug 2006 13:15:00 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Cc: linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net
Subject: Re: Step down from maintainerships
Message-ID: <20060829041500.GB9080@localhost.hsdv.com>
References: <20060829.081019.130229757.kkojima@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829.081019.130229757.kkojima@rr.iij4u.or.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kojima-san,

On Tue, Aug 29, 2006 at 08:10:19AM +0900, Kaz Kojima wrote:
> I think this is a time to step down from my SUPERH architecture
> maintainerships.  The major development issues for this port
> seem to shift on the hardwares I can't access and I have no
> recent activity on kernel.

The hardware thing is not that difficult of an issue to resolve, though
I realize you'd rather spend your time on the toolchain.

> I shouldn't qualify as a maintainer of SUPERH port now and there is no
> problem because Paul is actively maintaining it.  The attached patch
> drops my name, address and web URL from MAINTAINERS file.
> 
Thanks for all the work and years of finding bugs in my code, I hope
that this is a trend that will continue and we'll still see some future
contributions from you.

I suppose now I'll have to be more careful not to break the toolchain
:-)

> Signed-Off-By: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
