Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWCQQ5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWCQQ5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWCQQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:57:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:41638
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750946AbWCQQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:57:37 -0500
Date: Fri, 17 Mar 2006 08:57:23 -0800
From: Greg KH <greg@kroah.com>
To: Mark Lord <lkml@rtr.ca>, drzeus-sdhci@drzeus.cx
Cc: "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Sdhci-devel] Submission to the kernel?
Message-ID: <20060317165723.GA32281@kroah.com>
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AD537.5080403@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 10:26:47AM -0500, Mark Lord wrote:
> David J. Wallace wrote:
> >On Thursday 16 March 2006 23:53, David Liontooth wrote:
> >
> >>I would urge people to test Andrew's latest -mm kernel and report to
> >>lkml (cc him) on whether the sdhci driver works or causes any kind of
> >>problem. 
> 
> SDHCI seems to be working well on my Dell Inspiron 9300.
> 
> But I have concerns over maintenance of the code -- there does not
> seem to be a functioning (for me) email address for a maintainer.

Did you try the one listed in the MAINTAINERS portion of the patch:

	+SECURE DIGITAL HOST CONTROLLER INTERFACE DRIVER
	+P:	Pierre Ossman
	+M:	drzeus-sdhci@drzeus.cx
	+L:	sdhci-devel@list.drzeus.cx
	+W:	http://mmc.drzeus.cx/wiki/Linux/Drivers/sdhci
	+S:	Maintained

thanks,

greg k-h
