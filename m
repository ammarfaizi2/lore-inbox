Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSEZIGP>; Sun, 26 May 2002 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSEZIGO>; Sun, 26 May 2002 04:06:14 -0400
Received: from bs1.dnx.de ([213.252.143.130]:18092 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315785AbSEZIGO>;
	Sun, 26 May 2002 04:06:14 -0400
Date: Sun, 26 May 2002 10:05:39 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526100539.M598@schwebel.de>
In-Reply-To: <20020525150542.B17889@work.bitmover.com> <20020525221751.41FC311972@denx.denx.de> <20020525161034.L28795@work.bitmover.com> <20020526015609.F598@schwebel.de> <20020525204026.D19792@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 08:40:26PM -0700, Larry McVoy wrote:
> My first problem is that this is a partial sampling of the source base.
> My second problem is that Paolo Mantegazza isn't the original author of
> that file.

We'll discuss that on the RTAI mailing list. 

> Well, I find it misleading. It makes it sound like you have rights to that
> code that you don't and it makes it sound like it is LGPLed.

You are right, and be sure we'll do our best to clarify the situation as
good as possible. Take into account that the license change took place just
recently and there are surely things left which have to be cleaned up. It
is common agreement between the RTAI team that patches and schedulers are
GPL, self-developed services are LGPL. 

Sidenote: before the 24.1.9 release we publically asked on the RTAI mailing
list if we have missed somebody in the "authors" file: 

  http://www.realtimelinux.org/archives/rtai/20024/0066.html

Nobody has spoken up who is not listed there so far. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
