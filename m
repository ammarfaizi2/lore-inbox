Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSLTX3a>; Fri, 20 Dec 2002 18:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSLTX3a>; Fri, 20 Dec 2002 18:29:30 -0500
Received: from holomorphy.com ([66.224.33.161]:9928 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266408AbSLTX32>;
	Fri, 20 Dec 2002 18:29:28 -0500
Date: Fri, 20 Dec 2002 15:36:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
Subject: Re: [PATCH] Fix CPU bitmask truncation
Message-ID: <20021220233653.GG9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, bjorn_helgaas@hp.com
References: <200212161213.29230.bjorn_helgaas@hp.com> <20021220103028.GB9704@holomorphy.com> <20021220225714.GA10263@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220225714.GA10263@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Linus, this is the 2.5.x version of the same patch originally by Bjorn
>> for 2.4.x. This fixes an entire class of critical 64-bit bugs.
>> Against 2.5.52-bk as of 2:25AM 20 Dec 2002. Please apply.

On Sat, Dec 21, 2002 at 09:57:14AM +1100, Anton Blanchard wrote:
> Here's one in 2.5, found when adding 64 CPU support to ppc64.
> Anton

That was already included in the patch I sent, which was for 2.5.x.
I'll take this to mean the problem isn't solved in modern toolchains.

Linus, I think that pretty much settles it.


Bill
