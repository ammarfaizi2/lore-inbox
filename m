Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSGWBVF>; Mon, 22 Jul 2002 21:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSGWBVF>; Mon, 22 Jul 2002 21:21:05 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:28669 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317365AbSGWBVF>; Mon, 22 Jul 2002 21:21:05 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27 IDE: problems, again.
Date: Tue, 23 Jul 2002 11:19:59 +1000
User-Agent: KMail/1.4.5
References: <20020722144557.GJ26837@tahoe.alcove-fr>
In-Reply-To: <20020722144557.GJ26837@tahoe.alcove-fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207231120.00126.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 00:45, Stelian Pop wrote:
> Disabling PIIX chipset support & dma makes the kernel survive for
> some longer time (between 10 seconds and 2-3 minutes), but it will
> eventually halt, this time CORRUPTING THE DATA!
See Bart's comments in separate post.

> Right now I'm trying to recover my disk partition...

You are *out of your fscking mind*.

Why are you running 2.5 on a machine that has anything worth
recovering on it? IDE or SCSI, no matter.

Standard 2.5 equipment includes a CD drive with the install disk(s)
for $DISTRO ready to drop into the drive as soon as anything looks
bad. Advanced 2.5 requires a duplicate hard disk on a removable drive
caddy :)

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
