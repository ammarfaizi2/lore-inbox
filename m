Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275526AbRJJLyt>; Wed, 10 Oct 2001 07:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275527AbRJJLyi>; Wed, 10 Oct 2001 07:54:38 -0400
Received: from unicef.org.yu ([194.247.200.148]:59400 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S275526AbRJJLy3>;
	Wed, 10 Oct 2001 07:54:29 -0400
Date: Wed, 10 Oct 2001 13:53:57 +0200 (CEST)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Cyrus <cyrus@linuxmail.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Clock Skew?... kernel compile.....2.4.11...
In-Reply-To: <3BC38813.4030601@linuxmail.org>
Message-ID: <Pine.LNX.4.33.0110101347210.32210-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check date if it's wrong (year)
then go into bios and check/fix date !

errors happened because
kernel sources are newer than
kernel compiled

Zoran

On Wed, 10 Oct 2001, Cyrus wrote:

> hi all,
>
> i was compiling kernel 2.4.11... on my two machines. my server, which is
> an intel p2 233Mhz mmx... went alright without errors....
>
> but my athlon system, 1.2 thunderbird was spewing out this error.
>
> honestly, i've never encountered this one...
>
> Root device is (3, 3)
> Boot sector 512 bytes.
> Setup is 4640 bytes.
> System is 798 kB
> make[1]: Leaving directory `/usr/src/linux-2.4.11/arch/i386/boot'
> make: warning:  Clock skew detected.  Your build may be incomplete.
>
> real    3m47.334s
> user    2m46.510s
> sys     0m29.330s
>
>
> any ideas?... thanks in a lot...
>
>
> cyrus
>
> --
>   Cyrus Santos
>
> Registered Slackware Linux User # 220455
> Sydney, Australia
>
> "...the best things in life are free...."
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

