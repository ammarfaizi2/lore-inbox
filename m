Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbTEJPgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTEJPgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:36:10 -0400
Received: from pop.gmx.de ([213.165.65.60]:60707 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264402AbTEJPgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:36:09 -0400
Date: Sat, 10 May 2003 17:46:31 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Ahmed Masud <masud@googgun.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <Pine.LNX.4.33.0305101138110.24188-100000@marauder.googgun.com>
References: <S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
	<Pine.LNX.4.33.0305101138110.24188-100000@marauder.googgun.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264402AbTEJPgJ/20030510153609Z+7028@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 11:39:12 -0400 (EDT)
Ahmed Masud <masud@googgun.com> wrote:

> 
> 
> On Sat, 10 May 2003, Tuncer M zayamut Ayaz wrote:
> 
> > On Sat, 10 May 2003 17:07:51 +0200
> > Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de> wrote:
> >
> > > On 10 May 2003 14:59:31 +0100
> > > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > >
> > > > On Sad, 2003-05-10 at 14:57, Tuncer M zayamut Ayaz wrote:
> > > > > description of the strange sound:
> > > > >   - high tone
> > > > >   - permanent
> > > > >   - happens before loading ALSA modules
> 
> Is this high tone comming out of external speakers or is it from
> internal speaker?

definitely not external speaker.
can't say whether there is an internal speaker it could come
from. source of sound is right beneath the keyboard,
and creating load aka moving an x11 window around produces
funny patterns --> no high tone, it almost disappears,
but just low-volume sound reacting to when I move the
window around.
for a non-hardware-expert this is strange stuff.
