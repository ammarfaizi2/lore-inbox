Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319375AbSIFUZq>; Fri, 6 Sep 2002 16:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319376AbSIFUZq>; Fri, 6 Sep 2002 16:25:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:8182 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319375AbSIFUZp>; Fri, 6 Sep 2002 16:25:45 -0400
Subject: Re: ide drive dying?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031333604.11356.7.camel@sonja.de.interearth.com>
References: <200209061713.51387.devilkin-lkml@blindguardian.org> 
	<1031326689.9861.45.camel@irongate.swansea.linux.org.uk> 
	<1031333604.11356.7.camel@sonja.de.interearth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 21:31:25 +0100
Message-Id: <1031344285.9861.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 18:33, Daniel Egger wrote:
> Am Fre, 2002-09-06 um 17.38 schrieb Alan Cox:
> 
> > Get the IBM disk tools, upgrade the firmware and see what the ibm tools
> > have to say. IBM drives have had some problems with spontaneous bad
> > blocks appearing that go away with new firmware and a run of the disk
> > tools.
> 
> The "run of the disk tools" that does away with the badblocks is a
> lowlevel format; a tedious way to spent ones' time on a harddrive
> that will die anyway soon.

For the IBM's it depends what the problem is. Spontaneous bad blocks
appearing during power off appears to be fixed by the firmware update
