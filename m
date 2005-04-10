Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVDJJTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVDJJTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDJJTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:19:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18705 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261449AbVDJJTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:19:09 -0400
Date: Sun, 10 Apr 2005 19:18:20 +1000
To: Adrian Bunk <bunk@stusta.de>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/api.c: make crypto_alg_lookup static
Message-ID: <20050410091818.GA26119@gondor.apana.org.au>
References: <20050409193841.GK3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409193841.GK3632@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 09:38:41PM +0200, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

Thanks Adrian, patch applied.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
