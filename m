Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUDQMaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 08:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbUDQMaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 08:30:14 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:33290 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262634AbUDQMaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 08:30:11 -0400
Date: Sat, 17 Apr 2004 22:29:54 +1000
To: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040417122954.GA7533@gondor.apana.org.au>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org> <20040417113918.GA4846@gondor.apana.org.au> <20040417124850.C14786@flint.arm.linux.org.uk> <20040417122322.GA15052@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417122322.GA15052@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 10:23:22PM +1000, herbert wrote:
> 
> This patch should be better.

Please scrap that one, it just makes the module unloadable.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
