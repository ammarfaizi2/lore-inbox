Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTD3JuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTD3JuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:50:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8466 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262149AbTD3Jt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:49:59 -0400
Date: Wed, 30 Apr 2003 02:57:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hermann Himmelbauer <dusty@violin.dyndns.org>
cc: Nuno Silva <nuno.silva@vgertech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop - Kernel bug?
In-Reply-To: <200304301155.11319.dusty@violin.dyndns.org>
Message-ID: <Pine.LNX.4.10.10304300255510.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Hermann Himmelbauer wrote:

> On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> > Hello!
> >
> > Hermann Himmelbauer wrote:
> > > Well - anyway, the kernel boots but right stops after:
> > > INIT: Entering runlevel:3
> > >
> > > The next line is:
> > > INIT: open(/dev/console): Input/output error
> > > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > > ...
> > >
> > > That's it.
> >
> > Maybe you striped too much and didn't include *any* console type
> > (serial, vga or framebuffer)? :)
> 
> Well - by chance we found another old Laptop, an IBM Thinkpad 350 (the old was 
> model 340) and found a RAM extension, so we have no 36MB RAM.
> 
> But - guess what: The error still persists!
> 
> I am quite clueless - maybe it has something to do with the IDE subsystem? We 
> put a 4GB 2.5'' HD in this old Laptop, but the harddisk is correctly 
> recognized by Linux (also Partition check), grub is also working and it Linux 
> also mounts the partition.

So if it works, why do you claim a bug in the IDE subsystem?
Because  it is an easy target and if all else fails, it is must be IDE ?

Get real -- sigh --


Andre Hedrick
LAD Storage Consulting Group

