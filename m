Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285370AbRLGF23>; Fri, 7 Dec 2001 00:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285377AbRLGF2T>; Fri, 7 Dec 2001 00:28:19 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:40196
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S285370AbRLGF2H>; Fri, 7 Dec 2001 00:28:07 -0500
Message-Id: <5.1.0.14.2.20011207002110.01eb0960@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Dec 2001 00:22:21 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011204194652.F360@khan.acc.umu.se>
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
 <E16BJ3x-0001qq-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:46 PM 12/4/2001 +0100, David Weinehall wrote:
>Yeah, let's lose the dependencies on perl, make, awk, sed, ld, ar,
>nm, strip, objcopy, objdump, depmod, grep, xargs, find, gzip,
>wish, tcl/tk and possibly others. That'd surely shave a lot of diskspace
>off my buildsystem. It's not like I use any of them for anything else...
>
>Hey, lets lose C and ASM too, and create all your binaries by
>writing hexvalues into a file.

Real kernel hackers use

# cat > /vmlinuz; lilo; shutdown -r now



--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

