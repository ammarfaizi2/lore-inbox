Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbRFGVZV>; Thu, 7 Jun 2001 17:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbRFGVZB>; Thu, 7 Jun 2001 17:25:01 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:49426 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S263228AbRFGVY5>; Thu, 7 Jun 2001 17:24:57 -0400
Message-Id: <200106072123.f57LNQGk012773@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Keitaro Yosimura <ramsy@linux.or.jp>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help i18n system 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Thu, 07 Jun 2001 14:01:53 MST." <Pine.LNX.4.21.0106071351300.6604-100000@penguin.transmeta.com> 
Date: Thu, 07 Jun 2001 17:23:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:
> [ Kernel mailing list added to Cc ]
> On Thu, 7 Jun 2001, Keitaro Yosimura wrote:
> > Configure.help i18n system is the thing which uses MD5 SUM of the text
> > of the text as a key, and calls suitable data to the present language
> > setup (it judges from an environment variable).

[...]

> So I wonder if the Configure.help text should not possibly be even _more_
> distributed than just splitting it up into different files. It might very
> well be acceptable to actually distribute it over the net (and have just a
> mapping of config options into www-addresses or something).

I usually don't have a connection to the 'net when configuring a kernel...
and most people are like this, 24/7 Internet connections are still somewhat
of a rarity around here (and this country is "advanced" net-wise by non-US
standards). Plus adds the bloat of a browser to the configury.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
