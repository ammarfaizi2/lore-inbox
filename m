Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSJ2WJ7>; Tue, 29 Oct 2002 17:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJ2WJ7>; Tue, 29 Oct 2002 17:09:59 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:33226 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262387AbSJ2WJ6>; Tue, 29 Oct 2002 17:09:58 -0500
Date: Tue, 29 Oct 2002 15:09:33 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [BK fbdev changes]
Message-ID: <Pine.LNX.4.33.0210291507240.2255-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay until the issue of AGP handling is solved I moved the drm and agp
code back into drivers/char. Just teh fbdev changes are in drivers/video.
Can you pull them. Thank you.

bk://fbdev.bkbits.net/fbdev-2.5

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

