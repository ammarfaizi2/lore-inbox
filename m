Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHMKsa>; Tue, 13 Aug 2002 06:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHMKsa>; Tue, 13 Aug 2002 06:48:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57591 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314680AbSHMKsa>; Tue, 13 Aug 2002 06:48:30 -0400
Subject: Re: Linux 2.4.20-pre2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Greg Kroah-Hartman <greg@kroah.com>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0208131116270.14606-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0208131116270.14606-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 11:49:42 +0100
Message-Id: <1029235782.21007.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 10:19, Adrian Bunk wrote:
> On Mon, 12 Aug 2002, Marcelo Tosatti wrote:
> 
> >...
> > Greg Kroah-Hartman <greg@kroah.com>:
> >...
> >   o USB: removed the devrequest typedef
> >...
> 
> This broke the compilation of drivers/isdn/hisax/st5481_usb.c:

Fixes can be found for this and a couple of other usb breakages in the
2.4.20-pre1-ac tree. I'll send them on to Marcelo today

