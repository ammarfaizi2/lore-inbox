Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSLIOEF>; Mon, 9 Dec 2002 09:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSLIOEF>; Mon, 9 Dec 2002 09:04:05 -0500
Received: from dp.samba.org ([66.70.73.150]:13211 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265541AbSLIOED>;
	Mon, 9 Dec 2002 09:04:03 -0500
Date: Tue, 10 Dec 2002 01:08:20 +1100
From: Anton Blanchard <anton@samba.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
Message-ID: <20021209140820.GB5585@krispykreme>
References: <20021208130908.GE19698@krispykreme> <Pine.LNX.4.50L.0212081246570.21756-100000@imladris.surriel.com> <Pine.LNX.4.50L.0212081444350.21756-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212081444350.21756-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Rik,

> In particular, something like the (completely untested) patch
> below.  Yes, this patch is on the wrong side of the space/time
> tradeoff for machines with highmem, but it might be worth it
> for 64 bit machines, especially those with slow bitops.

I'll give it a spin when I next get some time on the machine.

Anton
