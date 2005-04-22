Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVDVHls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVDVHls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVDVHlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:41:47 -0400
Received: from main.gmane.org ([80.91.229.2]:1233 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262013AbVDVHlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:41:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Shaun Reitan" <mailinglists@unix-scripts.com>
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Date: Fri, 22 Apr 2005 00:40:05 -0700
Message-ID: <d4a9fv$jrf$1@sea.gmane.org>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com> <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com> <d3ugtr$gml$1@sea.gmane.org> <20050418060744.GA5057@gondor.apana.org.au>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-111-70-41.oc.oc.cox.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way i can trigger this bug rather than waiting for it to happen?
I would like to make sure it's not going to crash on me again.

--
Shaun Reitan


"Herbert Xu" <herbert@gondor.apana.org.au> wrote in message
news:20050418060744.GA5057@gondor.apana.org.au...
> On Sun, Apr 17, 2005 at 08:32:42PM +0000, Shaun Reitan wrote:
> > OK, finally got a full dump from the serial console!  Here is it!
>
> This was fixed about a month ago.  Here is the patch that did it.
>
> Perhaps it's time to include this in 2.6.11.*?
>
> Cheers,
> --
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>



