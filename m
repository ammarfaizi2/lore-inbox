Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVGMKpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVGMKpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGMKpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:45:40 -0400
Received: from mx2.go2.pl ([193.17.41.42]:60345 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S262635AbVGMKoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:44:19 -0400
From: Jacek =?iso-8859-2?q?Jab=B3o=F1ski?= <vacant2005@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: system.map
Date: Wed, 13 Jul 2005 12:45:02 +0200
User-Agent: KMail/1.7.2
References: <200507121834.50084.vacant2005@o2.pl> <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr> <200507131244.08336.vacant2005@o2.pl>
In-Reply-To: <200507131244.08336.vacant2005@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507131245.03220.vacant2005@o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia ¶roda, 13 lipca 2005 12:44, napisa³e¶:
> In standard distribution kernel (2.4), it loaded some symblos:
> Inspecting /boot/System.map-2.4.27-2-k7
> Jul  6 09:32:37 localhost kernel: Loaded 17895 symbols
> from /boot/System.map-2.4
> .27-2-k7.
> Jul  6 09:32:37 localhost kernel: Symbols match kernel version 2.4.27.
> Jul  6 09:32:37 localhost kernel: Loaded 618 symbols from 21 modules.
>
> Maybe the link will help:
> http://www.linuxsa.org.au/pipermail/linuxsa/2003-December/063669.html
>
> > >After compiling new kernel, it doesn`t load System.map file. In kernel
> > >messages I can find:
> > >
> > >Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
> > >Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from
> > > /boot/System.map. Jul 11 12:18:48 localhost kernel: Symbols match
> > > kernel version 2.6.12. Jul 11 12:18:48 localhost kernel: No module
> > > symbols loaded - kernel modules notenabled.
> >
> > I get the same, but somehow, my symbols are loaded. (When it oopses,
> > derefs a NULL pointer, etc. for example.)
> >
> > (My syms file is at /boot/System.map-`uname -r` and "works" equally well
> > to yours.)
> >
> >
> > Jan Engelhardt
