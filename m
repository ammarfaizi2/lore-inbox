Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFAVIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFAVIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFAVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:05:40 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:34968 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261259AbVFAVFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:05:14 -0400
Date: Wed, 1 Jun 2005 17:05:10 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601210510.GL23488@csclub.uwaterloo.ca>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601204350.GM23621@csclub.uwaterloo.ca> <20050601205451.GR20782@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601205451.GR20782@holomorphy.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:54:51PM -0700, William Lee Irwin III wrote:
> Linux does not entail subscription to hardware upgrade treadmills. No
> one should be forced by "peer pressure" or Linux deficiencies to buy
> new hardware. And this is the single greatest thing about Linux ever.

Sure, I still use a 486 with linux for some jobs, but I am realistic
about what I can expect from that level of hardware.

> O_LARGEFILE and current mmap() code will save him the cost of newer
> hardware for the near term, and should he be particularly strapped for
> cash later on when more than 16TB is needed, he knows to look at making
> pgoff_t and/or swp_entry_t 64-bit on his own. There is no need for new
> hardware, merely a choice between money and programming effort should
> he break the 16TB barrier.

True, although I would think anyone doing actual work on that kind of
data size would be using fairly new hardware anyhow.

If you have to write all sorts of complex algorithms to work around a
limitation in your current hardware, perhaps it is cheaper to buy newer
hardware without that limitation.  Ofcourse if you are working on things
in your spare time for free, then hardware upgrades are always the most
expensive solution.

Len Sorensen
