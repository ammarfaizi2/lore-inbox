Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSGaANQ>; Tue, 30 Jul 2002 20:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSGaANP>; Tue, 30 Jul 2002 20:13:15 -0400
Received: from mail.costarica.net ([196.40.25.178]:23015 "EHLO
	mail.costarica.net") by vger.kernel.org with ESMTP
	id <S317464AbSGaANO>; Tue, 30 Jul 2002 20:13:14 -0400
Date: Tue, 30 Jul 2002 18:19:43 -0600 (CST)
From: Miguel A Bolanos <mike@costarica.net>
To: Shanti Katta <katta@csee.wvu.edu>
cc: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: what version of gcc can be used to build kernels on Linux/sparc64?
In-Reply-To: <1028071043.18556.4.camel@indus>
Message-ID: <Pine.LNX.4.33.0207301811060.26026-100000@mail.costarica.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again

On 30 Jul 2002, Shanti Katta wrote:

> I should have asked more specifically. But I am trying to compile
> user-mode-linux on Ultrasparc(running Debian). egcs64 compiles just
> kernelspace code. I want to know what compiler can be used to build
> user-mode-linux(which contains some userspace and some kernelspace code)
> 64-bit on Ultrasparc? gcc-3.0 seems to give problems with linker. I am
> not sure if any other version of gcc is capable of doing that.

Have you get the chance to try it with gcc-3.1? anyways gcc-3.2 was
scheduled to be released on 2002-07-2x so it should be released at any
moment, and the linker problems should be solved
yours

Miguel Bolanos

>
> Thanks in advance
> -Regards
> -Shanti
> On Tue, 2002-07-30 at 18:15, Miguel A Bolanos wrote:
> > Just use egc64 if its only for the kernel, or if you want to for the
> > kernel and some packages  use gcc3
> > yours
> >
> > --
> > Miguel A. Bolanos
> > Servers Administrator
> > Informatica International
> > --
> >
> > On 30 Jul 2002, Shanti Katta wrote:
> >
> > > I would like to know what version of gcc is currently available to build
> > > linux kernels on Linux/Sparc64. I would like the builds to generate
> > > 64-bit executables.
> > >
> > > -Shanti
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

