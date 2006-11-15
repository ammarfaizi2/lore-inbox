Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966562AbWKOA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966562AbWKOA6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966566AbWKOA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:58:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966562AbWKOA6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:58:16 -0500
Date: Tue, 14 Nov 2006 16:58:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
Message-Id: <20061114165806.753f0716.akpm@osdl.org>
In-Reply-To: <455A5E93.6050709@shadowen.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114184919.GA16020@skynet.ie>
	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	<20061114113120.d4c22b02.akpm@osdl.org>
	<455A5E93.6050709@shadowen.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 00:25:55 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> Seeing this too.  Will try this patch out on the affected machines.
> 
> If there are any others you recommend with it.  Yell.
> 

There are three, but kernel.org mirroring is taking *hours*, so I stuck
them in http://userweb.kernel.org/~akpm/hot-fixes/

