Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266496AbSKGLny>; Thu, 7 Nov 2002 06:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266497AbSKGLny>; Thu, 7 Nov 2002 06:43:54 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:62360 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266496AbSKGLny>; Thu, 7 Nov 2002 06:43:54 -0500
Date: Thu, 7 Nov 2002 05:47:47 -0600
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107114747.GM4182@cadcamlab.org>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071149200.13258-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > Basically, what I'm saying is, I see no need for the existing .so in
> > the kernel build, much less another one.  Static libraries are ever so
> > much easier to manage.

[Roman Zippel]
> If you want to limit people to the config tools in the kernel, there
> is indeed no need for a shared library. Note that during the next
> development cycle all graphical front ends are possibly removed.

Huh?  I don't get it.  How is a shared library any better than a static
library in this regard?  I'm pondering the traditional advantages of
shared libraries, and I cannot think of a single one that matters here.

Peter
