Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSLIRbh>; Mon, 9 Dec 2002 12:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLIRbh>; Mon, 9 Dec 2002 12:31:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16548 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265819AbSLIRbg>; Mon, 9 Dec 2002 12:31:36 -0500
Date: Mon, 9 Dec 2002 12:40:43 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-BK] Needed patch to build ide-scsi with new IDE
 -ac merge
In-Reply-To: <1039311122.27923.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50L.0212091240280.11691-100000@freak.distro.conectiva>
References: <200212072055.55152.m.c.p@wolk-project.de> <20021207231841.GC3183@werewolf.able.es>
  <200212080021.31324.m.c.p@wolk-project.de> <1039311122.27923.2.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2002, Alan Cox wrote:

> On Sat, 2002-12-07 at 23:21, Marc-Christian Petersen wrote:
> > On Sunday 08 December 2002 00:18, J.A. Magallon wrote:
> >
> > Hi J.A.,
> >
> > > Ejem, does this mean that Andre's ide is going into 2.4.21-pre1 ?
> > > ;))))
> > finally!!!!!!!!!
>
> Yes though various bits seem to have vanished in the submission
> (system.h bits and ide-scsi). Davem has some follow up bits I need to
> apply (the new IDE broke some weird 64bit bigendian platform that he
> supports 8))

system.h bits ? Dunno about those.

I'm fixing the ide-scsi now.
