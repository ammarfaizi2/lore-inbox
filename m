Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135853AbRAGRPn>; Sun, 7 Jan 2001 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136009AbRAGRPd>; Sun, 7 Jan 2001 12:15:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:50701 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135853AbRAGRPS>;
	Sun, 7 Jan 2001 12:15:18 -0500
Date: Sun, 7 Jan 2001 18:09:23 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: posix_types.h  error
In-Reply-To: <Pine.LNX.3.95.1010107084031.25234A-100000@chaos.analogic.com>
Message-ID: <Pine.Linu.4.10.10101071723420.1054-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Richard B. Johnson wrote:

> On Sun, 7 Jan 2001, Mike Galbraith wrote:
> 
> > Seriously though, the constraints look fine to me (and the register
> > name is there in the output constraint).  I'd say you have a busted
> > compiler.  None of the named compilers gripe.
> >
> 
> None of the named compilers gripe? Where, prey tell, do I get the source-
> code of a compiler that works? The only source provided in the site
> listed in the Documentation does not.

It's not the only source there.. egcs-1.1.2 is there as well.  You can
also try egcs.cygnus.com/pub/egcs or a mirror.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
