Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283715AbRK3RXl>; Fri, 30 Nov 2001 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283716AbRK3RXb>; Fri, 30 Nov 2001 12:23:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9746 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283715AbRK3RXU>; Fri, 30 Nov 2001 12:23:20 -0500
Subject: Re: Coding style - a non-issue
To: hps@intermeta.de (Henning Schmiedehausen)
Date: Fri, 30 Nov 2001 17:31:39 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), lm@bitmover.com (Larry McVoy),
        linux-kernel@vger.kernel.org
In-Reply-To: <1007140529.6655.37.camel@forge> from "Henning Schmiedehausen" at Nov 30, 2001 06:15:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169rVj-0004Cr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Flaming about coding style is about as pointless as flaming someone
> because he supports another sports team. There is no universal accepted
> coding style. Not even in C.

The kernel has an accepted coding style, both the documented and the
tradition part of it. Using that makes life a lot lot easier for maintaining
the code. Enforcing it there is a good idea, except for special cases
(headers shared with NT has been one example of that).

There are also some nice tools around that will do the first stage import of
a Hungarian NT'ese driver and linuxise it. 

Alan
