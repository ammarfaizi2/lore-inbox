Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWHTWFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWHTWFx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWHTWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:05:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24530 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751195AbWHTWFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:05:53 -0400
Date: Mon, 21 Aug 2006 00:05:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Patrick McFarland <diablod3@gmail.com>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
Message-ID: <20060820220538.GA10011@opteron.random>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com> <1155807431.22871.157.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155807431.22871.157.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:37:11AM +0100, David Woodhouse wrote:
> But _even_ if GregKH, Arjan and all of IBM's lawyers are wrong and we

I agree about the rest and I'm certainly not trying to make life easy
to the binary only drivers, but for completeness I'd like to add that
IBM at some point released binary only drivers for some virtual device
on s390. I think they're all GPL by now, but my point remains that
even IBM must have thought they could legally ship binary only drivers
in the past (like everybody else did until recently after all).

My only worry is what's the legal status of the vsyscall if the only
thing that matters is the COPYING file and not its generally agreed
interpretation.
