Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbTCWDMR>; Sat, 22 Mar 2003 22:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbTCWDMR>; Sat, 22 Mar 2003 22:12:17 -0500
Received: from [65.39.167.210] ([65.39.167.210]:12563 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S262239AbTCWDMO>;
	Sat, 22 Mar 2003 22:12:14 -0500
Date: Sat, 22 Mar 2003 22:23:18 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65-ac3
In-Reply-To: <200303230044.h2N0i9r32560@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0303222221400.13256-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How close are IDE and vt switching to working with preempt ?

	Gerhard


On Sat, 22 Mar 2003, Alan Cox wrote:

> Date: Sat, 22 Mar 2003 19:44:09 -0500 (EST)
> From: Alan Cox <alan@redhat.com>
> To: Jeff Garzik <jgarzik@pobox.com>
> Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.5.65-ac3
>
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
>
>
> I think the dev_t one is the only stopper now before we go into
> stop futzing with core code and fix bugs mode
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

