Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUBDASq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUBDASp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:18:45 -0500
Received: from fmr05.intel.com ([134.134.136.6]:12231 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266234AbUBDASm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:18:42 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Tue, 3 Feb 2004 16:17:36 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3671@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPqpysXUEYJPzr4Sl+f7IRdjOOcDwAC1QUg
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Troy Benjegerdes" <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>
Cc: <infiniband-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2004 00:17:37.0475 (UTC) FILETIME=[4B4B6130:01C3EAB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the community would like to see a 2.6 patch for just the infiniband
access layer
for starters, I don't think it would be to hard to put something
together. 

I heard from a friend of mine that 2.6 was closed to new features. 
What sayith the community on allowing additional experimental drivers
(like the
infiniband access layer) into 2.6 ? Can we still submit something or do
we
have to wait till 2.7 ?

In any case, I am sure we can put together a patch and/or a tarball and
post it
to the sourceforge infiniband web site for those who want to play with
the
infiniband code on 2.6. 

-----Original Message-----
From: Troy Benjegerdes [mailto:hozer@hozed.org] 
Sent: Tuesday, February 03, 2004 2:37 PM
To: Woodruff, Robert J
Cc: infiniband-general@lists.sourceforge.net;
linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


So, for starters, can you or Jerrie post a patch containing just the 2.6
infiniband access layer, Or create a new BK tree for 2.6 infiniband
stuff that uses the new 2.6 kbuild system?




On Mon, Feb 02, 2004 at 03:58:56PM -0800, Woodruff, Robert J wrote:
> 
> We were waiting until we had some version of the InfiniBand code 
> ported to 2.6 before asking for it to be included in the 2.6 kernel 
> tree. Jerrie made the changes
> to the IB access layer to allow it to compile on 2.6, but it cannot
yet
> be tested 
> till we get a 2.6 driver from Mellanox. 
> 
> I'd also like to hear from the linux-kernel folks on what we would 
> need to do to get a basic InfiniBand access layer included in the 2.6 
> base.
> 
> We'd also like to hear from Mellanox if they have any plans to provide

> an open source VPD driver anytime soon.
> 
> woody
> 
