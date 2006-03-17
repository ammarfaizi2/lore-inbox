Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWCQRBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWCQRBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCQRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:01:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43942
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751393AbWCQRBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:01:34 -0500
Date: Fri, 17 Mar 2006 09:01:26 -0800
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Mark Lord <lkml@rtr.ca>, "David J. Wallace" <katana@onetel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sdhci-devel@list.drzeus.cx
Subject: Re: [Sdhci-devel] Submission to the kernel?
Message-ID: <20060317170126.GB32281@kroah.com>
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AD9C3.2090703@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In looking at the patches in -mm, I see the following 5:
	secure-digital-host-controller-id-and-regs.patch
	secure-digital-host-controller-id-and-regs-fix.patch
	mmc-secure-digital-host-controller-interface-driver.patch
	mmc-secure-digital-host-controller-interface-driver-fix.patch
	mmc-sdhci-build-fix.patch

Is that all that is needed for this feature?

If so, I'll go try it out now...

thanks,

greg k-h
