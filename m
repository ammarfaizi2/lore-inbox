Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSG3XGo>; Tue, 30 Jul 2002 19:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSG3XGn>; Tue, 30 Jul 2002 19:06:43 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:51704 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S317279AbSG3XGm>; Tue, 30 Jul 2002 19:06:42 -0400
Subject: Re: what version of gcc can be used to build kernels on
	Linux/sparc64?
From: Shanti Katta <katta@csee.wvu.edu>
To: Miguel A Bolanos <mike@costarica.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0207301613370.20597-100000@mail.costarica.net>
References: <Pine.LNX.4.33.0207301613370.20597-100000@mail.costarica.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 19:17:23 -0400
Message-Id: <1028071043.18556.4.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have asked more specifically. But I am trying to compile
user-mode-linux on Ultrasparc(running Debian). egcs64 compiles just
kernelspace code. I want to know what compiler can be used to build
user-mode-linux(which contains some userspace and some kernelspace code)
64-bit on Ultrasparc? gcc-3.0 seems to give problems with linker. I am
not sure if any other version of gcc is capable of doing that.

Thanks in advance
-Regards
-Shanti
On Tue, 2002-07-30 at 18:15, Miguel A Bolanos wrote:
> Just use egc64 if its only for the kernel, or if you want to for the
> kernel and some packages  use gcc3
> yours
> 
> --
> Miguel A. Bolanos
> Servers Administrator
> Informatica International
> --
> 
> On 30 Jul 2002, Shanti Katta wrote:
> 
> > I would like to know what version of gcc is currently available to build
> > linux kernels on Linux/Sparc64. I would like the builds to generate
> > 64-bit executables.
> >
> > -Shanti
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


