Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266884AbRGKXD0>; Wed, 11 Jul 2001 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266882AbRGKXDQ>; Wed, 11 Jul 2001 19:03:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11537 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266880AbRGKXDC>;
	Wed, 11 Jul 2001 19:03:02 -0400
Date: Wed, 11 Jul 2001 20:02:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Kip Macy <kmacy@netapp.com>
Cc: Paul Jakma <paul@clubi.ie>, Helge Hafting <helgehaf@idb.hist.no>,
        "C. Slater" <cslater@wcnet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <Pine.GSO.4.10.10107111545130.14769-100000@clifton-fe.eng.netapp.com>
Message-ID: <Pine.LNX.4.33L.0107112000250.9899-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Kip Macy wrote:

> In the future when Linux is more heavily used at the enterprise level
> there will likely be upgrade/revert modules to allow such a transition
> to take place.

Only if somebody takes the trouble to write them, which
isn't something I see happening in the near future.

Not only would this feature be a LOT of work, it would
(probably) also be very invasive all over the kernel.
OTOH, if the kernel was compiled with -g maybe it'd have
enough info to locate its data structures ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

