Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTFVHgy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 03:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTFVHgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 03:36:53 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:9347 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263782AbTFVHgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 03:36:52 -0400
Date: Sun, 22 Jun 2003 09:49:55 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Jay Denebeim <denebeim@deepthot.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Redhat 2.4.20 kernel problems
In-Reply-To: <slrnbfakn7.hsl.denebeim@hotblack.deepthot.org>
Message-ID: <Pine.LNX.4.44.0306220944210.1832-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Jay Denebeim wrote:

> In case anyone is still interested, I finally got around to trying a
> kernel.org 2.4.20 version.  No problem.  So it's not in the kernel
> tree.  I compiled it using the /boot/config-2.4.20(whatever) that
> Redhat shipped, so it's not a module/option issue.  The kernel was
> signifigantly smaller than the redhat one as well by several hundred
> K.
> 
> The problem was this, under the redhat kernel shipped on CD for redhat
> 9 and updated for redhat 8 my SO's computer locks up when she moves
> her mouse after booting.  It's a USB mouse.  The system just freezes.
> 
> I haven't seen an Ooops or anything like that.  The syslog is
> forwarded over tcp to my system, so I may see it even with the lock
> up.
> 
> I assume the problem is a lost interrupt or something along that line,
> but this is just a gut feeling.
> 
> How should I contact redhat about this issue?  It's going to be a
> problem upgrading her system if she can't run a stock kernel.  I tried
> writing a friend of mine at Redhat Erik Troan, but his old redhat
> address doesn't work any more.

Have you already updated your system to the latest errata kernel and
packages?

You could try to send an email to a Red Hat mailing list:
http://www.redhat.com/support/forums/

> Jay
 
Have a nice weekend,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
telephone: +31 (0)546-581400     fax: +31 (0)546-581401

