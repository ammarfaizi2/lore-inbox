Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRDNUVA>; Sat, 14 Apr 2001 16:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDNUUu>; Sat, 14 Apr 2001 16:20:50 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:63750 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132539AbRDNUUe>;
	Sat, 14 Apr 2001 16:20:34 -0400
Date: Sat, 14 Apr 2001 16:20:23 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: Ishikawa <ishikawa@yk.rim.or.jp>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: "uname -p" prints unknown for Athlon K7 optimized kernel?
In-Reply-To: <3AD92D3B.EBBFC504@yk.rim.or.jp>
Message-ID: <Pine.LNX.4.33.0104141618440.13302-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW this is also the case for AMD-K6-3 and I would imagine all other AMD
processors.

B.

On Sun, 15 Apr 2001, Ishikawa wrote:

> Hi,
>
> On my athlong K7 optimized kernel prints "unknown" fir oricessir type.
> (I have not realized what this "unknown" stood for until today.)
>
>  #uname -p
> unknown
> #uname -a
> Linux duron 2.4.3 #2 Fri Apr 6 04:38:35 JST 2001 i686 unknown
>
> It would be nice to have the processor name printed.
>
> Is this kernel configuration procedure issue or
> `uname` problem?
>
> # which uname
> /bin/uname
> # file /bin/uname
> /bin/uname: ELF 32-bit LSB executable, Intel 80386, version 1,
> dynamically linked (uses shared libs), stripped
> # uname --version
> uname (GNU sh-utils) 2.0
> Written by David MacKenzie.
>
> Copyright (C) 1999 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is
> NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> #
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/

