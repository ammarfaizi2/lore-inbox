Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbWCQRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWCQRPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWCQRPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:15:46 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:24978 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932746AbWCQRPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:15:45 -0500
Message-ID: <441AEEBB.10104@drzeus.cx>
Date: Fri, 17 Mar 2006 18:15:39 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] Submission to the kernel?
References: <4419FA7A.4050104@cogweb.net>	<200603171042.52589.katana@onetel.com>	<441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx> <20060317170126.GB32281@kroah.com>
In-Reply-To: <20060317170126.GB32281@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> In looking at the patches in -mm, I see the following 5:
> 	secure-digital-host-controller-id-and-regs.patch
> 	secure-digital-host-controller-id-and-regs-fix.patch
> 	mmc-secure-digital-host-controller-interface-driver.patch
> 	mmc-secure-digital-host-controller-interface-driver-fix.patch
> 	mmc-sdhci-build-fix.patch
>
> Is that all that is needed for this feature?
>
> If so, I'll go try it out now...
>   

That should be all yes.

Rgds
Pierre

