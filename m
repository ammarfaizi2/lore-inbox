Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWESR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWESR0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWESR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:26:40 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:40185 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751387AbWESR0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:26:40 -0400
Message-ID: <446DFEB8.8020302@comcast.net>
Date: Fri, 19 May 2006 13:22:00 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
References: <446D61EE.4010900@comcast.net> <446DA5B0.8020703@lumumba.uhasselt.be>
In-Reply-To: <446DA5B0.8020703@lumumba.uhasselt.be>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Panagiotis Issaris wrote:
> Hi,
> 
> John Richard Moser wrote:
> 
>> [...]
>> Scrambling for an old machine is ridiculous.  Down-clocking makes sense
>> because you can adjust to varied levels; but it's difficult and usually
>> infeasible.  Pulling memory and mix and matching is not much better.
>>
>> On Linux we have mem= to toy with memory, which I personally HAVE used
>> to evaluate how various distributions and releases of GNOME operate
>> under memory pressure.  This is a lot more convenient than pulling chips
>> and trying to find the right combination.  This option was, apparently,
>> designed for situations where actual system memory capacity is
>> mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
>> is 255M....); but is very useful in this application too.
>> [...]
>>  
>>
> An easier way might be to use a system emulator like Qemu.
> You can specify the amount of memory the emulated system has,
> and if you do not use the kernel accelerating module (kqemu)
> it slows down considerably.
> 

Yes but it slows down to like a 25MHz system :)

> Of course, it would be nicer if you could actually specify performance
> levels and an issue with this approach is that it does not uniformly
> scale down performance: I think IO emulation performance is a lot worse
> then CPU emulation performance (in Qemu).

Yep.

> 
> With friendly regards,
> Takis
> 
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

iQIVAwUBRG3+tgs1xW0HCTEFAQJ2ow/+KOKJNdX5d1pSZ36u+lT6AIs8yN0LSbS5
VVKFJLMrZWf0BfRgvxyGjazlEXbIaYeaSXYGr5+Gkbztr0cJ1/WyyO9dhEvVS8uq
YJP9GAjfcsmrtLZT49jM/9XimK2xGgAFExmbxmEXFtGrcVanzFA/zvSiqbJmUMEt
z+4BR7wKX/Q+iBKrSLibCTLlzpstI8YXhZxMVR2ZOfFU18nl7Pv5Y9sUB6EUKu2V
6B1eT0pBQ+bLtKhsNbOIOvGUpzkpe/bHAqBzxYLugBclmyM3SFoncHDXpg08qoVm
LIXJi0Y/QJQovQlbzRz+Xse0IibBCPd4+jGNjk6/fkIvVqZVvGsLFHrmb5S0v4W7
qBB4atl7w7tb29J/gzPqAlqaqc/eNI3ZtNG/KEfvEqjaTHuc6mIXjs6OHyimXDgD
WPvNZYrxwLoXhCCSkzlZ8BgEjL59DXtR8YZoEI3tSI9k9HnuKe4sv5dbCntsdsTR
d0o5Kvcil6aZKJWx9St8BafOpcGff2D3YpzgcmBhUhYoX/Ni1+1fgnuha+Oo9W7i
+TMOf8DwV+oUBV4hHbLXQzkDBu/dT60LrieYRANQxHx1uDh55S66Uk1pmhu74iw1
NCxZbok20007Hzle3Se9qL6f7r4XdDQHI6bUcu5JgJyv+pVQcOdkLZSClVYAQkVn
pwYsqzp/KJk=
=Cmvr
-----END PGP SIGNATURE-----
