Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVBQP4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVBQP4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVBQP4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:56:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:38116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262263AbVBQP4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:56:01 -0500
Date: Thu, 17 Feb 2005 07:56:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <4214A437.8050900@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0502170754110.2383@ppc970.osdl.org>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Feb 2005, Nick Piggin wrote:
>
> I am pretty surprised myself that I was able to consolidate
> all "page table range" functions into a single type of iterator
> (well, there are a couple of variations, but it's not too bad).

Ok, this is post-2.6.11 material, so please remind me.

		Linus
