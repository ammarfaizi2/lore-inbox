Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSK2C0O>; Thu, 28 Nov 2002 21:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSK2C0O>; Thu, 28 Nov 2002 21:26:14 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3076 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S266936AbSK2C0N>;
	Thu, 28 Nov 2002 21:26:13 -0500
Date: Thu, 28 Nov 2002 20:24:33 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Nathan Scott <nathans@sgi.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       Anders Gustafsson <andersg@0x63.nu>, Steve Lord <lord@sgi.com>
Subject: Re: [RELEASE] module-init-tools 0.8
In-Reply-To: <20021129014500.GB546@frodo.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0211282009540.895-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Nathan Scott wrote:

> > Steve?  Changing the prefix on xfs or elf seems equally painful (xfs
> > because it'll be a big patch, elf because it's standardized and been
> > like that forever).
> 
> We changed XFS when this problem first came up.  Linus hasn't yet
> pulled from Christoph's bitkeeper tree though, so we're a bit out
> of sync at the moment.

Sounds like I need to drop back and punt.  I probably need to wait for the 
syncing to happen and bk to be updated.  I need to have 2.4 kernels 
working (specifically RedHat).  I'm doing this testing on my laptop, which 
because I'm going to be moving, will be my only machine for the next month 
or so.  I want to get 2.5 working, but module loading doesn't work and 
modutils-2.4.21-4.i386.rpm and 
modutils-2.4.21-5.i386.rpm break 2.4 kernels.

