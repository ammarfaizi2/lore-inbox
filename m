Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSFDTnf>; Tue, 4 Jun 2002 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFDTne>; Tue, 4 Jun 2002 15:43:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:33665 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316636AbSFDTn1>; Tue, 4 Jun 2002 15:43:27 -0400
Date: Tue, 4 Jun 2002 15:46:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <20020604193806.58478.qmail@web14905.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020604154602.6515A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Michael Zhu wrote:

> Hi, I built a kernel module. I can load it into the
> kernle using insmod command. But each time when I
> reboot my computer I couldn't find it any more. I mean
> I need to use the insmod to load the module each time
> I reboot the computer. How can I modify the
> configuration so that the Linux OS can load my module
> automatically during reboot? I need to copy my module
> to the following directory?
>   /lib/modules/2.4.7-10/
> 
> I've done that. But it doesn't work.
> 
> Any help will be appreciated.

man modules.conf


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

