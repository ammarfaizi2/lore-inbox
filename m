Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264674AbSJ3OHJ>; Wed, 30 Oct 2002 09:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264675AbSJ3OHJ>; Wed, 30 Oct 2002 09:07:09 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:32386 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264674AbSJ3OHI>; Wed, 30 Oct 2002 09:07:08 -0500
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
	candidate list.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dcinege@psychosis.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiser@namesys.com, davem@redhat.com, boissiere@adiglobal.com
In-Reply-To: <200210300322.17933.dcinege@psychosis.com>
References: <200210272017.56147.landley@trommello.org>
	<200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> 
	<200210300322.17933.dcinege@psychosis.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 14:32:34 +0000
Message-Id: <1035988354.5140.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 08:22, Dave Cinege wrote:
> > untar - cpio is better.
> 
> CPIO is commonly used and supported by NO ONE. (rpm, whoppee)
> Kernels even come tar'ed. KISS....

I'm sorry but if you can't work cpio you probably shouldnt be hacking
kernels anyway. If you can work it and have to deal with cow-orkers who
can't then write them a nice drag and drop cpio builder.

> Great...you just killed the high level embedded linux market, and
> the ability to play boot games from GRUB. (Network, etc)
> Initrd is a good **OPTION* to have to fall back on...

They all work with initramfs


> Do you have any serious sysadmin, clustering, or emebedded system
> IMPLEMENTATION experience? 

I do and I don't see the problem. The one reason you want to keep initrd
around is ROM and there are better ways of doing "initromfs"


