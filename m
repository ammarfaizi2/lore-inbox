Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131052AbRCGRiS>; Wed, 7 Mar 2001 12:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131127AbRCGRiI>; Wed, 7 Mar 2001 12:38:08 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:42636 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131005AbRCGRh4>; Wed, 7 Mar 2001 12:37:56 -0500
Date: Wed, 7 Mar 2001 01:38:03 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Pavel Machek <pavel@suse.cz>
cc: "[iso-8859-1] Sbastien HINDERER" <jrf3@wanadoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard simulation
Message-ID: <Pine.LNX.4.31.0103070129240.1335-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Take a look at vojtech's new input suite.

Someone else is also working on a brallie reader using the input suite. We
have a new keyboard vt driver that uses the input suite. Event packets
come in and it is sent to the right terminals. I hope to have all the
keyboard drivers converted over by 2.5.0.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

