Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282181AbRKWRqC>; Fri, 23 Nov 2001 12:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282196AbRKWRpw>; Fri, 23 Nov 2001 12:45:52 -0500
Received: from [213.37.2.159] ([213.37.2.159]:30636 "EHLO alcorcon.madritel.es")
	by vger.kernel.org with ESMTP id <S282181AbRKWRpj>;
	Fri, 23 Nov 2001 12:45:39 -0500
To: linux-kernel@vger.kernel.org, roy@karlsbakk.net
Subject: Re: Which gcc version?
Message-Id: <E167Jsj-00002C-00@DervishD>
Date: Fri, 23 Nov 2001 18:12:53 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Roy :)))

>Which one should I use to compile the kernel?

    Dunno about RH, but I compile the kernel using gcc-3.0.1 and
works fine. Well, take into account that this is NOT the recommended
choice, since gcc 3.x series is not considered stable for the kernel.

    Anyway, I'm tired to having a compiler for binaries, another
compiler for the kernel, another one for libraries, etc... and I
compile all using gcc 3.0.1.

    Sooner or later the kernel will need to be ported to gcc 3.x
series, so, the sooner it gets tested with this compiler, the better.

    Anyway, if you have gcc 2.95.x installed onto your distro, use
that for the kernel for maximum stability.

    My compiled kernel works with gcc 3.x but it's a kernel with no
so many drivers. I don't know what kind of weird things can happen
with a heluvalota drivers kernel.

    Raúl
