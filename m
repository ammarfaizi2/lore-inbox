Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268281AbTBMTcy>; Thu, 13 Feb 2003 14:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268280AbTBMTcy>; Thu, 13 Feb 2003 14:32:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27523
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268281AbTBMTcx>; Thu, 13 Feb 2003 14:32:53 -0500
Subject: Re: Kill "testing by UNISYS" message
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030213103721.GE14151@atrey.karlin.mff.cuni.cz>
References: <20030210171336.GA10875@elf.ucw.cz>
	 <1044969854.12906.18.camel@irongate.swansea.linux.org.uk>
	 <20030213103721.GE14151@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045168991.6493.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Feb 2003 20:43:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 10:37, Pavel Machek wrote:
> Hi!
> 
> 
> > > -	printk(KERN_INFO "Linux NET4.0 for Linux 2.4\n");
> > > -	printk(KERN_INFO "Based upon Swansea University Computer Society NET3.039\n");
> > > -
> > 
> > No problem with that but please ensure the Swansea University Computer Society part is
> > already in, or ends up in the top of file comments so the copyright info is preserved.
> 
> Updated patch follows... hope it is okay this way.

Certainly fine by me

