Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbRAaX3w>; Wed, 31 Jan 2001 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129083AbRAaX3n>; Wed, 31 Jan 2001 18:29:43 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:12997 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129186AbRAaX3a>; Wed, 31 Jan 2001 18:29:30 -0500
Date: Wed, 31 Jan 2001 15:26:43 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: David Ford <david@linux.com>
cc: Stephen Frost <sfrost@snowman.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A77966E.444B1160@linux.com>
Message-ID: <Pine.LNX.4.31.0101311526130.5898-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

probably not now that SMP athlon boards are supposed to be starting to be
available.

David Lang

On Tue, 30 Jan 2001, David Ford wrote:

> Date: Tue, 30 Jan 2001 20:37:02 -0800
> From: David Ford <david@linux.com>
> To: Stephen Frost <sfrost@snowman.net>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
>
> Mhm.  Is it worth the effort to make a dependancy on the CPU type for SMP?
>
> </idle questions>
>
> -d
>
> Stephen Frost wrote:
>
> > * David Ford (david@linux.com) wrote:
> > > A person just brought up a problem in #kernelnewbies, building an SMP
> > > kernel doesn't work very well, current is undefined.  I don't have more
> > > time to debug it but I'll strip the config and put it up at
> > > http://stuph.org/smp-config
> >
> >         They're trying to compile SMP for Athlon/K7 (CONFIG_MK7=y).
>
> --
>   There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
>   The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
