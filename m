Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271854AbRICXBT>; Mon, 3 Sep 2001 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271855AbRICXBJ>; Mon, 3 Sep 2001 19:01:09 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:11214 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S271854AbRICXA6>; Mon, 3 Sep 2001 19:00:58 -0400
Date: Mon, 3 Sep 2001 16:03:30 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Thiago Vinhas de Moraes <tvlists@networx.com.br>
cc: <linux-kernel@vger.kernel.org>, <seawolf-list@redhat.com>
Subject: Re: Sound Blaster Live - OSS or Not?
In-Reply-To: <200109032210.f83MA8j15720@jupter.networx.com.br>
Message-ID: <Pine.LNX.4.33.0109031555360.24150-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Thiago Vinhas de Moraes wrote:

>
> Hi!
>
> I have a Sound Blaster Live! PCI that works pretty fine for me.
>
> I tried to run loki's Quake 3 Arena for Linux, and after several tries, I
> started to read the README file, and it said that Sound Blaster Live does not
> work as OSS. I found a reference to www.opensound.com, where they sell OSS
> drivers for Sound Blaster Live for $35.00 !! That's too much money for a
> sound driver! I've downloaded a trial, and it really worked to play Quake.
>
> My question is: If the 2.4.9 kernel has support for Sound Blaster Live, why I
> have to pay for a damn non-GPL driver? Why it does not work to play games on
> linux?

sound support is hard... The folks at 4-front have the benefit of a
liscense from the vendor for their intelectual property property used in
the driver... That has two implications, The code is proprietary, and the
vendor must be paid... I don't imagine they're getting rich in the
business but if you have a card that has a chipset that is supported well
by them and poorly by the various other sound initiatives, you have to
decide wether it's worth it or not.

In any case your card is fairly well supported by the alsa-project... so
I'd recomend trying the alsa drivers

>
> Regards,
> Thiago
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


