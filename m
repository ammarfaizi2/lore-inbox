Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273894AbRI0Usr>; Thu, 27 Sep 2001 16:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273895AbRI0Ush>; Thu, 27 Sep 2001 16:48:37 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:6916
	"EHLO awak") by vger.kernel.org with ESMTP id <S273894AbRI0Us1> convert rfc822-to-8bit;
	Thu, 27 Sep 2001 16:48:27 -0400
Subject: Re: 2.4.9-ac15 sluggish
From: Xavier Bestel <xavier.bestel@free.fr>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0109271212100.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109271212100.19147-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.08.00 (Preview Release)
Date: 27 Sep 2001 22:43:15 +0200
Message-Id: <1001623396.18174.14.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le jeu 27-09-2001 at 17:13 Rik van Riel a écrit :
> We discovered a merge bug, -ac15 has a few lines in
> try_to_swap_out() 10 lines higher than they were in
> the patch I sent to Alan ;)
> 
> This is fixed in the age+launder patch from my home
> page ard in the vmscan.c I sent to Alan for -ac16.

Mmmh ... i'm now compiling (make -j5) -ac16 under -ac15-age+launder and
it's sluggish: xmms drops audio sometimes, my mouse pointer is jerky.


         Xav

