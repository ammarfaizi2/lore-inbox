Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTEZTDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTEZTDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:03:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50651 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262139AbTEZTDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:03:04 -0400
Date: Mon, 26 May 2003 16:14:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to add SysRq handling to 3270 console
In-Reply-To: <Pine.LNX.4.55L.0305261546570.21011@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.55L.0305261614020.21463@freak.distro.conectiva>
References: <OF52A877A4.CB4F43A8-ONC1256D2F.00336EBB@de.ibm.com>
 <20030523103740.A15552@infradead.org> <Pine.LNX.4.55L.0305261546570.21011@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 May 2003, Marcelo Tosatti wrote:

>
>
> On Fri, 23 May 2003, Christoph Hellwig wrote:
>
> > On Fri, May 23, 2003 at 11:30:38AM +0200, Martin Schwidefsky wrote:
> > > code drop contains the changes & new features for the new machine. The
> > > IBM process forces us to publish the new features patches on developer
> > > works first before we can think about integration into the mainline.
> > > You may not like it but this is a restriction we as the s390 team at
> > > IBM have to live with.
> >
> > *sigh*  what about at least posting patches vs a current kernel? :)
> >
> > > > Btw, what's the state of 2.4.21-rc3 vs s390(x)?
> > > No too good. It basically works but there is a big bunch of patches
> > > missing. I sent them to Marcelo for integration a few weeks ago but
> > > to me Marcelo is a black hole.
>
> :/
>
> > Never heard anything about it, not
> > > even a "no". I sent Alan a copy of the patches adapted to his -ac
> > > tree. He accepted most of it into rc2-ac2.
> >
> > Marcelo, what's the state of the s390 updates?
>
> I considered the updates to be too late for 2.4.21.

Too late and TOOO big.

> 2.4.21 should be out soon, -rc4 is going out today and -rc5 is only going
> to happen if something REALLY bad happens.

