Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287948AbSAPVkU>; Wed, 16 Jan 2002 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287932AbSAPVhP>; Wed, 16 Jan 2002 16:37:15 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:19412 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287939AbSAPVg5>; Wed, 16 Jan 2002 16:36:57 -0500
Message-Id: <200201161357.g0GDvSNf001237@tigger.cs.uni-dortmund.de>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Message from Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> 
   of "15 Jan 2002 09:04:16 PST." <1011114263.1145.13.camel@localhost.localdomain> 
Date: Wed, 16 Jan 2002 14:57:28 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> said:

[...]

> - Someday, a stupid government or court decides that there is a strict
> separation between source and binary.  Source is protected speech, but
> binaries are not.  Linux decides it wants a really fast DVD decryption
> in the kernel, so it adds it in drivers.  But now, distro's cannot
> compile and distribute a binary kernel package and the end user will
> need to compile the source code in order to watch their DVD.

No need for a full compile, just the offending driver. IF and WHEN it
happens. Till then, why bother?

> Why is it unrealistic for everybody to compile their kernel when they do
> an install?  If it is rather automated, then it just becomes another
> step on the progress bar.

If each time you install $distro you have to get compiler, linker, Python,
and whatnot up and running; and then have to wait a half hour or so for the
standard distributed kernel to compile, I don't see the point. Its much
easier/faster/secure to just distribute and install binaries.
-- 
Horst von Brand			     http://counter.li.org # 22616
