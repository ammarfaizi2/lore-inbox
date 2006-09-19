Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWISVHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWISVHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWISVHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:07:47 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:55960 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1750837AbWISVHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:07:46 -0400
Date: Tue, 19 Sep 2006 14:07:44 -0700
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Message-ID: <20060919210744.GE4617@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <200609190804.14786.ak@suse.de> <20060919062828.GD7845@chain.digitalkingdom.org> <200609190839.51123.ak@suse.de> <20060919174649.GE7845@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919174649.GE7845@chain.digitalkingdom.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 10:46:49AM -0700,  wrote:
> Unfortunately, the machines that actually got as far as
> *displaying* an MCE were the ones with 16GiB in them, and I could
> no longer justify holding on to them just for kernel testing; as
> you can imagine, they're a tad expensive.

New developments:

1.  I will have access to one of the 16GiB boxes within the next few
days.

2.  The *un-released* 2.09 BIOS upgrade from Arima seems to solve
the issue.

Given that, if you'd like to just call it good, I'd totally
understand.  I'm also fine with continuing to help debug this; it's
entirely up to you guys.

I *really* appreciate all the help, too, particularily from Alan and
Andi.  If you guys have Amazon lists or something I can throw a
thank-you at, let me know.

(Unfortunately, upgrading the BIOS clears all the settings,
including console redirection, and we have over 200 of these
machines...  Not your problem of course, just venting.)

-Robin
