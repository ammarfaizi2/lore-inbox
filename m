Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVAGAd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVAGAd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVAGAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:33:23 -0500
Received: from gprs215-35.eurotel.cz ([160.218.215.35]:649 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261154AbVAGAcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:32:51 -0500
Date: Fri, 7 Jan 2005 01:29:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: swsusp regression
Message-ID: <20050107002921.GA1300@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501061848.11719.rjw@sisk.pl> <20050106225233.GD2766@elf.ucw.cz> <200501070041.43023.rjw@sisk.pl> <20050106234829.GF28777@elf.ucw.cz> <1105057470.3254.0.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105057470.3254.0.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> AMD64 doesn't have MTRRs, does it? If it does, I'd bet on an SMP
> hang.

I bet AMD64 does have MTRRs. It is backward compatible to i386,
remember?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
