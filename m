Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286326AbRLTSik>; Thu, 20 Dec 2001 13:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbRLTSh5>; Thu, 20 Dec 2001 13:37:57 -0500
Received: from [198.17.35.35] ([198.17.35.35]:39073 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S286324AbRLTSgp>;
	Thu, 20 Dec 2001 13:36:45 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A20@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Matt Bernstein'" <matt@theBachChoir.org.uk>,
        Steven Cole <scole@lanl.gov>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: RE: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel
	p.
Date: Thu, 20 Dec 2001 10:36:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe that the main purpose of documentation, help etc is 
> to get the
> information across in a way that is most easily understood, ie that
> minimises the number of support questions.. ..and everyone 
> surely knows
> what GB, MB and KB stand for. So let's leave it at that. 
> Where's the "i"
> in "megabyte" ? Or is 1MiB 1000000 bytes, rather than 1048576?

1 MB isn't 1048576.

it's 1000000

mega isn't 2^10, it's 10^6

so where are YOU coming from?

(no, i'm not arguin, i don't particularly care.  but i'm
pointing out that some people have completely firmly set
definitions and some other people also have firm definitions
and neither will agree the other's right.  MiB is the international
standard for a 2^10 B(yte) specification.  so if you mean
2^10 bytes, you mean MiB, not MB, even if you don't like it :)

So these are very very good changes :)

Dana Lacoste
Ottawa, Canada (a metric country :)
