Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVDRGZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVDRGZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDRGZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:25:22 -0400
Received: from zoe.ndcservers.net ([216.23.188.144]:55432 "EHLO
	zoe.ndcservers.net") by vger.kernel.org with ESMTP id S261758AbVDRGZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:25:15 -0400
Message-ID: <0c8c01c543df$63f84470$0201a8c0@ndciwkst01>
From: "Shaun Reitan" <mailinglists@unix-scripts.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: <linux-kernel@vger.kernel.org>, <stable@kernel.org>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com> <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com> <d3ugtr$gml$1@sea.gmane.org> <20050418060744.GA5057@gondor.apana.org.au>
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Date: Sun, 17 Apr 2005 23:25:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zoe.ndcservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unix-scripts.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually ran accross that patch this morning on the ebtables lists but i
wasnt sure it would fix the problem i was having.  I will get this patched
into the kernel and see what happens.  Thanks  for the responce, if this
went on much longer this $4,000 machine was going to become a paper weight
:)

Best Regards,

Shaun Reitan


----- Original Message -----
From: "Herbert Xu" <herbert@gondor.apana.org.au>
To: "Shaun Reitan" <mailinglists@unix-scripts.com>
Cc: <linux-kernel@vger.kernel.org>; <stable@kernel.org>
Sent: Sunday, April 17, 2005 11:07 PM
Subject: Re: kernel panic - not syncing: Fatal exception in interupt


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

