Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277199AbRJINZY>; Tue, 9 Oct 2001 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277189AbRJINZO>; Tue, 9 Oct 2001 09:25:14 -0400
Received: from august.V-LO.krakow.pl ([62.121.131.17]:20740 "EHLO
	august.V-LO.krakow.pl") by vger.kernel.org with ESMTP
	id <S277199AbRJINZD>; Tue, 9 Oct 2001 09:25:03 -0400
Date: Tue, 9 Oct 2001 15:26:14 +0200 (CEST)
From: "[solid]" <solid@V-LO.krakow.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kernel size
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0110091525160.6391-100000@august.V-LO.krakow.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might not be right, but I thing gcc 3.x aligns some data differently
then previous versions, which sometimes causes executables to be
bigger...

[solid]
Registered Linux user number 212159

On Tue, 9 Oct 2001, VDA wrote:

> Hi folks
>
> I recompiled my kernel with GCC 3.0.1 (was 2.95.x)
> and guess what - it got bigger...
> Somehow, I hoped in linux world software gets better
> with time, not worse...
>
> Maybe that's my fault (misconfigured GCC etc) ?
> What do you see?
>
> Being curious, I looked into vmlinux (uncompressed kernel).
> I saw swatches of zero bytes in places, large repeateable
> patterns etc. You may look there too in your spare time.
>
> Especially informative are two pages (my console:100x40)
> filled with "GCC: (GNU) 3.0.1". Does this gets into
> unswappable memory when kernel loads?
> --
> Best regards, VDA
> mailto:VDA@port.imtp.ilyichevsk.odessa.ua
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

