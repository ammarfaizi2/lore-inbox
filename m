Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSL3SNJ>; Mon, 30 Dec 2002 13:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSL3SNJ>; Mon, 30 Dec 2002 13:13:09 -0500
Received: from mail2.scram.de ([195.226.127.112]:49670 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S267022AbSL3SNI>;
	Mon, 30 Dec 2002 13:13:08 -0500
Date: Mon, 30 Dec 2002 19:20:47 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Markus Pfeiffer <profmakx@profmakx.org>
cc: Sam Ravnborg <sam@ravnborg.org>, Larry McVoy <lm@work.bitmover.com>,
       Hannes Reinecke <mail@hannes-reinecke.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha port still maintained in 2.5
In-Reply-To: <200212301913.28503.profmakx@profmakx.org>
Message-ID: <Pine.LNX.4.44.0212301915070.10908-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> Anyway, I just installed BitKeeper and start finding my way into the code...

Maybe setting up an own repository (like the parisc, mips, m68k, etc
people currently do using CVS) would also be a good idea, just to test out
stuff before pushing it into the main tree and to have a common code base
to work on.

This way we could apply e.g. the module patch from kernel.org and fix the
remaining parts.

just my 0,02 EURO
--jochen

