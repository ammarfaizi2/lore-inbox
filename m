Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUBXJWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 04:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUBXJWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 04:22:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:13282 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbUBXJWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 04:22:18 -0500
Date: Tue, 24 Feb 2004 01:22:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-Id: <20040224012222.453e7db7.akpm@osdl.org>
In-Reply-To: <20040224091200.GA31360@dingdong.cryptoapps.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<40395ACE.4030203@cyberone.com.au>
	<20040222175507.558a5b3d.akpm@osdl.org>
	<40396ACD.7090109@cyberone.com.au>
	<40396DA7.70200@cyberone.com.au>
	<4039B4E6.3050801@cyberone.com.au>
	<4039BE41.1000804@cyberone.com.au>
	<20040223005948.10a3b325.akpm@osdl.org>
	<20040223224723.GA27639@dingdong.cryptoapps.com>
	<403ACEFC.4070208@cyberone.com.au>
	<20040224091200.GA31360@dingdong.cryptoapps.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Tue, Feb 24, 2004 at 03:11:40PM +1100, Nick Piggin wrote:
> 
> > Out of interest, what is the worst you can make it do with
> > contrived cases?
> 
> 700MB slab used.
> 

Sigh.  There is absolutely nothing wrong with having a large slab cache. 
And there is nothing necessarily right about having a small one.

Sorry, but your comment is information-free.

