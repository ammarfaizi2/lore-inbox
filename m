Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131176AbRBHMLq>; Thu, 8 Feb 2001 07:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131177AbRBHMLh>; Thu, 8 Feb 2001 07:11:37 -0500
Received: from vulcan.datanet.hu ([194.149.0.156]:20804 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S131176AbRBHMLZ>;
	Thu, 8 Feb 2001 07:11:25 -0500
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: Datakart Geodzia KFT.
To: Louis Garcia <louisg00@bellsouth.net>
Date: Thu, 8 Feb 2001 13:10:40 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: nvidia fb 0.9.0 (0.9.2?)
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A7EF830.50805@bellsouth.net>
In-Reply-To: <E14Pqy4-0002vA-00@aleph0.datakart.hu>
X-mailer: Pegasus Mail for Win32 (v3.01d)
Message-Id: <E14Qpuo-0004aR-00@aleph0.datakart.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/me wrote:

> Louis Garcia <louisg00@bellsouth.net> wrote:
> 
> > I'm using XFree86-4.0.1 with the nv driver. You are right, it's ver 
> > 0.9.2 for the fb.
> >
> > Where can I get the patch? Should I upgrade to XFree86-4.0.2?
> 
> Not yet, we have to write that patch first... :) I'll grab an XFree 
> source soon.
> Please test other color depths too: 15bpp and 32bpp.

	Hi!

I've tried to reproduce your problem, but I failed. Rivafb 0.9.2 on 
Asus V3000 (Riva 128) with nv driver (from XFree-4.0.1g, Debian 
Woody) works fine for me. Would you like to try out some other XFree 
versions too?

Regards:
	Ferenc Bakonyi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
