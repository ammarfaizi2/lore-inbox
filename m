Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132059AbRCVPmK>; Thu, 22 Mar 2001 10:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132060AbRCVPmA>; Thu, 22 Mar 2001 10:42:00 -0500
Received: from snipe.prod.itd.earthlink.net ([207.217.120.62]:38852 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132059AbRCVPlq>; Thu, 22 Mar 2001 10:41:46 -0500
Date: Wed, 21 Mar 2001 23:41:50 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: standard_io_resources[]
Message-ID: <Pine.LNX.4.31.0103212341100.669-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If you write into those resources and they are absent, bad things
>sometimes happen.  So, they are always added to the reserved-resource
>list.  I already had this argument with Linus :)

Oops. Got that wrong. Time to fix CVS.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

