Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290248AbSAOSw5>; Tue, 15 Jan 2002 13:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290243AbSAOSws>; Tue, 15 Jan 2002 13:52:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290248AbSAOSwf>; Tue, 15 Jan 2002 13:52:35 -0500
Date: Tue, 15 Jan 2002 13:52:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marco Colombo <marco@esi.it>
cc: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>,
        Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
In-Reply-To: <Pine.LNX.4.33.0201151910530.11441-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.3.95.1020115133220.818B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Marco Colombo wrote:

> On 15 Jan 2002, Thomas Duffy wrote:
> 
> > On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:
> > 
> > > - Building from source is good karma.

[SNIPPED...]

> 
> Every distro supplies a package with the source used to build their own
> kernel. Just recomplile it.

Really???  Have you ever tried this? RedHat provides a directory
of random patches that won't patch regardless of the order in
which you attempt patches (based upon date-stamps on patches or
date-stamps on files). It's like somebody just copied in some
junk, thinking nobody would ever bother.

Some distributions don't even provide source. They provide
copies of /usr/src/linux/include/asm and /usr/src/linux/include/linux
but nothing else. You have to "find" source on the internet.

Some distributions don't even provide that, instead they provide
copies of /usr/src/linux/include/linux and /usr/src/linux/include/asm
under /usr/include.

The "good-ol-days" where you could get 72 floppies from Yggdrasil,
install Linux, and spend the next 48 hours watching it compile
are long gone.

I have never found a distribution that uses modules, in which is
was even remotely possible to duplicate the kernel supplied.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


