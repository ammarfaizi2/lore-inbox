Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271306AbRHTP1t>; Mon, 20 Aug 2001 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271297AbRHTP1j>; Mon, 20 Aug 2001 11:27:39 -0400
Received: from mx3.port.ru ([194.67.57.13]:7431 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S271307AbRHTP1c>;
	Mon, 20 Aug 2001 11:27:32 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: justin@bouncybouncy.net
Cc: green@linuxhacker.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.8-ac7 sound crashes
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.171]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15YqxW-000I3h-00@f3.mail.ru>
Date: Mon, 20 Aug 2001 19:27:22 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >   Can you publish decoded oops?
> > >   And can you try 2.4.9 first to check it exhibits >same behaviour?
> >
> >     1. quite impossible due to the fact of exceedingly
> > high rate at which this trace is running:
> >   30 rows/second approx, and the impossibility to
> >   switch consoles/use gpm for cut/paste...
> Try pressing the scroll lock key.

_maybe_ i can, but i think the value of the infinite
call trace can be argued, besides it will be quite hard
to realise... :)
i say maybe, because when this shit happens, alt+sysrq
combo doesnt seem to work, so it hardly can be that
scrolllock works. as i said console switching is dead
too, so i doubt other console-controlling keys will do.

-------
cheers,

   Samium Gromoff
