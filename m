Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129293AbRAaXlm>; Wed, 31 Jan 2001 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129334AbRAaXlc>; Wed, 31 Jan 2001 18:41:32 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:31976 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129293AbRAaXlY>; Wed, 31 Jan 2001 18:41:24 -0500
Date: Wed, 31 Jan 2001 15:38:41 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Tom Leete <tleete@mountain.net>
cc: Peter Samuelson <peter@cadcamlab.org>, David Ford <david@linux.com>,
        Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A77ED7F.466582F0@mountain.net>
Message-ID: <Pine.LNX.4.31.0101311536520.5898-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

about the third story down is one mentioning SMP athlon boards actually
starting to show up

http://www.aceshardware.com/Spades/list_news.php?category=AMD

David Lang

On Wed, 31
Jan 2001, Tom Leete wrote:

> Date: Wed, 31 Jan 2001 05:48:31 -0500
> From: Tom Leete <tleete@mountain.net>
> To: Peter Samuelson <peter@cadcamlab.org>
> Cc: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
>      LKML <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
>
> Peter Samuelson wrote:
> >
> > [Tom Leete]
> > > It's not an incompatibility with the k7 chip, just bad code in
> > > include/asm-i386/string.h.
> >
> > So you're saying SMP *is* supported on Athlon?  Do motherboards exist?
> >
> > Peter
>
> No, I'm saying that SMP locking etc. is compatible with Athlon. The failure
> to build is not a workaround but a coding error. SMP builds for UP machines
> are supposed to work.
>
> Tom
> --
> The Daemons lurk and are dumb. -- Emerson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
