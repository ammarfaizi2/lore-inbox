Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUJNSkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUJNSkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUJNSaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:30:17 -0400
Received: from gprs212-8.eurotel.cz ([160.218.212.8]:58242 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266870AbUJNRjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:39:24 -0400
Date: Thu, 14 Oct 2004 19:39:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Message-ID: <20041014173908.GC3786@elf.ucw.cz>
References: <16733.50382.569265.183099@segfault.boston.redhat.com> <20041003194831.GB3089@openzaurus.ucw.cz> <16749.15265.475571.767534@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16749.15265.475571.767534@segfault.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> pavel> Does it have comparable performance to aio?
> 
> I haven't run any tests.  One advantage this has to current aio is that it
> can operate without O_DIRECT.

Well, second advantage is that it is much nicer interface...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
