Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287944AbSAPVh3>; Wed, 16 Jan 2002 16:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287940AbSAPVhV>; Wed, 16 Jan 2002 16:37:21 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:21204 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287944AbSAPVhC>; Wed, 16 Jan 2002 16:37:02 -0500
Message-Id: <200201161453.g0GEr0e9001275@tigger.cs.uni-dortmund.de>
To: root@chaos.analogic.com
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Tue, 15 Jan 2002 13:52:14 EST." <Pine.LNX.3.95.1020115133220.818B-100000@chaos.analogic.com> 
Date: Wed, 16 Jan 2002 15:53:00 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:

[...]

> Really???  Have you ever tried this? RedHat provides a directory
> of random patches that won't patch regardless of the order in
> which you attempt patches (based upon date-stamps on patches or
> date-stamps on files). It's like somebody just copied in some
> junk, thinking nobody would ever bother.

rpm(1), particularly "rpm -p" on the SRPM. Or use the kernel-source RPM.

Last time I looked, they carried around patches that weren't applied in the
SRPM.

> Some distributions don't even provide source. They provide
> copies of /usr/src/linux/include/asm and /usr/src/linux/include/linux
> but nothing else. You have to "find" source on the internet.

They are in violation of GPL then. Make it clear to them.

> The "good-ol-days" where you could get 72 floppies from Yggdrasil,
> install Linux, and spend the next 48 hours watching it compile
> are long gone.

What stops you from getting Red Hat, and doing a massive "rpm --rebuild"
today? 

> I have never found a distribution that uses modules, in which is
> was even remotely possible to duplicate the kernel supplied.

Why do they then bother to distribute sources?
-- 
Horst von Brand			     http://counter.li.org # 22616
