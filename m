Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267036AbVBFGx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267036AbVBFGx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbVBFGx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:53:28 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:19475 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S272798AbVBFGww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:52:52 -0500
Date: Sun, 6 Feb 2005 17:52:19 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050206065219.GD16057@gondor.apana.org.au>
References: <20050204221344.247548cb.davem@davemloft.net> <20050205064643.GA29758@gondor.apana.org.au> <20050205201044.1b95f4e8.davem@davemloft.net> <20050206.133723.124822665.yoshfuji@linux-ipv6.org> <20050205210411.7e18b8e6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205210411.7e18b8e6.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 09:04:11PM -0800, David S. Miller wrote:
> 
> Oh I see.  That would work, and it seems the simplest, and
> lowest risk fix for this problem.
> 
> Herbert, what do you think?

Yes I agree.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
