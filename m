Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265464AbSJXOos>; Thu, 24 Oct 2002 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265465AbSJXOos>; Thu, 24 Oct 2002 10:44:48 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:42250 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265464AbSJXOor>; Thu, 24 Oct 2002 10:44:47 -0400
Date: Thu, 24 Oct 2002 16:50:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: small patch, but Linux Kernel Conf in 2.5.44 works great
In-Reply-To: <20021024105440.GA28188@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210241644390.13257-100000@serv>
References: <20021024105440.GA28188@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Oct 2002, bert hubert wrote:

> Slight warning patch, but Linux Kernel Conf is really cool.

Thanks.

> I would indeed however vote to make the xconfig program available separately
> as well. Many users may need a different compiler for xconfig than for the
> kerel (dreaded C++ ABI issues).

It's already almost possible. Only very little is missing to make the X 
interface externally callable (currently it still gets a few variables 
automatically from the Makefile and it has to check itself whether the 
library was built).

bye, Roman

