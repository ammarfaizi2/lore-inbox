Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUKSL5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUKSL5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUKSL5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:57:31 -0500
Received: from gprs214-55.eurotel.cz ([160.218.214.55]:6016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261362AbUKSLzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:55:18 -0500
Date: Fri, 19 Nov 2004 12:55:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some machines
Message-ID: <20041119115507.GB1030@elf.ucw.cz>
References: <1100811950.3470.23.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100811950.3470.23.camel@mhcln03>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm in the process of debugging S3 on my notebook and found out that I
> can resume from S3 with every kernel up to (and including) 2.6.7-rc1
> ( patch-2.6.6-bk8-bk9.bz2 ).

You can resume and your video works after resume in 2.6.7? Great!

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
