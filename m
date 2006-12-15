Return-Path: <linux-kernel-owner+w=401wt.eu-S1752900AbWLOQ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbWLOQ57 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbWLOQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:57:58 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:52490 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902AbWLOQ56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:57:58 -0500
Subject: Re: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
From: Steve Wise <swise@opengridcomputing.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4580E3D7.3050708@chelsio.com>
References: <4580E3D7.3050708@chelsio.com>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 10:57:58 -0600
Message-Id: <1166201878.2304.11.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeff,

Is this driver in your queue for merging?  The Chelsio T3 RDMA driver
that depends on the T3 Ethernet driver is also ready to be merged.

I was just wondering if its in queue, or if there is something else we
need to do.

Thanks,

Steve.


On Wed, 2006-12-13 at 21:40 -0800, Divy Le Ray wrote:
> Jeff,
> 
> I resubmit the patch supporting the latest Chelsio T3 adapter.
> It incorporates the last feedbacks for code cleanup.
> It is built gainst Linus'tree.
> 
> We think the driver is now ready to be merged.
> Can you please advise on the next steps for inclusion in 2.6.20 ?
> 
> A corresponding monolithic patch is posted at the following URL:
> http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
> 
> This driver is required by the Chelsio T3 RDMA driver
> which was updated on 12/10/2006.
> 
> Cheers,
> Divy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

