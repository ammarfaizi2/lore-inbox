Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSKCUWC>; Sun, 3 Nov 2002 15:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSKCUWC>; Sun, 3 Nov 2002 15:22:02 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:9481 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263438AbSKCUU6>; Sun, 3 Nov 2002 15:20:58 -0500
Date: Sun, 3 Nov 2002 21:27:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org, <mec@shout.net>
Subject: Re: [kconfig] Survival of scripts/Menuconfig?
In-Reply-To: <20021103194647.GD2516@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0211032111480.6949-100000@serv>
References: <20021103111333.GA2516@pasky.ji.cz> <Pine.LNX.4.44.0211031803380.6949-100000@serv>
 <20021103194647.GD2516@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Petr Baudis wrote:

> Well, I think that it's not so good idea to have menuconfig distributed
> separately, since it is probably the best thing you can get out of the text
> mode, and there're really not much alternatives you could dream out. Having the
> make config as the only way to configure the kernel is not a good thing, IMHO.

We already have a working menuconfig, which is distributed with the
kernel. Integrating mconf.c and lxdialog is a good idea though, as it 
would give us the chance to fix some problems in the user interface.

bye, Roman

