Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291393AbSAaXO1>; Thu, 31 Jan 2002 18:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291395AbSAaXOS>; Thu, 31 Jan 2002 18:14:18 -0500
Received: from www.transvirtual.com ([206.14.214.140]:58129 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291394AbSAaXN6>; Thu, 31 Jan 2002 18:13:58 -0500
Date: Thu, 31 Jan 2002 15:12:49 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Vojtech Pavlik <vojtech@ucw.cz>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Q40 input api support.
In-Reply-To: <Pine.GSO.4.21.0201312155500.24581-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10201311512340.23385-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/serio/q40kbd.c linux/drivers/input/serio/q40kbd.c
> > --- linux-2.5.2-dj7/drivers/input/serio/q40kbd.c	Wed Dec 31 16:00:00 1969
> > +++ linux/drivers/input/serio/q40kbd.c	Thu Jan 31 10:41:56 2002
> > @@ -0,0 +1,104 @@
> > +/*
> > + * $Id: q40kbd.c,v 1.9 2002/01/23 06:20:52 jsimmons Exp $
> > + *
> > + *  Copyright (c) 2000-2001 Vojtech Pavlik
> > + *
> > + *  Based on the work of:
> > + *	unknown author
> 
> Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>

Added. Now to have it tested :-)

