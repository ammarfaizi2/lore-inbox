Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRKTCSA>; Mon, 19 Nov 2001 21:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRKTCRk>; Mon, 19 Nov 2001 21:17:40 -0500
Received: from bitmover.com ([192.132.92.2]:6308 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S280836AbRKTCRd>;
	Mon, 19 Nov 2001 21:17:33 -0500
Date: Mon, 19 Nov 2001 18:17:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<dervishd@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LOBOS
Message-ID: <20011119181731.D23210@work.bitmover.com>
Mail-Followup-To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= <dervishd@jazzfree.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E165yPH-000040-00@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E165yPH-000040-00@DervishD>; from dervishd@jazzfree.com on Tue, Nov 20, 2001 at 01:04:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been wanting Linux which can boot Linux for a long time.
See http://www.bitmover.com/ml for some slides on why, for those of you
who are guess, yes it is the same OS cluster idea for SMP scaling I've
been pushing on for 7 years.  It's finally getting some attention as
well, the IBM guys are looking at it, a FreeBSD guy is looking at it,
and the UML guy thinks he can do a UML implementation in such a way 
that putting it on real hardware would be a "simple" port.

On Tue, Nov 20, 2001 at 01:04:55AM +0100, RaúlNúñez de Arenas Coronado wrote:
>     Hello all :))
> 
>     I've reading a bit about booting Linux within Linux, and I'm
> pretty interested in this issue. The point here is, will a stable
> kernel support this in a near future?.
> 
>     There are a few alternatives like 'LOBOS' (which, IMHO, is the
> most portable, easy and small of all), 'bootimg', the two kernel
> monte, etc...
> 
>     This will be very useful for a lot of thinks: netbooting, initrd
> replacement, kernel switching and testing, etc...
> 
>     Have you think about adding this to the kernel. It won't enlarge
> the kernel and IMHO is a very good thing to have. Of course I'm not a
> kernel guru and I don't know what kind of problems this would arise.
> 
>     Have fun :)
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
