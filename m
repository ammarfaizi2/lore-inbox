Return-Path: <linux-kernel-owner+w=401wt.eu-S1754069AbWL2FjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbWL2FjY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 00:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbWL2FjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 00:39:24 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:45698 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbWL2FjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 00:39:23 -0500
Date: Fri, 29 Dec 2006 07:39:30 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [-mm patch] infiniband/ulp/ipoib/ipoib_cm.c: make functions static
Message-ID: <20061229053930.GA4580@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061228024237.375a482f.akpm@osdl.org> <20061229021009.GN20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229021009.GN20714@stusta.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 29 Dec 2006 05:41:23.0593 (UTC) FILETIME=[F99EFF90:01C72B0B]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14902.001
X-TM-AS-Result: No--12.277200-4.000000-31
X-Spam: [F=0.0120901816; S=0.012(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quoting Adrian Bunk <bunk@stusta.de>:
> Subject: [-mm patch] infiniband/ulp/ipoib/ipoib_cm.c: make functions static
> 
> On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.20-rc1-mm1:
> >...
> >  git-infiniband.patch
> >...
> >  git trees
> >...
> 
> 
> This patch makes some needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks, I'll put this in my tree.

-- 
MST
