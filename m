Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGZFUs>; Fri, 26 Jul 2002 01:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSGZFUs>; Fri, 26 Jul 2002 01:20:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:27090 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316792AbSGZFUs>; Fri, 26 Jul 2002 01:20:48 -0400
Date: Fri, 26 Jul 2002 07:24:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: jeff millar <wa1hco@adelphia.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28 link problem
In-Reply-To: <00a501c2338c$25365170$6a01a8c0@wa1hco>
Message-ID: <Pine.NEB.4.44.0207260721310.15439-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, jeff millar wrote:

> ...need help getting a compile to complete.  This problem exists with
> 2.5.27-28.
> Here's the last lines from make...
>...
> drivers/built-in.o: In function `md_run_setup':
> /usr/src/v2.5.28/drivers/md/md.c(.data+0xee34): undefined reference to
> `local symbols in discard
> ed section .text.exit'
> make: *** [vmlinux] Error 1
>...

Could you send your .config?

> thanks in advance, jeff

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


