Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWFVIaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWFVIaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWFVIaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:30:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:60164 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964950AbWFVIax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:30:53 -0400
Date: Thu, 22 Jun 2006 18:30:37 +1000
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, snakebyte@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
Message-ID: <20060622083037.GB26083@gondor.apana.org.au>
References: <1150909982.15275.100.camel@localhost.localdomain> <E1FtDU0-0005nd-00@gondolin.me.apana.org.au> <20060622023029.GA6156@gondor.apana.org.au> <20060622.012609.25474139.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622.012609.25474139.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:26:09AM -0700, David Miller wrote:
>
> Want me to let this cook in 2.6.18 for a while before sending
> it off to -stable?

You know I'm never one to push anything quickly so absolutely yes :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
