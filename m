Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSB0AkL>; Tue, 26 Feb 2002 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290625AbSB0AkB>; Tue, 26 Feb 2002 19:40:01 -0500
Received: from cdserv.meridian-data.com ([206.79.177.152]:62986 "EHLO
	nasexs1.meridian-data.com") by vger.kernel.org with ESMTP
	id <S290587AbSB0Ajp>; Tue, 26 Feb 2002 19:39:45 -0500
Message-ID: <2D0AFEFEE711D611923E009027D39F2B153ADA@cdserv.meridian-data.com>
From: "Dennis, Jim" <jdennis@snapserver.com>
To: "'Chris Wright'" <chris@wirex.com>, "Dennis, Jim" <jdennis@snapserver.com>
Cc: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: crypto (was Re: Congrats Marcelo,)
Date: Tue, 26 Feb 2002 16:42:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 


> * Dennis, Jim (jdennis@snapserver.com) wrote:
> <snip>
>> As for LIDS, grsecurity, etc: I suspect it will be a cold day in hell
>> before Linus includes any of those into the mainstream.  I think it is
>> sufficient that he's willing to accommodate the LSM (security module)
>> to provide a common interface to all of the competing kernel hardening
>> packages.
> <snip>

> You may interested to know, LIDS has been ported to LSM, which is kept
> up-to-date for stable 2.4 releases, and (for those with bitkeeper) all
> 2.5-pres/stable.

> cheers,
> -chris

 Yes, I had read that.  Do you know of any effort to consolidate the 
 crypto libs in LIDS, patch-int, and FreeS/WAN KLIPS?  I'd like to think 
 that they can be maintained more efficiently and result in lower overhead
 and integration effort if the core crypto algorithms are consolidated
 among those three.

 (I remember someone found three? or four? different implementations of the
 same checksum code in the mainstream kernel a couple of years ago; I hope
 that's been fixed long since).

 (Any flames about my armchair coaching and pointed suggestions that I
 get in there and help with this are welcome --- off the list! I won't take 
 offense, I just don't want to burden everyone else's mailbox with that).

