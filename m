Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWG3V5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWG3V5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWG3V5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:57:10 -0400
Received: from colin.muc.de ([193.149.48.1]:42762 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932418AbWG3V5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:57:09 -0400
Date: 30 Jul 2006 23:57:05 +0200
Date: Sun, 30 Jul 2006 23:57:05 +0200
From: Andi Kleen <ak@muc.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730215705.GA90965@muc.de>
References: <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de> <20060730211359.GZ3662@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730211359.GZ3662@kiste.smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least the different CPU speed issue is a known bug, fixed by a
> BIOS update.

That will likely fix your problem without changing the kernel.
Please try it.

> I'll postpone that until we have a working kernel fix,
> for obvious reasons.

What are the obvious reasons?

-Andi

