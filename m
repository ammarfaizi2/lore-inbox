Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTBEIcN>; Wed, 5 Feb 2003 03:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTBEIcN>; Wed, 5 Feb 2003 03:32:13 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:45279 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267862AbTBEIcM>; Wed, 5 Feb 2003 03:32:12 -0500
Message-Id: <200302050841.h158fjJV001962@eeyore.valparaiso.cl>
To: Jeff Muizelaar <muizelaar@rogers.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance 
In-Reply-To: Your message of "Tue, 04 Feb 2003 17:59:29 EST."
             <3E4045D1.4010704@rogers.com> 
Date: Wed, 05 Feb 2003 09:41:45 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Massive Cc: snippage]

Jeff Muizelaar <muizelaar@rogers.com> said:

[...]

> There is also tcc (http://fabrice.bellard.free.fr/tcc/)
> It claims to support gcc-like inline assembler, appears to be much 
> smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
> problem either.
> Though, I am not really sure of the quality of code generated

Horrible.

>                                                               or of how 
> mature it is.

Nice for one-file throwaway C proggies. But then again, Perl is so much
better at what you'd want to do most of the time...

Look, people, the gcc folks have recently redone the guts of the compiler
to make more advanced optimizations possible/easier (look at the news for
2000-2002 at <http://gcc.gnu.org>). It still needs a lot of porting over of
optimizations and developing new ones, plus tuning, AFAIU.

The other open(ish) C compilers I know about are mere toys.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
