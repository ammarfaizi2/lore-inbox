Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130196AbQKNRwA>; Tue, 14 Nov 2000 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbQKNRvk>; Tue, 14 Nov 2000 12:51:40 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:48901 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130196AbQKNRvf>; Tue, 14 Nov 2000 12:51:35 -0500
Date: Tue, 14 Nov 2000 12:21:30 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA66/100 errors...
In-Reply-To: <m13vjeb-000OYhC@amadeus.home.nl>
Message-ID: <Pine.LNX.4.21.0011141219580.735-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Arjan van de Ven wrote:

>Date: Tue, 14 Nov 2000 18:13:53 +0100 (CET)
>From: Arjan van de Ven <arjan@fenrus.demon.nl>
>To: Mike A. Harris <mharris@opensourceadvocate.org>
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: UDMA66/100 errors...
>
>In article <Pine.LNX.4.21.0011140138080.966-100000@asdf.capslock.lan> you wrote:
>
>[message 1]
>>
>>I'm using a standard 40pin cable measured at just less than 18 inches.
>
>[message 2]
>> This motherboard states that it does ATA/66.  I suspect that it
>> is the Linux IDE driver biting me this time..  ;o(
>
>> Time to upgrade kernels..
>
>Noooooo!
>Time to get the proper 80 ribbon cable that is required for ATA/66 and
>ATA/100!!!!!

It came with the 80 cable and I'm using it now with the exact
same results.  My BIOS says UDMA/82 for the one drive and UDMA/66
for the other.

Same speed result though.


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

[Favorite quotes of Linus Torvalds - Sept 6, 2000]
I'm a bastard. I have absolutely no clue why people can ever think
otherwise. Yet they do. People think I'm a nice guy, and the fact is that
I'm a scheming, conniving bastard who doesn't care for any hurt feelings
or lost hours of work if it just results in what I consider to be a better
system.  And I'm not just saying that. I'm really not a very nice person. 
I can say "I don't care" with a straight face, and really mean it.
        -- Linus Torvalds on linux-kernel mailing list

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
