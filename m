Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSFJEvH>; Mon, 10 Jun 2002 00:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSFJEvF>; Mon, 10 Jun 2002 00:51:05 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:25492 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316636AbSFJEvD>;
	Mon, 10 Jun 2002 00:51:03 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100451.VAA17135@csl.Stanford.EDU>
Subject: Re: [CHECKER] 18 potential missing unlocks in 2.4.17
To: davem@redhat.com (David S. Miller)
Date: Sun, 9 Jun 2002 21:50:59 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <20020609.213904.09568104.davem@redhat.com> from "David S. Miller" at Jun 09, 2002 09:39:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.17 is _REALLY_ old, any chance you can rerun these things
> on 2.4.19-pre10 by chance?

Any bets on how many bugs are still live? ;-)

> You should really investigate toning down the amount of hand frobbing
> you have to do to the kernel tree to get your experimental g++ to eat
> it.

We use gcc now, so the amount of frobbing is limited to getting as
many configure options set as possible.  

I'll do an update.  

Dawson
