Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbRFLR5z>; Tue, 12 Jun 2001 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbRFLR5q>; Tue, 12 Jun 2001 13:57:46 -0400
Received: from www.transvirtual.com ([206.14.214.140]:9738 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262843AbRFLR5e>; Tue, 12 Jun 2001 13:57:34 -0400
Date: Tue, 12 Jun 2001 10:56:51 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Sergey Tursanov <__gsr@mail.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: PC keyboard rate/delay
In-Reply-To: <Pine.LNX.4.05.10106121920100.7169-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10106121056080.12879-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Because (almost?) all m68k machines don't have PC style keyboard controllers,
> so we _had_ to invent some other way to implement it in a portable (across all
> m68k machines) way.

This stuff is such a mess :-( Sparc has its own routines as well. 

> <wishful thinking>
> Of course it would be nice if all architectures would want to use it.
> </wishful thinking>

It will for 2.5.X :-)


