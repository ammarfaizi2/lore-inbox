Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbTCCHUJ>; Mon, 3 Mar 2003 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268405AbTCCHUJ>; Mon, 3 Mar 2003 02:20:09 -0500
Received: from [196.12.44.6] ([196.12.44.6]:23512 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S268399AbTCCHUJ>;
	Mon, 3 Mar 2003 02:20:09 -0500
Date: Mon, 3 Mar 2003 13:02:09 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
In-Reply-To: <95740000.1046676056@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0303031301200.29035-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



thankx... i got the mistake... instead of giving the argument as 
console=ttyS0, i used console=/dev/ttyS0.... thank you very much

Prasad.

On Sun, 2 Mar 2003, Martin J. Bligh wrote:

> > 	Got a silly doubt. when trying to insert one of my modules into
> > the kernel, its getting rebooted and unfortunately i am losing all the
> > debug(printk) messages.  Can i in some fashion capture all the printk's
> > through the serial port. (I have two linux boxes and a serial cable to
> > connect both of them)
> 
> See Documentation/serial-console.txt
> 
> M.
> 

-- 
Failure is not an option

