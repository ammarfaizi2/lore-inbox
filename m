Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWAVGpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWAVGpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 01:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWAVGpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 01:45:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:56770 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750840AbWAVGps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 01:45:48 -0500
Date: Sun, 22 Jan 2006 07:45:47 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>,
       Hubert Tonneau <hubert.tonneau@fullpliant.org>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060122064547.GB29282@MAIL.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	neilb@cse.unsw.edu.au
References: <0610HXV12@briare1.heliogroup.fr> <20060120161549.GA20681@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120161549.GA20681@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:15:50PM +0000, Christoph Hellwig wrote:
> On Fri, Jan 20, 2006 at 05:01:06PM +0000, Hubert Tonneau wrote:
> > In the U160 category, the symbios driver passed all possible stress tests
> > (partly bad drives that require the driver to properly reset and restart),
> > but in the U320 category, neither the Fusion not the AIC79xx did.
> 
> Please report any fusion problems to Eric Moore at LSI, the Adaptec
> driver must unfortunately be considered unmaintained.

wasn't Justin T. Gibbs maintaining this driver for 
some time, and who is doing the drivers/updates
published on the adaptec site?

http://www.adaptec.com/worldwide/support/driversbycat.jsp?sess=no&language=English+US&cat=%2FOperating+System%2FLinux+Driver+Source+Code

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
