Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273858AbRI0UGe>; Thu, 27 Sep 2001 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273872AbRI0UGY>; Thu, 27 Sep 2001 16:06:24 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:52490 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S273867AbRI0UGQ>;
	Thu, 27 Sep 2001 16:06:16 -0400
Message-ID: <3BB385C5.30992AD7@yahoo.com>
Date: Thu, 27 Sep 2001 16:02:13 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 0.01 disk lockup
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz> <20010927104706.B2968@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:

> Fantastic! who is the maintainer for the 0.x kernel series these days? I
> thought that 2.0 was Dave W., 2.2 was Alan, 2.4 Linus, so now we have to
> find people for 1.2 and finally get 1.2.14 released, man, how I wanted one
> with the dynamic PPP code in back in those days... 8)

Well, IIRC, Alan and DaveM were essentially 1.2.x maintainers with various
-ac and "ISS" patches (bonus points if you can remember what ISS stood for).
I've probably got some of those 1.2.13 patches around somewhere...

As for 1.0.9, at one point some years ago I had updated it (cf. linux-lite)
to compile with "new" gcc-2.7.2  when RAM was major $$$ - I don't imagine
it has been touched since.  

$ ls -l date
-rwxr-xr-x   1 root     root        13624 Sep  4  1992 date
$ ldd ./date
        /lib/libc.so.4 (4.0)
$ ./date
Thu Sep 27 15:58:19 EDT 2001
$ 

Wheee!  :)   Now if I just had a Decwriter for a serial console...

Paul.

