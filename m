Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSKOP7l>; Fri, 15 Nov 2002 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSKOP7l>; Fri, 15 Nov 2002 10:59:41 -0500
Received: from wv-morgantown1-235.mgtnwv.adelphia.net ([24.50.80.235]:42236
	"EHLO silvercoin") by vger.kernel.org with ESMTP id <S266406AbSKOP7k>;
	Fri, 15 Nov 2002 10:59:40 -0500
Subject: Re: 2.4.20-rc1-ac3 compile warnings/errors (test)
From: Scott Henson <debian-list@silvercoin.dyndns.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200211151323.gAFDNlt01818@devserv.devel.redhat.com>
References: <200211151323.gAFDNlt01818@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037376386.10101.22.camel@GreyGhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 15 Nov 2002 11:06:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 08:23, Alan Cox wrote:
<snip>
> >   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
> > In file included from rmap.c:31:
> > /usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:17:1: warning: 
> > "kernel_locked" redefined
> 
> Weird indeed. are you trying to build SMP or non SMP ?
I got this error building non SMP.

-- 
Scott Henson <debian-list@silvercoin.dyndns.org>

