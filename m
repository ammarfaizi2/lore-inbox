Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSANTQe>; Mon, 14 Jan 2002 14:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANTP0>; Mon, 14 Jan 2002 14:15:26 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:48003 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S288969AbSANTOn>; Mon, 14 Jan 2002 14:14:43 -0500
Date: Mon, 14 Jan 2002 14:14:31 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <E16QCc6-0002bb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201141407450.3238-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Alan ,

On Mon, 14 Jan 2002, Alan Cox wrote:
> > > Urban legend.
> > 	I do not agree .  Got proof ?  Yes that is a valid question .
> Most of the rootkit type stuff I see nowdays includes code for loading
> patches into module free kernels. Its a real no win. The better ones support
> regexp scanning so they can patch kernels where the sysadmin thinks he/she
> is cool and has hidden or crapped in System.map
	Same as I am seeing .  This does not eleviate the fact that
	modules can & are a still a security issue .  Yes , sloppy
	administration is still the biggest culprit in 'most' compromises .

> > > > case becouse the system can't know where the module will be located IIRC)
> > > I defy you to measure it on x86
> > 	OK ,How about sparc-64/alpha/ia64/... ?
> Not generally found in your grandmothers PC
	No,  But it is -mine- !  If I can not have complete control over
	my system due to the way the Fathers of this operating system
	are taking it I will have no choice but to use another or be stuck
	at a non-maintained version .  Now mind you I LIKE LINUX !

> > > > 3. simplicity in building kernels for other machines. with a monolithic
> > > > kernel you have one file to move (and a bootloader to run) with modules
> > > > you have to move quite a few more files.
> > > tar or nfs mount; make modules_install.
> > 	Please my laugh'o meter is stuck already .  Sorry .  JimL
> Then fix it, because the above works well. Also remember that autoconfig
> tools won't be able to guess remote machines very well 8)
	Show me , Please .  I am not convinced .  I shall try out the new
	level of kernel without a doubt .  But ,  I find the concept that
	-everything- is dynamic to be wrong .  Mind you My opinion .
		Twyl ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

