Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVKPEh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVKPEh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVKPEh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:37:56 -0500
Received: from xenotime.net ([66.160.160.81]:34532 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965242AbVKPEh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:37:56 -0500
Date: Tue, 15 Nov 2005 20:38:15 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <gregkh@suse.de>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-Id: <20051115203815.7c41d106.rdunlap@xenotime.net>
In-Reply-To: <20051115205618.GA11205@suse.de>
References: <20051114220709.GA5234@kroah.com>
	<20051115201051.GA13473@dreamland.darkstar.lan>
	<20051115205618.GA11205@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005 12:56:18 -0800 Greg KH wrote:

> On Tue, Nov 15, 2005 at 09:10:51PM +0100, Luca wrote:
> > Greg KH <gregkh@suse.de> ha scritto:
> > > Intro
> > > -----
> > [...]
> > > Though they
> > > are not a good substitute for a solid C education and/or years of
> > > experience, the following books are good, if anything for reference:
> > > 
> > > "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
> > > "Practical C Programming" by Steve Oualline [O'Reilly]
> > > "Programming the 80386" by Crawford and Gelsinger [Sybek]
> > > "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]
> > 
> > Hi Greg,
> > you may want to add:
> > 
> > "Linux Kernel Development, 2nd ed." by Robert Love [Novell Press]
> > and
> > "Linux Device Drivers, 3rd ed." by J. Corbet, A. Rubini and G. Kroah-Hartman [O'Reilly]
> > 
> > IMHO the first one is a must-have for beginners who want to have an
> > overall picture of the kernel and LDD is very helpful when you start doing
> > some real work :)
> 
> Those books are good, but this section is just for where to get the
> basics of C and Unix.  The file Documentation/kernel-docs.txt should
> have a pointer to these two books, and this HOWTO does point to that
> file.

and as I told Greg a few days ago, there are lots of bad URLs (links)
in that file (and in Documentation/ in general), so feel free to send
corrections for them.  I have some corrections, but not yet in patch
format.

---
~Randy
