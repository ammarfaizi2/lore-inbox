Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272144AbRHXPkC>; Fri, 24 Aug 2001 11:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272189AbRHXPjm>; Fri, 24 Aug 2001 11:39:42 -0400
Received: from Expansa.sns.it ([192.167.206.189]:27402 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S272150AbRHXPjb>;
	Fri, 24 Aug 2001 11:39:31 -0400
Date: Fri, 24 Aug 2001 17:39:10 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Fred <fred@arkansaswebs.com>, Tony Hoyle <tmh@nothing-on.tv>,
        <linux-kernel@vger.kernel.org>
Subject: Re: File System Limitations
In-Reply-To: <E15a4Gz-0004uz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108241737520.5592-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am just curious,
did you compiled your glibc against a  2.2 or 2.4 kernel headers???

Luigi

On Fri, 24 Aug 2001, Alan Cox wrote:

> > glibc-2.2.2-10
>
> Your C library is new enough
>
> > [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> > File size limit exceeded (core dumped)
>
> But your dd program might not be
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

