Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136118AbRDVNvQ>; Sun, 22 Apr 2001 09:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136119AbRDVNvD>; Sun, 22 Apr 2001 09:51:03 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:2826 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S136118AbRDVNui>; Sun, 22 Apr 2001 09:50:38 -0400
Date: Sun, 22 Apr 2001 09:49:52 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Hartmann <andihartmann@freenet.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.3ac11] clock timer configuration lost - probably a VIA686a
 motherboard
In-Reply-To: <E14rJGD-0005lO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0104220946520.4950-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well... I remember this message showing on my console, although I was
doing nothing special...

Apr 18 14:37:01 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:37:01 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:41:18 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:41:18 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:47:10 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:47:10 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:48:28 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:48:28 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:49:02 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:49:02 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:51:06 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:51:06 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:51:48 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:51:48 blackbird kernel: probable hardware bug: restoring chip
configuration.
--
Apr 18 14:52:01 blackbird kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Apr 18 14:52:01 blackbird kernel: probable hardware bug: restoring chip
configuration.
--

[root@blackbird log]# uname -a
Linux blackbird.tecnoera.com 2.2.19 #2 Wed Apr 11 12:23:14 CLT 2001 i686
unknown
[root@blackbird log]#



On Sun, 22 Apr 2001, Alan Cox wrote:

> > I got a lot of messages while continuous writing / reading datas from one a
> > harddisk to another harddisk (both at 1. ide-channel) during backup with
> > rsync. Both harddisks use udma4. The data-stream was between 0,5 MB/s and
> > 20MB/s.
> > I never got these messages before and after the backup finished I couldn't
> > see them anymore.
>
> Thy do trigger to easily. Im still investigating that
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

