Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTEJPyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTEJPyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:54:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:5157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264412AbTEJPxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:53:52 -0400
Date: Sat, 10 May 2003 18:04:12 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Ahmed Masud <masud@googgun.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <Pine.LNX.4.33.0305101150420.24272-100000@marauder.googgun.com>
References: <20030510154639.02DDC32C9@marauder.googgun.com>
	<Pine.LNX.4.33.0305101150420.24272-100000@marauder.googgun.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264412AbTEJPxw/20030510155353Z+7031@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 11:52:39 -0400 (EDT)
Ahmed Masud <masud@googgun.com> wrote:

> 
> 
> On Sat, 10 May 2003, Tuncer M zayamut Ayaz wrote:
> 
> > On Sat, 10 May 2003 11:39:12 -0400 (EDT)
> > Ahmed Masud <masud@googgun.com> wrote:
> >
> > can't say whether there is an internal speaker it could come
> > from. source of sound is right beneath the keyboard,
> > and creating load aka moving an x11 window around produces
> > funny patterns --> no high tone, it almost disappears,
> > but just low-volume sound reacting to when I move the
> > window around.
> > for a non-hardware-expert this is strange stuff.
> >
> 
> I think your keyboard may have a stuck key *grin*.
> 
> Suggest the following:
> 
> 1. remove keyboard from computer, to see if that stops the sound.
> 2. remove mouse from computer to see if that stops the sound. (ps/2
> mice can be silly)
> 
> if neither then we can say you have an odd bug.

dunno how to remove builtin keyboard but plugging out externel ps/2
mouse doesn't change a thing. but pluggin it in again makes the
sound stop for .5sec and start again after that period.
