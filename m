Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264323AbUEMRcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbUEMRcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbUEMRcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:32:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25797 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264323AbUEMRc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:32:28 -0400
Date: Thu, 13 May 2004 19:32:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040513173227.GE4506@atrey.karlin.mff.cuni.cz>
References: <20040512235623.GA9234@atomide.com> <20040513162643.GA4506@atrey.karlin.mff.cuni.cz> <20040513171921.GB28678@atomide.com> <20040513172116.GD4506@atrey.karlin.mff.cuni.cz> <20040513173132.GE28678@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513173132.GE28678@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > This patch is okay if you insert modules in right order, but not if
> > you attempt to insert cpufreq before acpi, right?
> 
> For me modprobe powernow-k8 automatically also loads processor.
> 
> > Please do not make that go in like it is.
> 
> What would you suggest?

Really? Things might have changed from last time. If it is so, perhaps
patch is okay...
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
