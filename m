Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312846AbSCVVZf>; Fri, 22 Mar 2002 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312848AbSCVVZ0>; Fri, 22 Mar 2002 16:25:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27520 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312846AbSCVVZL>; Fri, 22 Mar 2002 16:25:11 -0500
Date: Fri, 22 Mar 2002 16:26:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: walt <walt@nea-fast.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: printing from command line
In-Reply-To: <3C9B9129.8F8D64C9@nea-fast.com>
Message-ID: <Pine.LNX.3.95.1020322162417.2814A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, walt wrote:

> This is a general linux question, not really a kernel question. Does
> anyone know if there is a "simple" good way to print code from linux at
> the command promt.  On a Solaris machine,
> /usr/openwin/bin/mp -o -l filename
> gives me a page with 2 columuns, user_name, date, and pagenumber at the
> top of each column, and the filename at the bottom of each column. I've
> read  lots of howtos and man pages, even wrote a perl script to wrap the
> lines for me, but I haven't figured out how to get the same format from
> Linux as I do from Solaris.
> 
> Thanks!

I think you want `pr` although some formatting isn't automatic. `man pr`
shows it takes more parameters than `ls`. Fortunately, you can make
an alias.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

