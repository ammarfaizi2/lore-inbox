Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTF1Ovo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTF1Ovo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:51:44 -0400
Received: from www.wireboard.com ([216.151.155.101]:34212 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S265239AbTF1Ovo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:51:44 -0400
To: Joshua Penix <jpenix@binarytribe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell vs. GPL
References: <Pine.LNX.4.44.0306280005000.29249-100000@gibson.mw.luc.edu>
	<1056780761.10255.10.camel@granite>
From: Doug McNaught <doug@mcnaught.org>
Date: 28 Jun 2003 11:05:59 -0400
In-Reply-To: Joshua Penix's message of "27 Jun 2003 23:12:41 -0700"
Message-ID: <m3n0g21bu0.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Penix <jpenix@binarytribe.com> writes:

> On Fri, 2003-06-27 at 22:51, Fluke wrote:
> >   Dell is providing binary only derived works of the Linux kernel and the 
> > modutils package at ftp://ftp.dell.com/fixes/boot-floppy-rh9.tar.gz
> > 
> >   The GPL appears to provide four terms under section 3 that Dell may 
> > legally redistribute these works:
> > 
> > - In regards to GPL 3a, Dell does *NOT* provide the source code as part of 
> > the tar.gz
> 
> Stop right there.  Yes they do.  Mount those images and you'll find boot
> disks identical to the RedHat-provided ones, except that the vmlinuz
> kernel image is different.  The difference is produced by applying the
> 'serverworks.patch' file that is ALSO included right along with the disk
> images.

AIUI, they need to supply full source, not just a patch against code
you get from someone else.

-Doug
