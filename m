Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSJUR>; Tue, 19 Dec 2000 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbQLSJUI>; Tue, 19 Dec 2000 04:20:08 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:29213 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129289AbQLSJT7>; Tue, 19 Dec 2000 04:19:59 -0500
Date: Tue, 19 Dec 2000 10:56:51 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: jgoins@sunmine.com
cc: Andrew Morton <andrewm@uow.edu.au>, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: RE: Problem with 3c59x and 3C905B
In-Reply-To: <NCBBIGEIEDLIBLJACBEOEEECDGAA.jgoins@sunmine.com>
Message-ID: <Pine.LNX.4.21.0012191055170.9556-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000 jgoins@sunmine.com wrote:

> Andrew Morton wrote:
> >
> > Working out why your switch isn't talking full-duplex would
> > probably make things work too, but it's not a fix.
> >
> 
> He said he has a 10/100 hub (NG DS104) -- it is a half-duplex only 10/100
> hub.

10/100 hub doesn't imply half-duplex to me. I've also got a 10/100 thingy,
but it is full duplex.

Bit that still doesn't explainn why the driver lies :)

> Regards,
> JGoins
> jgoins@sunmine.com


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
