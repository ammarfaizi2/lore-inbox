Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129293AbQKBVHg>; Thu, 2 Nov 2000 16:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129366AbQKBVH1>; Thu, 2 Nov 2000 16:07:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:23304 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129293AbQKBVHO>;
	Thu, 2 Nov 2000 16:07:14 -0500
Date: Thu, 2 Nov 2000 22:06:34 +0100
Message-Id: <200011022106.WAA18428@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: Tim@Rikers.org (Tim Riker)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A01D463.9ADEF3AF@Rikers.org>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A01D463.9ADEF3AF@Rikers.org> you wrote:
> As is being discussed here, C99 has some replacements to the gcc syntax
> the kernel uses. I believe the C99 syntax will win in the near future,
> and thus the gcc syntax will have to be removed at some point. In the
> interim the kernel will either move towards supporting both, or a
> quantum jump to support the new gcc3+ compiler only. I am hoping a
> little thought can get put into this such that this change will be less
> painful down the road.

BTW: the C99 syntax for named structure initializers is supported from
gcc 2.7.<something> on. But a policy decision has been take to use
gcc synta in kernel.

	Christoph


-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
