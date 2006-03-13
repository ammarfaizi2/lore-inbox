Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWCMKbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWCMKbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCMKbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:31:05 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:6668
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S932098AbWCMKbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:31:03 -0500
Date: Mon, 13 Mar 2006 21:30:58 +1100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add missing cra_alignmask
Message-ID: <20060313103058.GA7269@gondor.apana.org.au>
References: <20060308.231035.44604898.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308.231035.44604898.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:10:35PM +0900, Atsushi Nemoto wrote:
> The "des3_ede" and "serpent" lack cra_alignmask.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Patch applied.  Thanks a lot.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
