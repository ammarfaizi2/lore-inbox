Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWJJJ7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWJJJ7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWJJJ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:59:05 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:49673 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965145AbWJJJ7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:59:00 -0400
Date: Tue, 10 Oct 2006 19:58:07 +1000
To: Jeff Garzik <jeff@garzik.org>
Cc: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ecryptfs: reduce legacy API usage
Message-ID: <20061010095807.GA31539@gondor.apana.org.au>
References: <20061010064626.GA21155@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010064626.GA21155@havoc.gtf.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:46:26AM -0400, Jeff Garzik wrote:
> 
> Use modern crypto APIs.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Looks good.  Thanks Jeff!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
