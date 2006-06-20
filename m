Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWFTK1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWFTK1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFTK1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:27:53 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:51467 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932584AbWFTK1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:27:52 -0400
Date: Tue, 20 Jun 2006 20:27:49 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060620102749.GA13851@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <Pine.LNX.4.64.0606181551580.17704@scrub.home> <20060619061813.GA28582@gondor.apana.org.au> <200606191612.37744.jfritschi@freenet.de> <20060620102611.GA13801@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620102611.GA13801@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 08:26:11PM +1000, herbert wrote:
> 
> BTW, I had to add a few missing bits to twofish_common.c.  Next time
> please make sure that you provide at least a MODULE_LICENSE and a
> module_exit function.

Actually a module_exit function isn't required in this case but a
licence certainly is.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
