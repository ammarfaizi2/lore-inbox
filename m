Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbTCWAvO>; Sat, 22 Mar 2003 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbTCWAvO>; Sat, 22 Mar 2003 19:51:14 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:12811 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262186AbTCWAvN>; Sat, 22 Mar 2003 19:51:13 -0500
Date: Sun, 23 Mar 2003 01:02:15 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65-ac3
In-Reply-To: <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0303230059340.27069-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Once your tty and ide bits are merged, what's left on the plate (in your 
> > opinion) before 2.6.0-test1?
> 
> 32bit dev_t is a showstopper
> 
> then 
> 
> Debugging, debugging, and more debugging
> Driver porting
> Driver resyncs with 2.4
> Finding the remaining scsi bugs
> A ton more IDE work before I am happy
> Fixing the pci api hotplug races
> DRM 4.3 cleaned up and working

The framebuffer code needs alot of work. I have most of it done. I hope 
linus pulls my latest changes soon.







