Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269649AbRHGXBT>; Tue, 7 Aug 2001 19:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHGXBJ>; Tue, 7 Aug 2001 19:01:09 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:48116 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S269649AbRHGXBC>;
	Tue, 7 Aug 2001 19:01:02 -0400
Date: Tue, 7 Aug 2001 19:02:21 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Ben Greear <greearb@candelatech.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Problem with Linux 2.4.7 and builtin eepro on
 Intel'sEEA2  motherboard.
In-Reply-To: <3B7069ED.E4F77B68@candelatech.com>
Message-ID: <Pine.LNX.4.10.10108071900340.976-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Ben Greear wrote:
> Donald Becker wrote:
> > On Tue, 7 Aug 2001, Ben Greear wrote:
> > 
> > > Subject: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel's
> >     EEA2 motherboard.
> > >
> > > The driver seems to lock up for a while and then recover...
> > 
> > Presumably this is the driver in the 2.4.7 kernel, not the Scyld driver.
> 
> Yes, I'm under the impression that the Scyld driver for 2.4.7 is not
> prime-time yet.  I wouldn't mind being wrong!

We don't validate on the 2.4 kernels, but the drivers should all
nominally work with 2.4.  It will at least provide a useful reference
point.

The current public version of eepro100.c is v1.17.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

