Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRCaDt4>; Fri, 30 Mar 2001 22:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132185AbRCaDtq>; Fri, 30 Mar 2001 22:49:46 -0500
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:63743 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132167AbRCaDtf>; Fri, 30 Mar 2001 22:49:35 -0500
Date: Fri, 30 Mar 2001 19:49:44 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0103301947330.743-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I had patch which tried that at one point. Just try all 2^n numbers
><= size until it succeeds.

Hum. Is this the only way we can solve this problem? I assume you end of
with most of but not all the video memory using MTRR then. Kind of sucks!!

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

