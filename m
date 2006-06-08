Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWFHQHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWFHQHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFHQHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:07:06 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:52977 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964897AbWFHQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:07:05 -0400
Message-ID: <448849C6.4060005@comcast.net>
Date: Thu, 08 Jun 2006 12:01:10 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
References: <44862CE3.7040406@comcast.net>	<1149769487.3380.70.camel@laptopd505.fenrus.org>	<448843A4.8070102@comcast.net> <20060608090239.3da80037.rdunlap@xenotime.net>
In-Reply-To: <20060608090239.3da80037.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:
> On Thu, 08 Jun 2006 11:35:00 -0400 John Richard Moser wrote:
> 
>> Arjan van de Ven wrote:
>>> On Tue, 2006-06-06 at 21:33 -0400, John Richard Moser wrote:
> 
>>> now if you put your patch inline you'd get comments in detail
>>>
>> Hmm.  I hit "Attach" in Thunderbird.  Viewing the message shows the
>> patch inline with the message for me.  I wasn't aware I needed to do
>> something for that.  (Any help here is appreciated.. I'm sure I can't
>> just copy-paste the diff because Thunderbird likes to wrap long lines
>> PHYSICALLY)
> 
> Attachments don't show up in some mail clients.
> 

Nod.  I'll repost it then and just copy-paste it inline.

> See
> http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
> and
> http://lkml.org/lkml/2005/12/27/191
> 
> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIhJxAs1xW0HCTEFAQJvug/5AdAuLw2gMdtD86mn4VI8ojGoIDrN6yGt
QdrOBFISoDS3nNiUuIhHp1eSKkIiPcB+wIiqJCf5AWvbARg68mlWiLbaVIxXJWze
bUppI0MAfCzkozf7aL9pmWEYzIySWOtFQwyD953ojcRuJdh/QqaP3LJgMHepP6Ra
Uy57D+xB/etktfkx+Gm8WVrMsgJuvEhGJqiJmWlP0LRbz8lQ+pui91NhryLuK9qL
G5h6mpYwaPY8gwM6gelB0xD2oYrkMh/GaKPE8wY1pWMZEJ+b7ZmWYNAta1wx9QNi
aCZzQc7uzrL4nzOk9Iy/xm84iERb5817/6irqMZv6OVvFjw5syoXtS5saJkRnlgL
/y+AVu93dAmEqDcNHt3C+dsD9stTgSQ7wGs4kA2oz5uCW3CyHdQKw0SJFqixLavJ
Muz44UFU1DttaSyizEnAB3vCK+sf+lOccE5i57FNbvMliqst2O1pdy8G4blJpqXZ
c5H71aO/PfcB7RM8CCsUIMTCtTOpj3D7lAv3RXx8X9AyFK8tND+0CCxMyNg46Oes
rf+cL7qm0f4MRfFbKsZhztk//4wnOTRjXi1nakDhIJHfmnVwCXl1DTJ9KlLqWP5H
uMkLMpri5wnT7px3/E1oUyuVOsozkc1m9e8/vJmCw8v0PgpFJ896id4eRTw0byLZ
X1DXAL8Xzwo=
=ubTW
-----END PGP SIGNATURE-----
