Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131464AbRA3AaA>; Mon, 29 Jan 2001 19:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131399AbRA3A3u>; Mon, 29 Jan 2001 19:29:50 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:8205 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131283AbRA3A3l>; Mon, 29 Jan 2001 19:29:41 -0500
Date: Mon, 29 Jan 2001 18:29:32 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010129182932.A23544@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.31.0101292041390.22513-100000@athlon.local> <MKWhxB.A.jLF.Gfdd6@dinero.interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <MKWhxB.A.jLF.Gfdd6@dinero.interactivesi.com>; from ttabi@interactivesi.com on Mon, Jan 29, 2001 at 02:51:18PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Timur Tabi]
> [ttabi@one DocBook]$ make pdfdocs
> Makefile:140: /Rules.make: No such file or directory
> 
> There's no Rules.make anywhere on my hard drive.

There had better be one in '../..'.  Do the 'make pdfdocs' from the top
level of the kernel source tree.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
