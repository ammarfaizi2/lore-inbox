Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265386AbTLHMs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 07:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTLHMs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 07:48:59 -0500
Received: from customer-mpls-23.cpinternet.com ([209.240.253.23]:43333 "EHLO
	customer-mpls-23.cpinternet.com") by vger.kernel.org with ESMTP
	id S265386AbTLHMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 07:48:57 -0500
Subject: Re: XFS merged in 2.4
From: "Michael D. Harnois" <mharnois@cpinternet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet>
References: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet>
Content-Type: text/plain
Message-Id: <1070887696.16336.16.camel@mharnois.mdharnois.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 06:48:16 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to have been incompletely merged in patch-2.4.23-bk6, where
make dies with

/usr/bin/make -C xfs fastdep
make: *** xfs: No such file or directory.  Stop.

On Mon, 2003-12-08 at 05:22, Marcelo Tosatti wrote:
> FYI
> 
> Christoph reviewed XFS patch which changed generic code, and it was
> stripped down later to a set of changes which dont modify the code
> behaviour (except for a few bugfixes which should have been included
> separately anyway) and are pretty obvious.
> 
> So its that has been merged, along with fs/xfs/.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Michael D. Harnois

3L, UST School of Law
              Minneapolis, Minnesota
There can be no transforming of
darkness into light and of apathy
into movement without emotion. -
Carl Jung

