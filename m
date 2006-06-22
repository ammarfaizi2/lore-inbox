Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWFVIfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWFVIfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWFVIfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:35:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30885
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932409AbWFVIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:35:05 -0400
Date: Thu, 22 Jun 2006 01:34:40 -0700 (PDT)
Message-Id: <20060622.013440.97293561.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: alan@lxorguk.ukuu.org.uk, snakebyte@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060622083037.GB26083@gondor.apana.org.au>
References: <20060622023029.GA6156@gondor.apana.org.au>
	<20060622.012609.25474139.davem@davemloft.net>
	<20060622083037.GB26083@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 22 Jun 2006 18:30:37 +1000

> On Thu, Jun 22, 2006 at 01:26:09AM -0700, David Miller wrote:
> >
> > Want me to let this cook in 2.6.18 for a while before sending
> > it off to -stable?
> 
> You know I'm never one to push anything quickly so absolutely yes :)

Ok, applied to net-2.6.18 for now :)
