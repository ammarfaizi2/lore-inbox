Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbQL1Rrn>; Thu, 28 Dec 2000 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbQL1Rrc>; Thu, 28 Dec 2000 12:47:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18450 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130069AbQL1RrS>; Thu, 28 Dec 2000 12:47:18 -0500
Subject: Re: Repeatable Oops in 2.4t13p4ac2
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Thu, 28 Dec 2000 17:18:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), chris@freedom2surf.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012281305530.12295-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Dec 28, 2000 01:06:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BghF-0003wu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Alan, 
> > > 
> > > Do you remember if the reports you've got always oopsed the same
> > > address (0040000) ? 
> > 
> > They vary in report
> 
> Doesn't it sounds like memory problems? 

For -ac Im working on the assumption I introduced a bug into the mm code

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
