Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317428AbSFCRPr>; Mon, 3 Jun 2002 13:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFCRPp>; Mon, 3 Jun 2002 13:15:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317428AbSFCRPi>; Mon, 3 Jun 2002 13:15:38 -0400
Date: Mon, 3 Jun 2002 13:16:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zack Brown <zbrown@tumblerings.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Linux virus?
In-Reply-To: <20020603155736.GA10504@renegade>
Message-ID: <Pine.LNX.3.95.1020603125936.791A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Zack Brown wrote:

> Not really on topic for this list, but probably of interest to a lot of
> people here.
> 
> http://www.symantec.com/avcenter/venc/data/linux.simile.html
> 
> -- 
> Zack Brown
> -

Symantec is in the business of selling "anti virus" software.
In their "example", there is a cp_ini file owned by "guest".
This is apparently on a system that allowed guest access so
anybody could ftp a file called anything into that account.
Just because it's ELF, it doesn't mean it's executable even
though the executable bit is set. Even if it would delete everything
on your hard disk, I would need to be executed from the root account.
If somebody set up a system so root could upload a file using
ftp, without a password and/or without in being on the local LAN,
they get what they deserve.


Also, when you access the symantec site, you end up getting one
of those persistent "Casino on the Net" advertisements that won't
go away without disconnecting the network wire. Therefore, Symantec
contributes to virii themselves.... Also, if you use M$ Exploder,
check your "history" after accessing this site. You may find that
you just accessed a bunch of porno sites, according to the history.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

