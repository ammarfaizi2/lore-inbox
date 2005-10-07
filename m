Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVJGPdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVJGPdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbVJGPdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:33:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8425 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030396AbVJGPdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:33:15 -0400
Message-Id: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc). 
In-Reply-To: Message from =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net> 
   of "Fri, 07 Oct 2005 16:21:40 +0200." <200510071621.41249.pluto@agmk.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 07 Oct 2005 11:33:09 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 07 Oct 2005 11:33:10 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paweł Sikora <pluto@agmk.net> wrote:
> Dnia piątek, 7 października 2005 15:46, Horst von Brand napisał:

[...]

> > binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken tools.

> I didn't say that is (or not) a binutils bug.
> I'm only saying that kernel is killng a valid micro application.

If binutils generates an invalid executable, it is not a valid application.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
