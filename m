Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272196AbRH3MoY>; Thu, 30 Aug 2001 08:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272195AbRH3MoO>; Thu, 30 Aug 2001 08:44:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25474 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272194AbRH3Mn5>; Thu, 30 Aug 2001 08:43:57 -0400
Date: Thu, 30 Aug 2001 08:44:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reg-mounting of minix file system
In-Reply-To: <Pine.LNX.4.10.10108301828090.17070-100000@blrmail>
Message-ID: <Pine.LNX.3.95.1010830084218.31870A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, SATHISH.J wrote:

> 
> Hi,
> I did an "rmmod minix" to remove the minix module from the kernel
> and then tried to mount the partition on a mount point using minix
> filesystem. I gave the command 
> 
> mount -t minix /dev/sdb1 /dummy....
> 
> .but found that it got mounted without
> error, though I have already removed the minix module from the kernel. So
> again I unmounted the fs and took an strace of the same command and a part
> of the output was the following:
> 
Magic!  `man modprobe`, `cat /etc/modules.conf`, etc., to start.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


