Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131785AbQKJWaY>; Fri, 10 Nov 2000 17:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131842AbQKJWaO>; Fri, 10 Nov 2000 17:30:14 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:9810 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131955AbQKJWaF>; Fri, 10 Nov 2000 17:30:05 -0500
Date: Sat, 11 Nov 2000 00:37:53 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <3A0C43D0.14039937@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011110034180.6465-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What about sendmail 8.11.1?  Is the problem there too?
> 
> Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> encryption.

Depends on how you configure it. An enabled encryption doesn't always mean
it has problems taking to other sendmails. This sendmail here has no
problems forwarding a mail > 400 Kb (I used 1.2 MB).

This is 8.11.1 with the MySQL mapper patch.

> > > ANyone have any ideas if what the sendmail people are saying is on the
> > > level, or is this just another sendmail bug.

I can't reproduce on 8.11.1

Maybe I can if someones tells me the exact procedure to reproduce it.

> > >
> > > Jeff
> > 
> > wfms


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
