Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272817AbRIPUtG>; Sun, 16 Sep 2001 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRIPUs5>; Sun, 16 Sep 2001 16:48:57 -0400
Received: from cs6669232-106.austin.rr.com ([66.69.232.106]:9344 "HELO
	erik.bigsexymo.com") by vger.kernel.org with SMTP
	id <S272817AbRIPUsq>; Sun, 16 Sep 2001 16:48:46 -0400
Date: Sun, 16 Sep 2001 15:47:14 -0400 (EDT)
From: Erik Elmore <erik@bigsexymo.com>
To: Polymorphic Anomaly <linux.geeke@verizon.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: gamecon.c in 2.4.x series
In-Reply-To: <3BA506AE.6583DD@verizon.net>
Message-ID: <Pine.LNX.4.33.0109161545580.1127-100000@erik.bigsexymo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar problem so I used both the parport and the gamecon code
from ac10 and used them with the official 2.4.9 kernel to get it to work

-Erik

On Sun, 16 Sep 2001, Polymorphic Anomaly wrote:

> Hello, I have been having trouble with a SNES controller on the parport,
> where, on say, 2.4.8, the upper and left buttons are stuck "down" and
> nothing else is accepted as input. In newer kernels, including the
> 2.4.9-ac10, it simply does nothing
>
> any help would be greatly appreciated.
>
> Poly
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

