Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKOVOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKOVOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKOVOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:14:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:60547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750753AbVKOVOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:14:01 -0500
Date: Tue, 15 Nov 2005 12:56:18 -0800
From: Greg KH <gregkh@suse.de>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-ID: <20051115205618.GA11205@suse.de>
References: <20051114220709.GA5234@kroah.com> <20051115201051.GA13473@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115201051.GA13473@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 09:10:51PM +0100, Luca wrote:
> Greg KH <gregkh@suse.de> ha scritto:
> > Intro
> > -----
> [...]
> > Though they
> > are not a good substitute for a solid C education and/or years of
> > experience, the following books are good, if anything for reference:
> > 
> > "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
> > "Practical C Programming" by Steve Oualline [O'Reilly]
> > "Programming the 80386" by Crawford and Gelsinger [Sybek]
> > "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]
> 
> Hi Greg,
> you may want to add:
> 
> "Linux Kernel Development, 2nd ed." by Robert Love [Novell Press]
> and
> "Linux Device Drivers, 3rd ed." by J. Corbet, A. Rubini and G. Kroah-Hartman [O'Reilly]
> 
> IMHO the first one is a must-have for beginners who want to have an
> overall picture of the kernel and LDD is very helpful when you start doing
> some real work :)

Those books are good, but this section is just for where to get the
basics of C and Unix.  The file Documentation/kernel-docs.txt should
have a pointer to these two books, and this HOWTO does point to that
file.

thanks,

greg k-h
