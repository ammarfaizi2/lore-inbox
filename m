Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWFSGSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWFSGSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 02:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFSGSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 02:18:33 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:41740 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750922AbWFSGSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 02:18:32 -0400
Date: Mon, 19 Jun 2006 16:18:13 +1000
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Joachim Fritschi <jfritschi@freenet.de>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
Message-ID: <20060619061813.GA28582@gondor.apana.org.au>
References: <200606041516.21967.jfritschi@freenet.de> <200606080920.04480.jfritschi@freenet.de> <20060608072735.GA10613@gondor.apana.org.au> <200606161358.53036.jfritschi@freenet.de> <20060618113138.GA22097@gondor.apana.org.au> <Pine.LNX.4.64.0606181551580.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606181551580.17704@scrub.home>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 03:53:36PM +0200, Roman Zippel wrote:
>
> > Please drop the help (it's not meant to be visible) and add a 'default n'
> > instead.
> 
> The help text is also useful as documentation and doesn't hurt.
> 'n' is the default already, so it's not needed.

Thanks for the correction Roman.

Joachim, please rebase your patch on the cryptodev tree and resend.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
