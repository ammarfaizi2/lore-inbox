Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUFNOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUFNOdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUFNOdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:33:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12467 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263095AbUFNOda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:33:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Mon, 14 Jun 2004 16:37:27 +0200
User-Agent: KMail/1.5.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au> <200406132001.44262.bzolnier@elka.pw.edu.pl> <20040613221840.GA31354@gondor.apana.org.au>
In-Reply-To: <20040613221840.GA31354@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406141637.27492.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 of June 2004 00:18, Herbert Xu wrote:
> On Sun, Jun 13, 2004 at 08:01:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This makes ordering of IDE devices different in Debian-2.6
> > and vanilla 2.4/2.6, doesn't sound like a good thing to do.
>
> If IDE is built-in, the ordering is exactly the same.
>
> > Ideally ordering should be controlled by user-space. :-)
>
> If IDE is built as a module, then the ordering is still controlled
> by user space.

I'm lost now, so what is your change exactly supposed to do?

