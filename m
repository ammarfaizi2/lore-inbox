Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136767AbREAXVq>; Tue, 1 May 2001 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136766AbREAXVe>; Tue, 1 May 2001 19:21:34 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:5380 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136764AbREAXVX>;
	Tue, 1 May 2001 19:21:23 -0400
Date: Wed, 2 May 2001 01:21:22 +0200
From: Frank de Lange <frank@unternet.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: * Re: Severe trashing in 2.4.4
Message-ID: <20010502012122.B23616@unternet.org>
In-Reply-To: <20010501235046.A23616@unternet.org> <15087.16421.328004.457998@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15087.16421.328004.457998@pizda.ninka.net>; from davem@redhat.com on Tue, May 01, 2001 at 04:00:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 04:00:53PM -0700, David S. Miller wrote:
> 
> Frank, thanks for doing all the legwork to resolve the networking
> side of this problem.

No problem...

I just diff'd the 'old' and 'new' kernel trees. The one which produced the
ravenous skb_hungry kernels was for all intents and purposed identical to the
one which produced the (working, bug_free(tm)) kernel I'm currently running...

Must be the weather...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
