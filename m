Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131713AbQKJXiF>; Fri, 10 Nov 2000 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132153AbQKJXh4>; Fri, 10 Nov 2000 18:37:56 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:30767 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131713AbQKJXhq>; Fri, 10 Nov 2000 18:37:46 -0500
Date: Sat, 11 Nov 2000 01:45:33 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, wmaton@ryouko.dgim.crc.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <3A0C77DB.967732BE@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011110144250.6509-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Turn on encryption, and try sending attachements > 1MB and tell me if
> > > you see any problems, like emails sitting in /var/spool/mqueue for a day
> > > or two until they go out.  I can guarantee you will.
> > 
> > Are you talking client -> MTA encryption, or MTA -> MTA encryption ??
> 
> slow or blocked connection problems with all configs listed above.

Ah. I'll go kick this sendmail setup, and see what it does..


> Jeff


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
