Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRCVPlU>; Thu, 22 Mar 2001 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132059AbRCVPlK>; Thu, 22 Mar 2001 10:41:10 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:973 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132057AbRCVPk5>; Thu, 22 Mar 2001 10:40:57 -0500
Date: Wed, 21 Mar 2001 23:40:36 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Tomasz Sterna <smoku@jaszczur.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: standard_io_resources[]
Message-ID: <Pine.LNX.4.31.0103212336270.669-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I still can't see a reason for allocating it before the device drivers
>could do that.

See Jeff's response. We got it wrong as well :-( Time to fix that.

>What is the "input api"? Could You give me any URL to read?

http://www.suse.cz/development/inputhttp://www.suse.cz/development/

And http://linuxconsole.sourceforge.net which is a project that takes
advantage of using the input layer for the console system and a massive
cleanup of the fbdev layer.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

