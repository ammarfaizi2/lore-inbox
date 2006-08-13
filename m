Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWHMWkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWHMWkd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWHMWkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:40:33 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:48134 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751698AbWHMWkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:40:32 -0400
Date: Mon, 14 Aug 2006 08:40:06 +1000
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [-mm patch] Kconfig: move CRYPTO to the "Cryptographic options" menu
Message-ID: <20060813224006.GA10592@gondor.apana.org.au>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210149.GR3543@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813210149.GR3543@stusta.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 11:01:49PM +0200, Adrian Bunk wrote:
> 
> This patch moves the CRYPTO option to the "Cryptographic options" menu
> (it was the only option directly in the toplevel menu).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanke you Adrian, patch applied.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
