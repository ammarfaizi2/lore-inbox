Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312854AbSCVVgK>; Fri, 22 Mar 2002 16:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312851AbSCVVft>; Fri, 22 Mar 2002 16:35:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43015 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312850AbSCVVfp>; Fri, 22 Mar 2002 16:35:45 -0500
Date: Fri, 22 Mar 2002 17:30:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: pdcadma.c still missing ?
In-Reply-To: <E16nq6C-0003m2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0203221730080.10905-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Mar 2002, Alan Cox wrote:

> > > So here goes pre4, now with a much more detailed changelog...
> > 
> > Or maybe the makefile should not include it?
> > 
> > ld: cannot open pdcadma.o: No such file or directory
> > make[3]: *** [ide-mod.o] Error 1
> > make[3]: Leaving directory
> 
> It should be comemnted out in the Config.in file for that directory. I
> sent that diff, must have escaped the merge. Grab it from -ac

Got it... 

