Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154904AbQELV7S>; Fri, 12 May 2000 17:59:18 -0400
Received: by vger.rutgers.edu id <S154937AbQELV4J>; Fri, 12 May 2000 17:56:09 -0400
Received: from hera.cwi.nl ([192.16.191.1]:46827 "EHLO hera.cwi.nl") by vger.rutgers.edu with ESMTP id <S155022AbQELVzp>; Fri, 12 May 2000 17:55:45 -0400
Date: Sat, 13 May 2000 00:07:16 +0200
From: Andries Brouwer <aeb@veritas.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: Historical Archive
Message-ID: <20000513000716.A21182@veritas.com>
References: <E12pgd6-0003fo-00@the-village.bc.nu> <200005110310.XAA21546@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200005110310.XAA21546@tsx-prime.MIT.EDU>; from tytso@mit.edu on Wed, May 10, 2000 at 11:10:49PM -0400
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, May 10, 2000 at 11:10:49PM -0400, Theodore Y. Ts'o wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 	Thu, 11 May 2000 01:15:04 +0100
> 
>    I've had a pile of old stuff from 1993->1995 that escaped due to
>    freak chance and non reuse of an old disk. I've now rescued the data
>    and finally had time to strip the original Linux lists out of it.
>    I dont have 1991/1992 alas but hopefully someone else does.
>    Ted used to have them on tsx-11 I believe /
> 
> I have archives from 1991-1994 at:
> 
> 	ftp://tsx-11.mit.edu/pub/linux/mail-archives
> 
> Any budding historian/archivist want to try to merge the two archives
> together?  :-)

I just had a look. Alan, maybe you can rename your files to
something like

-rw-r--r--   1 aeb      users     3175484 May 11 13:19 kernel.1.oct93-jan94
-rw-r--r--   1 aeb      users     4285186 May 11 13:19 kernel.2.jan94-apr94
-rw-r--r--   1 aeb      users     4098851 May 11 13:19 kernel.3.apr94-jul94
-rw-r--r--   1 aeb      users     1981388 May 11 13:19 kernel.4.jul94-oct94
-rw-r--r--   1 aeb      users     2012272 May 11 13:19 kernel.5.oct94-dec94
-rw-r--r--   1 aeb      users      981069 May 11 13:19 kernel.6.dec94-feb95
-rw-r--r--   1 aeb      users      262913 May 11 13:19 kernel.7.feb95-apr95
-rw-r--r--   1 aeb      users      152424 May 11 13:19 kernel.8.apr95-jul95
-rw-r--r--   1 aeb      users        2963 May 11 13:19 kernel.9.jul95-theend

so that they get the proper order and the contents is clear.

Ted, your mail-archives are incomplete: in linux-activists/Volume6
you have digests 200-298 and 365-371, and there are no 299-364.

Digest 298 is about Fri, 8 Oct 93, while Alan's stuff starts
Wed, 13 Oct 1993. So, a few days are missing.

But then, your digests 365-371 should show overlap with Alan's stuff,
where you both have the period 10-12 Nov 93, and I find no such overlap.
So, Ted has old Linux-Activists@senator-bedfellow.MIT.EDU stuff,
and Alan has owner-linux-activists%fi.hut.cs.joker@fi.hut.FINHUTC stuff,
and at first sight these look disjoint.

Andries


PS - Alan, you didnt find by any chance some kernel sources?
I had a complete collection, but lost 0.99pl13* in a disk crash,
only linux13k.tgz survived by some coincidence.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
