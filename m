Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSILXTP>; Thu, 12 Sep 2002 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319164AbSILXTO>; Thu, 12 Sep 2002 19:19:14 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:2758 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318778AbSILXTN>; Thu, 12 Sep 2002 19:19:13 -0400
Message-ID: <3D812222.3F2727CA@bigpond.com>
Date: Fri, 13 Sep 2002 09:24:18 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and 
 agpgart
References: <3D7FF444.87980B8E@bigpond.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan wrote:
> 
> This is a reissue of an earlier report, and I've since done some more digging.
> 
> Up to kernel 2.4.20-pre2 there was no problem, agpgart et al ran fine etc,
> but from 2.4.20-pre4 onwards when Xwindows starts to load these modules
> I am instantly thrown back to a booting machine.
> The same kernels on a VIA MVP3 chipset box with a Matrox G200 are fine.
> 
> I have ascertained that any attempt to use agpgart triggers it.
> 
> Rather than clutter up the list with lots of log files, I've made a web page at
> http://www.users.bigpond.com/allan.d/bug/Matrox.html
> with all the info I could gather.
> 
> Any suggestions of how to improve the error messages around the failure point
> are welcome.  Nothing is written into dmesg at the time of failure.

Uh, the logs for -pre5 with AGP_VIA enabled are NOW referred to (instead of
duplicating the -pre5 w/o VIA).
