Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSJQQn4>; Thu, 17 Oct 2002 12:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbSJQQn4>; Thu, 17 Oct 2002 12:43:56 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:41365 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261686AbSJQQnz>; Thu, 17 Oct 2002 12:43:55 -0400
Date: Thu, 17 Oct 2002 09:43:21 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Frederik Nosi <fredi@e-salute.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][neofb]2.5.4[0-3]
In-Reply-To: <200210171449.12222.fredi@e-salute.it>
Message-ID: <Pine.LNX.4.33.0210170941520.4730-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a DELL Latitude CPi D233SP. With kernels from 2.5.40 to 2.5.43 using
> neofb during shutdown I get an Oops:
>
> Danger danger! Oopsen imminent
> MTRR setting reg 2
>
> This is the second time I'm reporting this, the first time I CC'ed the
> mantainer too without results. Here is the link to my previous posting:
>
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-39/1108.html

I saw it but I was busy finsihing the fbdev changes that are about to go
in. I also have this chipset so I plan to track down the bug now that I
have finished my work.

> With the 2.4.19/20-pre-last kernels scrolling up in the console is very slow
> using the neofb driver as I've wrote in my previous posting.

What color depth? Acceleration only works for 8 and 16 bpp modes :-(

