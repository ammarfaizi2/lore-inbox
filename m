Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDNUQK>; Sat, 14 Apr 2001 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDNUQB>; Sat, 14 Apr 2001 16:16:01 -0400
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:2692 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S132537AbRDNUPr>; Sat, 14 Apr 2001 16:15:47 -0400
Date: Sat, 14 Apr 2001 16:15:43 -0400 (EDT)
From: Arthur Pedyczak <arthur-p@home.com>
To: Aaron Lunansky <alunansky@rim.net>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8107F45B05@xch01ykf.rim.net>
Message-ID: <Pine.LNX.4.33.0104141612250.27637-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Aaron Lunansky wrote:
Why not indeed? - should have thought about it myself

Well, I wrote the script. It has been running for 10 minutes now mounting
and unmounting an iso image. Nothing happens.
I guess I should be happy.
Still don't undertand where the original Oops
came
from

> If you're intent on making it oops why not write a script to
mount/unmount
> it repeatedly?
>
>
> Regards,
> Aaron
>
>
> -----Original Message-----
> From: Arthur Pedyczak <arthur-p@home.com>
> To: Jens Axboe <axboe@suse.de>
> CC: Linux kernel list <linux-kernel@vger.kernel.org>; Jeff Garzik
> <jgarzik@mandrakesoft.com>
> Sent: Sat Apr 14 08:46:49 2001
> Subject: Re: loop problems continue in 2.4.3
>
> On Sat, 14 Apr 2001, Jens Axboe wrote:
>
> [ SNIP..................]
> > > =====================
> > > Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging
> request at virtual address 7e92bfd7
> >
> > Please disable syslog decoding (it sucks) and feed it through ksymoops
> > instead.
> >
> > In other words, reproduce and dmesg | ksymoops instead.
> >
> >
> I tried to reproduce the error this morning and couldn't. Same kernel
> (2.4.3), same setup, same iso file. It mounted/unmounted 10 times with no
> problem. DOn't know what to think.
>
> Arthur
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

