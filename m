Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSFFIcc>; Thu, 6 Jun 2002 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSFFIcb>; Thu, 6 Jun 2002 04:32:31 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:45327 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316889AbSFFIca>; Thu, 6 Jun 2002 04:32:30 -0400
Message-ID: <3CFF1EA3.80300@loewe-komp.de>
Date: Thu, 06 Jun 2002 10:34:43 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Oliver Xymoron <oxymoron@waste.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17FfU7-0001dP-00@starship> <Pine.LNX.4.44.0206051330060.2614-100000@waste.org> <20020605164837.A25348@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> I like the idea of Adeos, and nanokernels. I like the idea of RT, and
> I like the fact that the Open Source community is interested in all of
> these topics. It means that solutions such as VxWorks now have real
> competition, and they will be forced to make their large price tag
> purchase real value for customers, or customers will shop elsewhere.
> 

I'm also not against such approaches.
As I worked for QNX I liked to provoke my Canadian coworkers
with arguments like: RTLinux is able to swap - not bad for a hack ;-)

http://groups.google.de/groups?selm=378b7d25%240%24199%40nntp1.ba.best.com&output=gplain

> Just... an .mp3 player for a desktop environment? This is a
> joke. Maybe the RTOS can perform my compiles too? That way will be
> able to accurately predict how long it will take to compile
> linux-2.4.18 each and every time.

When talking about hard realtime it's all about worst case
considerations. Average does not count (then you are talking about
*soft realtime* -> like multimedia apps, where only the quality counts).
So you could only tell how long your compile lasts at *maximum*

As I said before: the OS is only the foundation for realtime *systems*
> 
> Summary: Linux + RTOS should never become VxWorks.
> 

Yes, given that vxworks is more like a realtime executive
(but this seems to change: only true when running without VxVMI? )

http://www.windriver.com/products/html/vxwks5x_ds.html

