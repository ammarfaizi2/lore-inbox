Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbTBUOT6>; Fri, 21 Feb 2003 09:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbTBUOT6>; Fri, 21 Feb 2003 09:19:58 -0500
Received: from yakko.cs.wmich.edu ([141.218.40.78]:53497 "EHLO yakko.cclub.net")
	by vger.kernel.org with ESMTP id <S267448AbTBUOT5>;
	Fri, 21 Feb 2003 09:19:57 -0500
Date: Fri, 21 Feb 2003 09:27:55 -0500 (EST)
From: Edward Killips <camber@yakko.cs.wmich.edu>
X-X-Sender: camber@yakko.cclub.net
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: toptan@eunet.eu, <linux-kernel@vger.kernel.org>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
In-Reply-To: <20030221122051.20942f70.deepfire@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0302210926250.8764-100000@yakko.cclub.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my GA-7VAXP (KT400) with an AIW 9700 Pro Radeon the agpgart module 
would not load. It could not set the apeture size.

-Edward Killips.


On Fri, 21 Feb 2003, Samium Gromoff wrote:

> >	GA-7VAXPUltra (KT400)   + ATI Radeon R9000      = passed.
> >                                                + GeForce 2MX400        = passed.
> >        Chaintech 7AJA2E (KT133)        + ATI Radeon R9000      = passed.
> >                                                + GeForce 2MX400        = passed.
> >
> >        Abit (i810)                             + ATI Radeon R9000      = passed.
> >                                                + GeForce 2MX400        = passed.
> 
>  From all this hardware only the KT400+R9000 pair possibly engage in AGP8x transfers,
> and i`m suspicious whether R9000 does it at all...
> 
>  So i think somebody testing it on real AGP3.0-capable hardware would do good...
> 
> regards, Samium Gromoff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

