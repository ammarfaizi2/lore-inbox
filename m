Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSJUQ27>; Mon, 21 Oct 2002 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSJUQ26>; Mon, 21 Oct 2002 12:28:58 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28901 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261462AbSJUQ25>; Mon, 21 Oct 2002 12:28:57 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.5.43 - media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
Date: 21 Oct 2002 16:38:36 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnar8bcc.qnl.kraxel@bytesex.org>
References: <1034759764.3983.11.camel@turbulence.megapathdsl.net> <1035213501.27309.158.camel@irongate.swansea.linux.org.uk>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1035218316 27382 127.0.0.1 (21 Oct 2002 16:38:36 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/media/video/zr36120.o drivers/media/video/zr36120.c
> > In file included from drivers/media/video/zr36120.c:43:
> > drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or
> > directory
>  
>  This driver needs porting to the new i2c layer. There are some examples
>  of the newer i2c - eg saa5249 which are not too hard to follow.

... and other issues.  The zoran people are working on that as far
I know, but its more a driver rewrite than a quick&dirty fix ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
