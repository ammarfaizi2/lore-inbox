Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288862AbSANTCw>; Mon, 14 Jan 2002 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288922AbSANTBq>; Mon, 14 Jan 2002 14:01:46 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:44419 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S288862AbSANTAN>; Mon, 14 Jan 2002 14:00:13 -0500
Date: Mon, 14 Jan 2002 14:00:01 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <E16QCPK-0002Yt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201141358060.3238-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Alan ,

On Mon, 14 Jan 2002, Alan Cox wrote:
> > 1. security, if you don't need any modules you can disable modules entirly
> > and then it's impossible to add a module without patching the kernel first
> > (the module load system calls aren't there)
>
> Urban legend.
	I do not agree .  Got proof ?  Yes that is a valid question .

> > 2. speed, there was a discussion a few weeks ago pointing out that there
> > is some overhead for useing modules (far calls need to be used just in
> > case becouse the system can't know where the module will be located IIRC)
> I defy you to measure it on x86
	OK ,How about sparc-64/alpha/ia64/... ?

> > 3. simplicity in building kernels for other machines. with a monolithic
> > kernel you have one file to move (and a bootloader to run) with modules
> > you have to move quite a few more files.
> tar or nfs mount; make modules_install.
	Please my laugh'o meter is stuck already .  Sorry .  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

