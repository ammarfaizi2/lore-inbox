Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSKBXUg>; Sat, 2 Nov 2002 18:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbSKBXUg>; Sat, 2 Nov 2002 18:20:36 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:2061 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261493AbSKBXUg> convert rfc822-to-8bit; Sat, 2 Nov 2002 18:20:36 -0500
Date: Sun, 3 Nov 2002 00:27:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Kernel GUI config
In-Reply-To: <20021102231435.GA2384@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0211030020260.13258-100000@serv>
References: <20021102231435.GA2384@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, J.A. Magallón wrote:

> To reduce implementation efforts (and bug chasing), as someone said, you
> can take all the current parts toolkit-independent (parsers, etc.) from
> qconf and split them in a library.

$ ll scripts/kconfig/libkconfig.so 
-rwxr-xr-x    1 roman    users       76335 Oct 31 22:36 scripts/kconfig/libkconfig.so

It's already done.

bye, Roman

