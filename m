Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUBVIgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 03:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUBVIgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 03:36:39 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:60800 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261200AbUBVIgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 03:36:38 -0500
Date: Sun, 22 Feb 2004 00:36:37 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222083637.GA15589@dingdong.cryptoapps.com>
References: <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com> <4038402A.4030708@cyberone.com.au> <40384325.1010802@matchmail.com> <403845CB.8040805@cyberone.com.au> <20040221221721.42e734d6.akpm@osdl.org> <40384D9D.6040604@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40384D9D.6040604@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 05:35:09PM +1100, Nick Piggin wrote:

> Can you maybe use this patch then, please?

I probably need to do more testing, but the quick patch I was using
against mainline (bk head) works better than this against 2.5.3-mm2.

I'll poke about more tomorrow.  Time for some z's now.



