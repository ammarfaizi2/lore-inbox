Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSJ1BgY>; Sun, 27 Oct 2002 20:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSJ1BgX>; Sun, 27 Oct 2002 20:36:23 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:8968 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S262805AbSJ1BgX>; Sun, 27 Oct 2002 20:36:23 -0500
Date: Sun, 27 Oct 2002 20:42:25 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: john@pianoman.cluster.toy
To: KORN Andras <korn-linuxkernel@chardonnay.math.bme.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [solved] 2.4 very slow memory access on abit kd7raid (kt400);
 ten times slower than on kg7raid
In-Reply-To: <20021027181932.GS27554@nilus-2690.adsl.datanet.hu>
Message-ID: <Pine.LNX.4.44.0210272039320.4694-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I actually don't know, but I ran into a very similar problem on a Kt133
based Athlon ages ago (in computer years, anyway.. around december of last
year ;).. I remember it was an ACPI problem that just "went away" with a
later version of ACPI.  That was an MSI (K7 Master, maybe?) motherboard.

Unfortunately, that's all i know.  If you find the answer, please let me
know as well.

john.c

On Sun, 27 Oct 2002, KORN Andras wrote:

> On Sun, Oct 27, 2002 at 12:46:05PM -0500, John Clemens wrote:
>
> Hi,
>
> > Try booting with "acpi=off"
>
> OK, this worked. The system is running at normal speed now.
>
> What was the problem? What did this have to do with acpi?
>
> Andrew
>
>

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


