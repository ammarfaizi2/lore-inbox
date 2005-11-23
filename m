Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVKWWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVKWWyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKWWyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:54:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37510 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030454AbVKWWyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:54:02 -0500
Message-ID: <4384F307.6040904@pobox.com>
Date: Wed, 23 Nov 2005 17:53:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Grover <andrew.grover@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
In-Reply-To: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Grover wrote: > overall diffstat information: >
	drivers/Kconfig | 2 > drivers/Makefile | 1 > drivers/dma/Kconfig | 40
	++ > drivers/dma/Makefile | 5 > drivers/dma/cb_list.h | 12 >
	drivers/dma/dmaengine.c | 394 ++++++++++++++++++++++++ >
	drivers/dma/testclient.c | 132 ++++++++ > include/linux/dmaengine.h |
	268 ++++++++++++++++ > net/core/Makefile | 3 > net/core/dev.c | 78 ++++
	> net/core/user_dma.c | 422 ++++++++++++++++++++++++++ > 11 files
	changed, 1356 insertions(+), 1 deletion(-) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Grover wrote:
> overall diffstat information:
>  drivers/Kconfig           |    2 
>  drivers/Makefile          |    1 
>  drivers/dma/Kconfig       |   40 ++
>  drivers/dma/Makefile      |    5 
>  drivers/dma/cb_list.h     |   12 
>  drivers/dma/dmaengine.c   |  394 ++++++++++++++++++++++++
>  drivers/dma/testclient.c  |  132 ++++++++
>  include/linux/dmaengine.h |  268 ++++++++++++++++
>  net/core/Makefile         |    3 
>  net/core/dev.c            |   78 ++++
>  net/core/user_dma.c       |  422 ++++++++++++++++++++++++++
>  11 files changed, 1356 insertions(+), 1 deletion(-)


overall, there was a distinction lack of any useful 
description/documentation, over and above the code itself.

	Jeff


