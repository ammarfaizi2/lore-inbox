Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULMQSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULMQSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbULMQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:17:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18561 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261271AbULMQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:14:42 -0500
Date: Mon, 13 Dec 2004 17:14:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Stefan Seyfried <seife@suse.de>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213161441.GB27352@atrey.karlin.mff.cuni.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <Pine.LNX.4.61.0412130808010.22212@montezuma.fsmlabs.com> <20041213155955.D24748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213155955.D24748@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> See?  Measurements in reality give the true story.  Words are just
> that - words - which may not reflect reality.

On athlon64 notebook, HZ=1000 takes 1W of power. That's 5% of overall
power consumption, and as much as spinning disk takes. I'd say that's
rather significant.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
