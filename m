Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286341AbRLTTW7>; Thu, 20 Dec 2001 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbRLTTWt>; Thu, 20 Dec 2001 14:22:49 -0500
Received: from white.pocketinet.com ([12.17.167.5]:17462 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S286347AbRLTTWf>; Thu, 20 Dec 2001 14:22:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Matt Bernstein'" <matt@theBachChoir.org.uk>,
        Steven Cole <scole@lanl.gov>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel p.
Date: Thu, 20 Dec 2001 11:13:52 -0800
X-Mailer: KMail [version 1.3.1]
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A20@ottonexc1.ottawa.loran.com>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A20@ottonexc1.ottawa.loran.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEGtPrPrvCWO6hm8000002fb@white.pocketinet.com>
X-OriginalArrivalTime: 20 Dec 2001 19:20:54.0992 (UTC) FILETIME=[720BCD00:01C1898B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 10:36 am, Dana Lacoste wrote:
> > I believe that the main purpose of documentation, help etc is
> > to get the
> > information across in a way that is most easily understood, ie that
> > minimises the number of support questions.. ..and everyone
> > surely knows
> > what GB, MB and KB stand for. So let's leave it at that.
> > Where's the "i"
> > in "megabyte" ? Or is 1MiB 1000000 bytes, rather than 1048576?
>
> 1 MB isn't 1048576.
>
> it's 1000000
>
> mega isn't 2^10, it's 10^6
>
> so where are YOU coming from?
>
> (no, i'm not arguin, i don't particularly care.  but i'm
> pointing out that some people have completely firmly set
> definitions and some other people also have firm definitions
> and neither will agree the other's right.  MiB is the international
> standard for a 2^10 B(yte) specification.  so if you mean
> 2^10 bytes, you mean MiB, not MB, even if you don't like it :)

This "international" standard seems to have excluded a few countries. 
It wasn't until it was SET that I even heard of its existance. (And 
then only through SLASHDOT!)

Everyone I know has been using KB/MB/GB for 1024 forever. The *only* 
exception is networking, and the occasional FLASH/ROM size. The latter 
isn't very common discussion, and among those that it is, they'd know 
what the other was talking about. For the former, I can distinguish 
easily depending on who it is.

Someone without a lot of experience: I have a 1MB connection. (this 
user has a 1 Megabit connection)

Someone with experience: I have a 1mb/Mb connection. (This person has a 
1 megabit connection has used a "standard" abbreviation.)

Know how these standards came about?
Actual use. Not a bunch of "engineers" in a room arguing over how best 
to cause absurd changes in kernel help files.
