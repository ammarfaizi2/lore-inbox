Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbTATRnk>; Mon, 20 Jan 2003 12:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTATRnk>; Mon, 20 Jan 2003 12:43:40 -0500
Received: from smtp-server1.tampabay.rr.com ([65.32.1.34]:42693 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266316AbTATRnj>; Mon, 20 Jan 2003 12:43:39 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <root@chaos.analogic.com>, "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: egcs (or compatible) compiler
Date: Mon, 20 Jan 2003 12:52:52 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJCENDEEAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1030120114634.18629A-100000@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Try: http://gcc.gnu.org

..Scott

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Richard B.
> Johnson
> Sent: Monday, January 20, 2003 12:08
> To: Linux kernel
> Subject: egcs (or compatible) compiler
>
>
>
> I tried to find the "latest and greatest" gcc compiler that
> will compile the kernel. I can't find the source anywhere!
> Apparently, gnu doesn't "do" the compiler anymore, it's now
> called egcs and is supposed to be on goof.com according to
> the links from the GCC home page. They only have patches.
> The last source-code I have been able to find for gcc is
> gcc-3.0.1.tar.gz and it won't even compile under egcs-2.9.1.66
> (which I installed about a year ago before it became unavailable
> and dissappeared).
>
> So, what gives? Any hints on how I get the source of the most
> recommended gcc, that will actually compile on a previous version
> of gcc? I'm presently using egcs-2.9.1.66, but newer kernels won't
> compile using it. They fail to link with "__rawmemchr" errors, i.e.,
> caused by code that gets the string-length by doing strchr(s, 0),
> i.e., looks for the null. This envokes some __rammemchr() function
> that doesn't exist.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

