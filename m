Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWJKMci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWJKMci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWJKMci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:32:38 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:2317 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751236AbWJKMci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:32:38 -0400
Date: Wed, 11 Oct 2006 22:32:27 +1000
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: mark crypto_alloc_tfm() __deprecated
Message-ID: <20061011123227.GA9159@gondor.apana.org.au>
References: <20061010124840.GB17432@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010124840.GB17432@localhost>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 09:48:40PM +0900, Akinobu Mita wrote:
> This patch marks crypto_alloc_tfm() as __deprecated.
> And converts from crypto_alloc_tfm() to crypto_alloc_comp() in
> tcrypt crypto testing module.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks, I've applied both of your patches.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
