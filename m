Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSKTNn4>; Wed, 20 Nov 2002 08:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266128AbSKTNn4>; Wed, 20 Nov 2002 08:43:56 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16257 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266125AbSKTNn4>; Wed, 20 Nov 2002 08:43:56 -0500
Subject: Re: spinlocks, the GPL, and binary-only modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037787457.19242.6.camel@localhost>
References: <024101c2903f$7650a050$41368490@archaic>
	<Pine.LNX.4.44L.0211200105090.4103-100000@imladris.surriel.com>
	<20021120081215.GC26018@mark.mielke.cc> 
	<1037787457.19242.6.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 14:19:15 +0000
Message-Id: <1037801955.3241.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 10:17, Xavier Bestel wrote:
> Yeah, that's precisely the problem here: the binary-only module is
> distributed with included spinlock code, which *is* GPL.

That doesnt neccessarily make it a derived work. Suppose I publish a
book including a lawyer who says "Your honour I ...". That doesn't make
it a derivative of some previous work I read that used the same phrase.

Equally if I paraphase the entire court scene but use no identical words
it may be a derived work. 

Stop thinking about this as a mathematical question. It isnt about the
union of sets of instructions.

Alan

