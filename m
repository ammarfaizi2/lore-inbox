Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLHFaS>; Fri, 8 Dec 2000 00:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130357AbQLHFaK>; Fri, 8 Dec 2000 00:30:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50948 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129908AbQLHF3v>; Fri, 8 Dec 2000 00:29:51 -0500
Message-ID: <3A306994.63DB8208@timpanogas.org>
Date: Thu, 07 Dec 2000 21:54:44 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Michael H. Warfield" wrote:

> > Agree.  We need to disable it, since folks do not read the docs
> > (obviously).  Of course, we could leave it on, and I could start
> > charging money for these tools -- there's little doubt it would be a
> > lucrative business.  Perhaps this is what I'll do if the numbers of
> > copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> > our time to support, so I will have to start charging for it.
> 
>         Huh?
> 
>         How disabled do you want it.  It can't even be enabled unless
> you enabled experimental code options.  Then, it's disabled by default
> and you first have to enable the R/O NTFS.  Then you have to explicitly
> select the option to enable RW access that is clearly labeled DANGEROUS.
> This thing is not armed and dangerous due to an act of ommision.  It's
> live and active only through three acts of commision.
> 
>         About the only thing left, short of removing it from the kernel
> entirely, is to make the option a hidden control option, like some of the
> debugging options, that requires editing a header file or a Makefile to
> enable.  Is that what you are looking for?
> 

Linux today monitors this list.  Some public education may be the best
route.  How do we post a security advisory warning people that will get
posted?  I'm sure folks see the DANGEROUS comments, but they don't seem
to stick in their heads.  Then they get themselves into trouble, and
fortunately for them, I'm around.  I am just concerned about the scope
of the black eye that will just keep getting bigger and bigger for Linux
NTFS.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
