Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291356AbSBGWM1>; Thu, 7 Feb 2002 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSBGWMR>; Thu, 7 Feb 2002 17:12:17 -0500
Received: from [216.163.188.202] ([216.163.188.202]:48394 "EHLO
	C9Mailgw01.amadis.com") by vger.kernel.org with ESMTP
	id <S291384AbSBGWMA>; Thu, 7 Feb 2002 17:12:00 -0500
Message-ID: <3C62FB81.E053B660@starband.net>
Date: Thu, 07 Feb 2002 17:11:13 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Information & Install Kernel Script
In-Reply-To: <3C6267B7.30A3020D@starband.net> <a3ut0u$f60$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps, however I began ik in December 2000.
No /sbin/installkernel existed at the time.
And /sbin/installkernel doesn't support grub on my rh72 box.
Nor does it check dependencies, etc, etc.

"H. Peter Anvin" wrote:

> Followup to:  <3C6267B7.30A3020D@starband.net>
> By author:    Justin Piszcz <war@starband.net>
> In newsgroup: linux.dev.kernel
> >
> > New site: http://www.installkernel.com/
> > It is very light at the moment.
> >
> > 1] Latest news about the kernel:
> >    http://www.installkernel.com/kernel.html
> >    Anything else I should add under 2.4.17?
> >
> > 2] Install Kernel (bash script which I am working on)
> >     http://www.installkernel.com/ik/index.html
> >     ik-0.8.9: Adds -b option, you can build and install the kernel from
> > the current directory with -b.
> >     Summary of ik:
> >     Install Kernel (ik) is a bash script that installs the Linux kernel
> > and automatically sets up LILO or GRUB.
> >     It also saves your kernel configuration each time you do an install.
> > This allows you to restore the newest
> >     configuration file when you make a new kernel. This script is
> > intended for two groups of people; people
> >     new to compiling kernels, and people who are tired of moving files
> > around and editing their bootloader
> >     configurations every time they install a new kernel.
> >
>
> Sounds like you should make this work as /sbin/installkernel.
>
>         -hpa
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt    <amsp@zytor.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

