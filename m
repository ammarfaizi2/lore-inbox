Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932367AbWFEBGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWFEBGj (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFEBGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:06:39 -0400
Received: from havoc.gtf.org ([69.61.125.42]:37775 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932367AbWFEBGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:06:37 -0400
Date: Sun, 4 Jun 2006 21:06:36 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linville@tuxdriver.com
Subject: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605010636.GB17361@havoc.gtf.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> acx1xx-wireless-driver.patch
> fix-tiacx-on-alpha.patch
> tiacx-fix-attribute-packed-warnings.patch
> tiacx-pci-build-fix.patch
> tiacx-ia64-fix.patch
> 
>   It is about time we did something with this large and presumably useful
>   wireless driver.

I've never had technical objections to merging this, just AFAIK it had a
highly questionable origin, namely being reverse-engineered in a
non-clean-room environment that might leave Linux legally vulnerable.

If we can clear that hurdle, by all means pass it on to John Linville
and get it moving towards upstream.

	Jeff



