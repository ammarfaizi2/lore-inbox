Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTH0EVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 00:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbTH0EVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 00:21:03 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12556 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263107AbTH0EU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 00:20:59 -0400
Date: Wed, 27 Aug 2003 06:12:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-ID: <20030827041225.GL734@alpha.home.local>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es> <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian> <20030826234901.1726adec.aradorlinux@yahoo.es> <20030826215544.GI7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826215544.GI7038@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 11:55:44PM +0200, Adrian Bunk wrote:
> > Reasons against:
> > <write here your opinion>
> >...
> 
> - ALSA is big and there are still some bugs in ALSA; there are more
>   urgent things to be fixed in 2.4
> - it's easy to use ALSA even when it's not inside the kernel
> - within a few months 2.6.0 will be released with ALSA included -
>   together with the point above I don't see a reason why ALSA would be
>   badly needed in 2.4

and... if one is clueless enough to be unable to compile ALSA outside the
kernel or to try 2.6, then he's a good candidate for those user-friendly
distros who ship it. Same for i2c.

Not that I wouldn't like to see those included, but there are far more urgent
things as you said, and not everything will get its way to 2.4.23.

Cheers,
Willy

