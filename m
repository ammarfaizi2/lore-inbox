Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRDOFhF>; Sun, 15 Apr 2001 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDOFg4>; Sun, 15 Apr 2001 01:36:56 -0400
Received: from seed.pacific.net.sg ([203.120.90.77]:58095 "EHLO
	seed.pacific.net.sg") by vger.kernel.org with ESMTP
	id <S132557AbRDOFgj>; Sun, 15 Apr 2001 01:36:39 -0400
Message-ID: <3AD933E5.5908BE2E@classical.2y.net>
Date: Sun, 15 Apr 2001 13:38:45 +0800
From: joker <linux@classical.2y.net>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: zh,zh-TW,zh-CN,en
MIME-Version: 1.0
To: Ishikawa <ishikawa@yk.rim.or.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: "uname -p" prints unknown for Athlon K7 optimized kernel?
In-Reply-To: <3AD92D3B.EBBFC504@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have this problem using intel 850mhz and 333mhz
any know where to get update version of uname ?

Ishikawa wrote:

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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

