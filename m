Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTAOUhj>; Wed, 15 Jan 2003 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTAOUhj>; Wed, 15 Jan 2003 15:37:39 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:62478 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267057AbTAOUhg>; Wed, 15 Jan 2003 15:37:36 -0500
Message-ID: <3E25B964.80AC569D@linux-m68k.org>
Date: Wed, 15 Jan 2003 20:41:24 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nits on 2.5.58 menuconfig
References: <200301141504.h0EF4O0p003674@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Horst von Brand wrote:

> There is no way to leave a radiolist &c just leaving whatever was set
> alone. An <Exit> option would be nice.

Try <esc><esc>.

> To give help on menuconfig at an entry that leads to a menu ("blabla --->")
> is confusing at best. Add a "<Help on menucofig> button instead?

This is the old behaviour.
Changing lxdialog is very low on my TODO list, patches are welcome
though. :)

bye, Roman

