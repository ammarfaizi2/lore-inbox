Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSFAUKm>; Sat, 1 Jun 2002 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317048AbSFAUKl>; Sat, 1 Jun 2002 16:10:41 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:6798 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S317047AbSFAUKl>;
	Sat, 1 Jun 2002 16:10:41 -0400
Subject: Re: nfs problem 2.4.19-pre9
From: Kenneth Johansson <ken@canit.se>
To: trond.myklebust@fys.uio.no
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <15609.9599.590953.830508@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jun 2002 22:10:40 +0200
Message-Id: <1022962240.1186.62.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-01 at 21:50, Trond Myklebust wrote:
> >>>>> " " == Kenneth Johansson <ken@canit.se> writes:
> 
>      > I have three cards but they are all the same :( 3Com
>      > Corporation 3c905B 100BaseTX [Cyclone] (rev 30).
> 
>      > Also Why only this nfs mount. I can still telnet to other
>      > computers and use nfs on another mount point so it's not like I
>      > lose the network.
> 
> Fair enough. Have you tried a tcpdump?

No for the simple reason that I would not know what to look for.

I can send you a trace if you want. I guess you only need a trace from
the first stat to read fails but it has to wait an hour or two it's not
a good time to crash just now.


