Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318129AbSHDIVH>; Sun, 4 Aug 2002 04:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318130AbSHDIVH>; Sun, 4 Aug 2002 04:21:07 -0400
Received: from co239024-a.almel1.ov.nl.home.com ([217.120.226.100]:28289 "EHLO
	quinten.nl") by vger.kernel.org with ESMTP id <S318129AbSHDIVG>;
	Sun, 4 Aug 2002 04:21:06 -0400
Date: Sun, 4 Aug 2002 09:59:24 +0200 (CEST)
From: Aschwin Marsman - aYniK Software Solutions <a.marsman@aYniK.com>
X-X-Sender: marsman@quinten.nl
To: Christian Neumair <christian-neumair@web.de>
cc: Hell.Surfers@cwctv.net, <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: RE:2.4.19 warnings with allnoconfig
In-Reply-To: <1028447908.4339.3.camel@kellerbar.lan.net>
Message-ID: <Pine.LNX.4.44.0208040954350.2084-100000@quinten.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Aug 2002, Christian Neumair wrote:

> > 2.4.19 with make allnoconfig produces these warnings.
> 
> Just a hint:
> There is almost no software with completely clean code.

I can't agree. What you can say is that if you enable warnings
from the beginning, it's much easier because you prevent those
warnings, if you get them a couple of times. 

If you upgrade your compiler, it can issue new warnings,
like you see when using gcc 3.x, or e.g. when changing from 2.8.x to
2.95.x.

> Whenever you see one compiling and it produces no warnings it's most
> likely that the build script just suppresses warnings.

It can also mean that a software engineer has done a good job ;-)
Always look for -Wall as a start when using the gcc compiler.

> see you,
>  Chris
 
Best regards,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
Bedrijvenpark Twente 305         NL-7602 KL Almelo - the Netherlands
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
telephone: +31 (0)546-581400     fax: +31 (0)546-581401
a.marsman@aYniK.com              http://www.aYniK.com

