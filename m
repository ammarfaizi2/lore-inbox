Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132827AbRDDO37>; Wed, 4 Apr 2001 10:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRDDO3y>; Wed, 4 Apr 2001 10:29:54 -0400
Received: from chiara.elte.hu ([157.181.150.200]:41228 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132827AbRDDO1R>;
	Wed, 4 Apr 2001 10:27:17 -0400
Date: Wed, 4 Apr 2001 15:25:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <lse-tech@lists.sourceforge.net>
Subject: Re: a quest for a better scheduler
In-Reply-To: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com>
Message-ID: <Pine.LNX.4.30.0104041524010.5382-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Apr 2001, Hubertus Franke wrote:

> It is not clear that yielding the same decision as the current
> scheduler is the ultimate goal to shoot for, but it allows
> comparision.

obviously the current scheduler is not cast into stone, it never was,
never will be.

but determining whether the current behavior is possible in a different
scheduler design is sure a good metric of how flexible that different
scheduler design is.

	Ingo

