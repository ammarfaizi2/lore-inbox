Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUBXJMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 04:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbUBXJMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 04:12:03 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:13954 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S262166AbUBXJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 04:12:01 -0500
Date: Tue, 24 Feb 2004 01:12:00 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-ID: <20040224091200.GA31360@dingdong.cryptoapps.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au> <4039B4E6.3050801@cyberone.com.au> <4039BE41.1000804@cyberone.com.au> <20040223005948.10a3b325.akpm@osdl.org> <20040223224723.GA27639@dingdong.cryptoapps.com> <403ACEFC.4070208@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403ACEFC.4070208@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 03:11:40PM +1100, Nick Piggin wrote:

> Out of interest, what is the worst you can make it do with
> contrived cases?

700MB slab used.


  --cw
