Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVELE3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVELE3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 00:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVELE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 00:29:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:39080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261272AbVELE3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 00:29:17 -0400
Date: Wed, 11 May 2005 21:26:57 -0700
From: Greg KH <greg@kroah.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Shaun Reitan <mailinglists@unix-scripts.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: kernel panic - not syncing: Fatal exception in interupt
Message-ID: <20050512042657.GA16417@kroah.com>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com> <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com> <d3ugtr$gml$1@sea.gmane.org> <20050418060744.GA5057@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418060744.GA5057@gondor.apana.org.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 04:07:44PM +1000, Herbert Xu wrote:
> On Sun, Apr 17, 2005 at 08:32:42PM +0000, Shaun Reitan wrote:
> > OK, finally got a full dump from the serial console!  Here is it!
> 
> This was fixed about a month ago.  Here is the patch that did it.
> 
> Perhaps it's time to include this in 2.6.11.*?

Applied to the -stable queue, thanks.

greg k-h
