Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSLJRXl>; Tue, 10 Dec 2002 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSLJRXl>; Tue, 10 Dec 2002 12:23:41 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:53999 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262130AbSLJRXk>; Tue, 10 Dec 2002 12:23:40 -0500
Date: Tue, 10 Dec 2002 10:24:17 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: CaT <cat@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51 (fbcon issues)
In-Reply-To: <20021210062258.GA667@zip.com.au>
Message-ID: <Pine.LNX.4.33.0212101017150.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I removed both and it works fine. thanks. :)

Yeah!!!

> It also seems a lot faster then the 2.4.x version which is way-cool. :)

I know :-) With the help of Antonino Daplas we really go fast code. The
benchmarks show a 2.5.x to 3x improvement over fbcon-cfb*!!! The accelerated
drivers blows the benchmarks away!!!!

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


