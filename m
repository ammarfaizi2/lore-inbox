Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756927AbWKVGzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbWKVGzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756929AbWKVGzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:55:21 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:10505 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1756927AbWKVGzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:55:20 -0500
Date: Wed, 22 Nov 2006 17:55:17 +1100
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [2.6 patch] crypto/: remove unused functions
Message-ID: <20061122065517.GA16985@gondor.apana.org.au>
References: <20061121194324.GK5200@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121194324.GK5200@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 08:43:24PM +0100, Adrian Bunk wrote:
> This patch removes the following no longer used functions:
> - api.c: crypto_alg_available()
> - digest.c: crypto_digest_init()
> - digest.c: crypto_digest_update()
> - digest.c: crypto_digest_final()
> - digest.c: crypto_digest_digest()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Patch applied.  Thanks Adrian.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
