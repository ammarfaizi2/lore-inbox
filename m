Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIIPKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIIPKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUIIPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:10:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:22503 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S265489AbUIIPKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:10:09 -0400
Date: Thu, 9 Sep 2004 17:10:06 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@lst.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040909151006.GB15888@MAIL.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907143741.GA8606@lst.de> <1094576968.9599.9.camel@localhost.localdomain> <20040907181259.GA12654@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907181259.GA12654@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:12:59PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 07, 2004 at 06:09:29PM +0100, Alan Cox wrote:
> > On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
> > > Not used anywhere in modules and it really shouldn't either.
> > 
> > Doesn't that happen (conveniently from some viewpoints Im sure) to break
> > vmware ?
> 
> It happens because Arjan & I wrote up some scripts to find dead exports.

are those available somewhere?

sorry google didn't have a good answer for me ...

TIA,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
