Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUABAKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUABAKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:10:46 -0500
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:33681 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261812AbUABAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:10:38 -0500
Message-Id: <6.0.1.1.2.20040102104731.03fa6600@mail.optusnet.com.au>
X-Nil: 
Date: Fri, 02 Jan 2004 11:08:01 +1100
To: ak@muc.de
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m37k0eyj9z.fsf@averell.firstfloor.org>
References: <179fQ-1iK-11@gated-at.bofh.it>
 <17TiY-4Pm-19@gated-at.bofh.it>
 <182Fy-Lx-15@gated-at.bofh.it>
 <18ajG-4Lz-19@gated-at.bofh.it>
 <18jZB-4VF-19@gated-at.bofh.it>
 <m37k0eyj9z.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:19 PM 30/12/2003, Andi Kleen wrote:
>Leon Toh <tltoh@attglobal.net> writes:
> >
> > I can now officially report that the dpt_i2o driver embedded in kernel
> > 2.6.0 is broken. I'll highlight and bring this up through my contacts
> > back at Adaptec. And hopefully we than can get some kind of official
> > resolution soon.
>
>Also the 2.4 dpt_i2o driver is not 64bit clean and doesn't work e.g.
>on AMD64. So in summary it is always pretty broken in all kernels.

I totally agree with you. However at the time when this driver was written 
it was only intended for Intel i386 base architecture. And furthermore 
AMD64 wasn't even available at that stage.

At this point of time I think fixing this driver for 32bit architecture now 
is far more important than addressing 64bit architecture, don't you agree 
Andi ?

- Leon 

