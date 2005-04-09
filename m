Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVDIJtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDIJtv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDIJtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:49:51 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30736 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261320AbVDIJtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:49:50 -0400
Date: Sat, 9 Apr 2005 19:48:14 +1000
To: Magnus Damm <magnus.damm@gmail.com>
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
Message-ID: <20050409094814.GA5953@gondor.apana.org.au>
References: <aec7e5c305040711535bbe07d3@mail.gmail.com> <E1DK4zA-0005rr-00@gondolin.me.apana.org.au> <aec7e5c3050409024365d724dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c3050409024365d724dd@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 11:43:59AM +0200, Magnus Damm wrote:
>
> > Perhaps your favourite distribution could build that as a module to
> > start with.
> 
> Right. Today distributions can boot from external usb-storage devices,
> maybe even from firewire hardware as I am sure you know. I guess they
> have support for a device built-in for a reason. I think most

Perhaps they should start using initramfs then.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
