Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTLZDMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 22:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLZDMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 22:12:41 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:34794 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264459AbTLZDMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 22:12:40 -0500
Date: Fri, 26 Dec 2003 11:12:55 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up fs/devfs/base.c
In-Reply-To: <20031224103016.37cf5ea3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0312261057100.4600-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003, Andrew Morton wrote:

> 
> Yup, just whitespace fixes please.  I don't think I have the energy for a
> big cleanup exercise right now, and it's not really appropriate.
> 

OK. Got side tracked for a while.

White space only (just about) patch is on kernel.org at:

/pub/linux/kernel/perope/raven/devfs/linux-2.6.0-devfs-1.patch

It compiles, links and basic functionality tested OK with devfsd 
1.3.25, against 2.6.0.

Ian



