Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSK1BOs>; Wed, 27 Nov 2002 20:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSK1BOs>; Wed, 27 Nov 2002 20:14:48 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:27038 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265037AbSK1BOr>; Wed, 27 Nov 2002 20:14:47 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  v850 additions to include/linux/elf.h
References: <buoel987otw.fsf_-_@mcspd15.ucom.lsi.nec.co.jp>
	<1038325289.2594.37.camel@irongate.swansea.linux.org.uk>
	<buoel97kdx1.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<1038402095.6394.24.camel@irongate.swansea.linux.org.uk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Nov 2002 10:20:57 +0900
In-Reply-To: <1038402095.6394.24.camel@irongate.swansea.linux.org.uk>
Message-ID: <buok7iybibq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > If tidying is needed, then it seems like the best thing would be to move
> > all the arch-specific stuff into the corresponding <asm/elf.h> file for
> > each architecture.
> 
> I agree entirely. So lets start with v850 8)

Okay.  I sent the previous patch to Linus and he doesn't seem to have
taken it; perhaps your suggestion will fare better.

I'd like to remain consistent with other archs though -- does anyone
want to make a patch (I guess just move all the R_... constants) for them?

-Miles
-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
