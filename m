Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbUKSLvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUKSLvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKSLvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:51:42 -0500
Received: from gprs214-55.eurotel.cz ([160.218.214.55]:3712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261361AbUKSLva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:51:30 -0500
Date: Fri, 19 Nov 2004 12:49:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-ID: <20041119114904.GA1030@elf.ucw.cz>
References: <E1CUv66-0000HA-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUv66-0000HA-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Linux 2.6.10-rc1 works fairly well on the laptop, but Linux 2.6.10-rc2
> fails without comment in the middle of software suspend.  Upgrading to
> Linux 2.6.10-rc2-bk1 doesn't seem to help.  Most of the suspend output
> doesn't make it to the serial console, so i hand-copied it below.

Can you try minimum kernel config to see if it is driver breaking it?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
