Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUGXAzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUGXAzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268211AbUGXAzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:55:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11717 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268210AbUGXAzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:55:50 -0400
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
From: Lee Revell <rlrevell@joe-job.com>
To: Nuno Monteiro <nuno@itsari.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040722184938.GA5232@hobbes.itsari.int>
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org>
	 <40FF4A15.7040100@charter.net>
	 <200407220652.39575.gene.heskett@verizon.net>
	 <200407220849.10594.gene.heskett@verizon.net>
	 <20040722184938.GA5232@hobbes.itsari.int>
Content-Type: text/plain
Message-Id: <1090630549.1471.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 20:55:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 14:49, Nuno Monteiro wrote:
> On 2004.07.22 13:49, Gene Heskett wrote:
> > 
> > 00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
> > Controller (rev a1)
> >         Subsystem: Biostar Microtech Int'l Corp: Unknown device 2301
> 
> > However, this, nor the xconfig helps, still don't indicate which
> > driver I should be using, or where to get it if its not in the
> > kernel's tree yet a/o 2.6.8-rc2.  So thats the next piece of data I
> > need.
> 
> Hi Gene,
> 
> 
> I believe you'll need forcedeth.c for this one. It's called "Reverse  
> Engineered nForce Ethernet support", under Device Driver -> Networking ->  
> Ethernet 10/100 Mbit.

Wow, nVidia won't release the specs for a *10/100 ethernet controller*? 
Having to reverse engineer a network driver is ridiculous in this day
and age.  I can understand binary-only graphics drivers, there is a lot
of valuable IP in there, but this is a freaking network card.  What do
they expect people to do?

Maybe some bad press would set them straight.

Lee

