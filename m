Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSGaMkh>; Wed, 31 Jul 2002 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSGaMkh>; Wed, 31 Jul 2002 08:40:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:52998 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318078AbSGaMkg>; Wed, 31 Jul 2002 08:40:36 -0400
Date: Wed, 31 Jul 2002 09:43:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: "J.A. Magallon" <jamagallon@able.es>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Theurer <habanero@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <Pine.LNX.3.96.1020730230654.6974E-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0207310940350.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Bill Davidsen wrote:
> On Tue, 30 Jul 2002, J.A. Magallon wrote:
>
> > How about this version (gcc-3.2 generates the same amount of assembler):
>
> Now *that* is readable code!

Having code this readable is pretty much essential for
maintenance, too.

I wouldn't mind if every time I code or patch something
that isn't up to the reading standard of Mr. Magallon's
code somebody would raise his hand and/or LART me, until
the code is easily readable.

While developing the rmap VM we went through this process
for a number of iterations and the end result has been that
various people I've never heard of before managed to create
patches against the rmap code or ports of the rmap code to
2.5 that Just Worked.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

