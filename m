Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUBVGRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUBVGRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:17:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:57822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbUBVGQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:16:59 -0500
Date: Sat, 21 Feb 2004 22:17:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mfedyk@matchmail.com, cw@f00f.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040221221721.42e734d6.akpm@osdl.org>
In-Reply-To: <403845CB.8040805@cyberone.com.au>
References: <4037FCDA.4060501@matchmail.com>
	<20040222023638.GA13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
	<20040222031113.GB13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
	<20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Fair enough. Maybe if we can get enough testing, some of the mm
>  changes can get into 2.6.4? I'm sure Linus is turning pale, maybe
>  we'd better wait until 2.6.10 ;)

I need to alight from my lazy tail and test them a bit^Wlot first.  More
like 2.6.5.

