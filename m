Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRDNMrK>; Sat, 14 Apr 2001 08:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRDNMrB>; Sat, 14 Apr 2001 08:47:01 -0400
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:4483 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S132054AbRDNMqy>; Sat, 14 Apr 2001 08:46:54 -0400
Date: Sat, 14 Apr 2001 08:46:49 -0400 (EDT)
From: Arthur Pedyczak <arthur-p@home.com>
To: Jens Axboe <axboe@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <20010414095402.C20299@suse.de>
Message-ID: <Pine.LNX.4.33.0104140843170.21879-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Jens Axboe wrote:

[ SNIP..................]
> > =====================
> > Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging request at virtual address 7e92bfd7
>
> Please disable syslog decoding (it sucks) and feed it through ksymoops
> instead.
>
> In other words, reproduce and dmesg | ksymoops instead.
>
>
I tried to reproduce the error this morning and couldn't. Same kernel
(2.4.3), same setup, same iso file. It mounted/unmounted 10 times with no
problem. DOn't know what to think.

Arthur

