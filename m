Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSLIODO>; Mon, 9 Dec 2002 09:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSLIODO>; Mon, 9 Dec 2002 09:03:14 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:58321 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265508AbSLIODN> convert rfc822-to-8bit; Mon, 9 Dec 2002 09:03:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: kaih@khms.westfalen.de (Kai Henningsen), alan@lxorguk.ukuu.org.uk
Subject: Re: is KERNEL developement finished, yet ???
Date: Mon, 9 Dec 2002 08:08:34 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <1039111796.19636.27.camel@irongate.swansea.linux.org.uk> <8bPzdb6mw-B@khms.westfalen.de>
In-Reply-To: <8bPzdb6mw-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212090808.34598.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 December 2002 02:39 pm, Kai Henningsen wrote:
> alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 05.12.02 in 
<1039111796.19636.27.camel@irongate.swansea.linux.org.uk>:
> > On Thu, 2002-12-05 at 12:54, Joseph D. Wagner wrote:
> > > I don't know of any mistakes per say, but if I had to do it over again,
> > > there's about a thousands things I'd do differently (preference in
> > > design choices, not mistakes) especially not to cling so religiously to
> > > POSIX compliance.
> >
> > And then you'd have no applications.
>
> And this is why every existing OS is POSIX compliant.
>
> What do you mean, it isn't?
>
> People actually started new, incompatible OSes from time to time, for
> which there were no applications, and some of those actually succeeded?

No - they have pretty much all failed except M$, and that one is showing 
cracks.

> And in fact Unix was one of those?

Unix DEFINED the standard. Before that, there were many "standards", a minimum
of one for each vendor, and frequently, several for each vendor. IBM almost
had one for every product line, DEC had one for each major product line, and
three different major OSs (though related) for the PDP11 (RSX 11, IAS, RSTS)
and one minor (RT-11). Each had it's own runtime, compilers/assemblers,
utilities, and system calls.

The POSIX definitions were adaped from the AT&T "System V Interface
Definition" issued in 1984/1985, which standardized AT&T Unix from about 1982
through 1985 (the existing commands/utilities/libraries definitions were
included).

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
