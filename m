Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSSS7>; Sun, 19 Nov 2000 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKSSSu>; Sun, 19 Nov 2000 13:18:50 -0500
Received: from web3403.mail.yahoo.com ([204.71.203.57]:64270 "HELO
	web3403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129136AbQKSSSb>; Sun, 19 Nov 2000 13:18:31 -0500
Message-ID: <20001119174826.16200.qmail@web3403.mail.yahoo.com>
Date: Sun, 19 Nov 2000 18:48:26 +0100 (CET)
From: Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Brian Gerst <bgerst@didntduck.org> wrote: 
> > Ok, that was it!  It's IRQ 13.  Guess I should
have
> > tried that first.  Now everything works perfectly.
> > Thanks everybody.
> 
> What motherboard do you have?  I can't reproduce
> this on my FIC SD11.
> 
> -- 
> 
> 				Brian Gerst

It's a ABIT KT7-100 RAID.  And I know somebody else
who has the same problem with this board.  So it seems
definitely board related.

--
Markus


__________________________________________________________________
Do You Yahoo!?
Gesendet von Yahoo! Mail - http://mail.yahoo.de
Gratis zum Millionär! - http://10millionenspiel.yahoo.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
