Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSIJWxv>; Tue, 10 Sep 2002 18:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSIJWxv>; Tue, 10 Sep 2002 18:53:51 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:59637
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318203AbSIJWxv>; Tue, 10 Sep 2002 18:53:51 -0400
Subject: Re: Linux 2.4.20-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0209102322290.18902-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0209102322290.18902-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 00:01:49 +0100
Message-Id: <1031698909.2768.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 23:40, Adrian Bunk wrote:
> On Tue, 10 Sep 2002, Marcelo Tosatti wrote:
> 
> >...
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >...
> >   o more irda __FUNCTION__ stuff
> >...
> 
> This adds the use of TIOCM_MODEM_BITS to irtty.c but not the corresponding
> addition of it to asm-i386/termios.h:

Oops I'll send Marcelo a fix for that as wella s the 845G printk

