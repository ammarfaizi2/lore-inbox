Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131641AbQL1Syn>; Thu, 28 Dec 2000 13:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbQL1Syd>; Thu, 28 Dec 2000 13:54:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:14097 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131632AbQL1Sy1>; Thu, 28 Dec 2000 13:54:27 -0500
Date: Thu, 28 Dec 2000 14:31:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: chris@freedom2surf.net
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Repeatable Oops in 2.4t13p4ac2
In-Reply-To: <978026911.3a4b819f71050@www.freedom2surf.net>
Message-ID: <Pine.LNX.4.21.0012281426330.12364-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000 chris@freedom2surf.net wrote:

> > > > > 
> > > > > Do you remember if the reports you've got always oopsed the same
> > > > > address (0040000) ? 
> > > > 
> 
> Hi - Here's another Oops from the same machine. It looks to be in a totally 
> different place in the code which probably means it's a memory problem?

Not necessarily, but it may be a memory problem.

> I'll try installing on another box to confirm.

You can run the memtest86 tool (you can find it at
http://reality.sgi.com/cbrady_denver/memtest86/), which is a more reliable
way to find out if its really a memory bug.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
