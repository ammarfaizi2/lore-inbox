Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTG2OJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271816AbTG2OHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:07:32 -0400
Received: from windsormachine.com ([206.48.122.28]:55302 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S271815AbTG2OH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:07:26 -0400
Date: Tue, 29 Jul 2003 10:07:23 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
In-Reply-To: <1059442100.1868.13.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0307291006090.7175@router.windsormachine.com>
References: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com>
 <1059442100.1868.13.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Alan Cox wrote:

> 2.4.20 or later should do it. Red Hat 9 current errata, probably the current errata
> kernels of other vendors too.
>
> hdparm -d /dev/hda will tell you
>

I had thought it was a hard drive as well, since that's what everyone
elses problem with DMA turns out to be.  Turns out it's a piece of
hardware they're working on that has problems.

Unless I misunderstood again :)
Mike
