Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274251AbRISXE3>; Wed, 19 Sep 2001 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274253AbRISXEN>; Wed, 19 Sep 2001 19:04:13 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:23559 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S274251AbRISXDu>;
	Wed, 19 Sep 2001 19:03:50 -0400
Date: Wed, 19 Sep 2001 20:04:56 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] VIA bug stomper. Pls apply.
In-Reply-To: <007001c14150$adcd0c10$0300a8c0@methusela>
Message-ID: <Pine.GSO.4.21.0109192003270.1374-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Aaron Tiensivu wrote:

> > I've been busy working on other things, and being ill. I've not yet
> pursued
> > it with them
> 
> A minor nit I have with the patch is that it printk's out "Stomping the
> Athlon bug", which in actuality is more likely a VIA bug because the
> symptoms don't show up in other Althon based chipsets..

Anyone tried changing the CPU of a oopsing system to check if it's the CPU
or the mobo? I have no other athlon/duron or motherboard to try here.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

