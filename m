Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265859AbSKBCSU>; Fri, 1 Nov 2002 21:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265860AbSKBCSU>; Fri, 1 Nov 2002 21:18:20 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1152 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265859AbSKBCST>;
	Fri, 1 Nov 2002 21:18:19 -0500
Date: Fri, 1 Nov 2002 20:24:43 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
In-Reply-To: <Pine.LNX.4.44.0211011945170.863-100000@dad.molina>
Message-ID: <Pine.LNX.4.44.0211012022190.862-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Thomas Molina wrote:

> On Fri, 1 Nov 2002, Jens Axboe wrote:
> 
> > > hdc: irq timeout: status=0x90 {Busy}
> > > hdc: irq timeout: error=0x01IllegalLengthIndication
> > > hdc: drive not ready for command
> > > hdc: ATAPI reset timed-out, status=0x80
> > > ide1: reset: success
> > 
> > Interesting. Please send me a detailed list of your hardware, boot
> > messages should suffice. Does 2.5.43 work correctly?
> 
> I get the same series of messages when booting 2.5.43.  I'll work my way 
> back to find a version that works and report back when I find it.  
> Following is the config file used to build this kernel:

Well that was quick.  2.5.42 works correctly.  The problems begin with 
2.5.43.

