Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUGVSwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUGVSwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUGVSve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:51:34 -0400
Received: from [213.13.117.218] ([213.13.117.218]:48768 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S266894AbUGVSv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:51:28 -0400
Date: Thu, 22 Jul 2004 19:49:38 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
Message-ID: <20040722184938.GA5232@hobbes.itsari.int>
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org> <40FF4A15.7040100@charter.net> <200407220652.39575.gene.heskett@verizon.net> <200407220849.10594.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200407220849.10594.gene.heskett@verizon.net> (from gene.heskett@verizon.net on Thu, Jul 22, 2004 at 13:49:10 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.07.22 13:49, Gene Heskett wrote:
> 
> 00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
> Controller (rev a1)
>         Subsystem: Biostar Microtech Int'l Corp: Unknown device 2301

> However, this, nor the xconfig helps, still don't indicate which
> driver I should be using, or where to get it if its not in the
> kernel's tree yet a/o 2.6.8-rc2.  So thats the next piece of data I
> need.

Hi Gene,


I believe you'll need forcedeth.c for this one. It's called "Reverse  
Engineered nForce Ethernet support", under Device Driver -> Networking ->  
Ethernet 10/100 Mbit.


Cheers,


		Nuno
