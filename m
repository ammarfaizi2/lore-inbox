Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRAOGbl>; Mon, 15 Jan 2001 01:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbRAOGbb>; Mon, 15 Jan 2001 01:31:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:32272 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131576AbRAOGbS>; Mon, 15 Jan 2001 01:31:18 -0500
Date: Mon, 15 Jan 2001 02:40:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Vlad Bolkhovitine <vladb@sw.com.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap()/VM problem in 2.4.0
In-Reply-To: <3A5EFB40.6080B6F3@sw.com.sg>
Message-ID: <Pine.LNX.4.21.0101150233520.12760-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Vlad Bolkhovitine wrote:

> After upgrade from 2.4.0-test7 to 2.4.0 while running tiotest v0.3.1 I found two
> following problems. 

There have been quite a lot of things changed from 2.4.0-test7 to 2.4.0,
so I'm not sure what caused the slowdown.

Anyway, important VM changes are happening in 2.4.1pre and it would be
very interesting to have more people testing and reporting results for
this new modifications. Right now discussions about the 2.4.1pre VM stuff
is going on only in the linux-mm list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
