Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSGQHGT>; Wed, 17 Jul 2002 03:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSGQHGS>; Wed, 17 Jul 2002 03:06:18 -0400
Received: from slider.rack66.net ([212.3.252.135]:43013 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP
	id <S317949AbSGQHGR>; Wed, 17 Jul 2002 03:06:17 -0400
Date: Wed, 17 Jul 2002 09:09:49 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, fischer@norbit.de,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] aha152x fix
Message-ID: <20020717070949.GA10929@debian>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, fischer@norbit.de,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020716231003.A488@lucretia.debian.net> <1026860430.1688.95.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026860430.1688.95.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 17, 2002 at 12:00:30AM +0100, Alan Cox wrote:
> On Tue, 2002-07-16 at 22:10, Filip Van Raemdonck wrote:
> > 
> > I upgraded from 2.4.19-pre7 to -rc1 and this resulted in my aha152x card not
> > working anymore. (The error was "trying software interrupt, lost")
> > 
> > Below is a patch which makes it work again. Note that this is just reverting
> > a minimal part of the last applied patch to aha152x.c; so this may only be
> > fixing the symptom and not the problem.
> 
> I've seen reports but not figured out what is going on yet. Are you
> using an AHA152x or the PCMCIA version ?

An ISA - non PNP - aha1515 if I'm not mistaken (I can't check the exact type
right now but I'm quite sure I'm right). Definitely not PCMCIA.


Regards,

Filip

-- 
<liiwi> www.benefon.fi is running Microsoft-IIS/4.0 on Solaris
<netgod> neat trick
<liiwi> hmms. how come I think that netcraft is on crack
