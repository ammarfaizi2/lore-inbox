Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbSJAIqD>; Tue, 1 Oct 2002 04:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbSJAIqD>; Tue, 1 Oct 2002 04:46:03 -0400
Received: from ti131310a080-1458.bb.online.no ([80.212.21.178]:62477 "HELO
	grimm1.grimstad") by vger.kernel.org with SMTP id <S261547AbSJAIqA>;
	Tue, 1 Oct 2002 04:46:00 -0400
Date: Tue, 1 Oct 2002 09:41:47 +0200
From: "Nils O. =?ISO-8859-1?Q?Sel=E5sdal=22?= <noselasd@Utel.no>"@vax.home.local
Message-Id: <200210010741.g917flO15927@utelsystems.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <fa.hu1gd9v.fku81p@ifi.uio.no>
References: <fa.mpta6av.960ggh@ifi.uio.no> <fa.hu1gd9v.fku81p@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fa.linux.kernel, you wrote:
>> > And if it wasn't clear to the non-2.5-development people out there, yes
>> > you _should_ also test this code out even before the freeze. The IDE layer
>> > shouldn't be all that scary any more, and while there are still silly
>> > things like trivially non-compiling setups etc, it's generally a good idea
>> > to try things out as widely as possible before it's getting too late to
>> > complain about things..
>> 
>> Basically: I would _love_ to test this kernel on my laptop here, but - 
>> unfortunately - i need the laptop for my work. Which means i need it to work.
>> 
>> So how much chance IS there to trash the filesystems? I guess a lot of ppl 
>> like me are just waiting to test it out, but aren't willing to screw their 
>> systems over it...
> 
> There is not much chance.
> 
> The only thing that can be guaranteed is that if nobody tests 2.5.x out, then 2.6.x 
> will definitely have trivial bugs in it.

Which reminds me, I was testing 2.5.39 yesterday on a 433MHz x86, 224Mb ram.
I felt this was abit like some of the 2.4.7-2.4.9 kernels i once ran:
too happy swapping things out. Having mozilla and evolution in the background 
while compiling some large projects, or doing lots of file copying 
caused most of mozilla and evolution to be swapped out, and thus the desktop felt 
alot slower than e.g. 2.4.19. 

Other issue, it took me about 2 hours to figure out that it was enabling preemtion
that caused the kernel not to boot.

-- 
Vennlig hilsen/Best Regards
Nils Olav Selåsdal
System Engineer
UtelSystems a/s
Tlf: +47 370 45 431
w w w . u t e l s y s t e m s . c o m

