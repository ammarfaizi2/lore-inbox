Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSIEJAJ>; Thu, 5 Sep 2002 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSIEJAI>; Thu, 5 Sep 2002 05:00:08 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:23044 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317331AbSIEJAI>; Thu, 5 Sep 2002 05:00:08 -0400
Date: Thu, 5 Sep 2002 11:03:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: DervishD <raul@pleyades.net>
cc: linux-kernel@vger.kernel.org, <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.4
In-Reply-To: <3D771A87.mailIC1BOVTM@pleyades.net>
Message-ID: <Pine.LNX.4.44.0209051054360.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 5 Sep 2002, DervishD wrote:

>     Thanks for taking the effort of making a better building process
> :) I hope you have success ;))

Thanks. :)

>     Well, even though it is a beta release, please make the graphical
> interface optional. I've had to tweak the Makefile since I haven't QT
> on my system (nor G++, BTW).
>
>     I couldn't do 'make install', but I haven't look the Makefile
> (except for removing the QT part), so I don't know why it fails.

What exactly is the problem? If it's correctly installed, the QT
interface is only build when required, e.g. when you type 'make xconfig'.

bye, Roman



