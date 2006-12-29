Return-Path: <linux-kernel-owner+w=401wt.eu-S1753715AbWL2JCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbWL2JCN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 04:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbWL2JCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 04:02:13 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:3514 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753715AbWL2JCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 04:02:11 -0500
Date: Fri, 29 Dec 2006 20:01:20 +1100
To: David Miller <davem@davemloft.net>
Cc: martin@strongswan.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] xfrm: Algorithm lookup using .compat name
Message-ID: <20061229090120.GA9108@gondor.apana.org.au>
References: <1166804803.21634.40.camel@martin> <20061222210446.GB22568@gondor.apana.org.au> <20061228.212851.93211529.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228.212851.93211529.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 09:28:51PM -0800, David Miller wrote:
> 
> Herbert, this fix is only needed for 2.6.20 correct?  I assume
> it was added by the 2.6.20 crypto layer merge, right?

Yes that's correct.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
