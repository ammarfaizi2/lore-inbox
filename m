Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTIHQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTIHQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:09:59 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:12163 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262690AbTIHQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:09:56 -0400
Subject: Re: Hardware supported by the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: DervishD <raul@pleyades.net>
Cc: Dave Jones <davej@redhat.com>, Ch & Ph Drapela <pcdrap@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908145617.GF11936@DervishD>
References: <3F59DF81.8000407@bluewin.ch> <20030906134029.GE69@DervishD>
	 <20030907223258.GE28927@redhat.com> <20030908092952.GA51@DervishD>
	 <20030908095357.GD10358@redhat.com>
	 <1063026380.21084.24.camel@dhcp23.swansea.linux.org.uk>
	 <20030908145617.GF11936@DervishD>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063033858.21084.51.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 16:10:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 15:56, DervishD wrote:
>  * Alan Cox <alan@lxorguk.ukuu.org.uk> dixit:
> > > who did I miss ?
> > Trident - documentation is public, nobody has tackled a driver
> 
>     Trident cards are still sold? Here in Spain is difficult to get
> one (except a second-hand maybe).

Trident appears in the EPIA (but not EPIA-M) onboard video for one. So
its still around as an embedded item.

> > Intel - older stuff is slow, newer onboard video is actually pretty good
> > and Intel support this stuff seriously. Its not a radeon but it players
> > cube perfectly well 8) Presumably intel will eventually fuse the CPU and
> > graphics into one chip.
> 
>     I tested the 810 a time ago. It was not slow (2D at least, didn't
> check 3D), but it was buggy (even in Windows, so Linux drivers
> weren't blame of this).

With XFree 4.3 810 seems pretty solid 2D/3D nowdays, and the later stuff
830/845/... is also a fair bit faster.

