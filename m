Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313733AbSDHS7m>; Mon, 8 Apr 2002 14:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313734AbSDHS7l>; Mon, 8 Apr 2002 14:59:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11136 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313733AbSDHS7k>; Mon, 8 Apr 2002 14:59:40 -0400
Date: Mon, 8 Apr 2002 14:56:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Lang <dlang@diginsite.com>
cc: Bill Davidsen <davidsen@tmr.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <Pine.LNX.4.44.0204081138490.27634-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.95.1020408145504.1153A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, David Lang wrote:

> watch out for the write cycle limits of your flash. they're pretty low
> power (at least compared to anything mechanical) but if you're not careful
> you can go through their write capability pretty fast.
> 
> David Lang
> 
> 
>

Upon boot, you can mount a ram-disk off from /tmp. That will reduce
the activity when using the usual editors, vi, vim, emacs, and pico,
which all create temp files on /tmp.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

