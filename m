Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKURFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKURFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVKURFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:05:20 -0500
Received: from ns2.suse.de ([195.135.220.15]:24510 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932337AbVKURFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:05:20 -0500
Date: Mon, 21 Nov 2005 18:05:17 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121170517.GA20775@brahms.suse.de>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random> <20051121164349.GE14746@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121164349.GE14746@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 05:43:49PM +0100, Andrea Arcangeli wrote:
> Since there was no feedback to my last post, I assume you agree, so
> please backout the tsc disable so then I can plug the performane counter
> disable on top of it (at zero additional runtime cost).

Sorry I don't agree.

-Andi
