Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKYAOh>; Sun, 24 Nov 2002 19:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSKYAOh>; Sun, 24 Nov 2002 19:14:37 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29581 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261934AbSKYAOg>; Sun, 24 Nov 2002 19:14:36 -0500
Subject: Re: Tridentfb updates?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Josh Myer <jbm@joshisanerd.com>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211221146240.30881-100000@blessed.joshisanerd.com>
References: <Pine.LNX.4.44.0211221146240.30881-100000@blessed.joshisanerd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Nov 2002 00:51:58 +0000
Message-Id: <1038185518.28491.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 17:49, Josh Myer wrote:
> Hi,
> 
> I've got an EPIA board, with a trident CyberBlade chipset. Does anyone
> have doco on this chipset? The random Xfree stuff available from VIA is
> less-than-enlightening (I'm not familiar with X internals).
> 
> I'm basically just interested in getting FB working for NTSC output.

The chipset docs are freely downloadable from VIA (including the 3d
info). The TV on the epia is a seperate chip. I use the vesa mode switch
to program that

