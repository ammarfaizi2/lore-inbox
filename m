Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWJDNCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWJDNCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWJDNCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:02:04 -0400
Received: from mail0.lsil.com ([147.145.40.20]:42157 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932409AbWJDNCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:02:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problem with legacy megaraid
Date: Wed, 4 Oct 2006 07:01:55 -0600
Message-ID: <9738BCBE884FDB42801FAD8A7769C265F8A982@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with legacy megaraid
Thread-Index: AcblH0H1o/3Jk+L5TPSSVpEakJV4UwABL70gAJ6ay2AABa5JIA==
From: "Kolli, Neela" <Neela.Kolli@lsil.com>
To: "Chris Lee" <labmonkey42@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2006 13:01:56.0093 (UTC) FILETIME=[4517EAD0:01C6E7B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
This being a "Dell controller", Dell customer service would be the
starting point to handle this.

Thanks,
Neela Syam Kolli.


-----Original Message-----
From: Chris Lee [mailto:labmonkey42@gmail.com] 
Sent: Wednesday, October 04, 2006 6:22 AM
To: linux-kernel@vger.kernel.org
Cc: 'Andrew Morton'; Ju, Seokmann; linux-scsi@vger.kernel.org; Kolli,
Neela
Subject: RE: Problem with legacy megaraid

> > > > 
> > > > > Distro: Gentoo Linux
> > > > > Kernel: 2.6.17-gentoo-r7
> > > > > 
> > > > > Hardware:
> > > > > Motherboard: Tyan Thunder i7501 Pro (S2721-533)
> > > > > CPUs: Dual 2.8Ghz P4 HT Xeons
> > > > > RAM: 4GB registered (3/1 split, flat model)
> > > > > RAID: Dell PERC2/DC (AMI Megaraid 467)
> > > > > SCSI: Adaptec AHA-2940U2/U2W PCI
> > > > > NICs: onboard e100 and dual onboard e1000
> > > > > 
> > 
> > Did it work correctly under any earlier kernel version?  If 
> > so, which?
> 
> I've recently built the system and the problem was present 
> with both 2.6.16-gentoo-r4 and now 2.6.17-gentoo-r7.  I've 
> not used any earlier kernel versions in this system.

To update... I've rolled back to 2.6.{12,11,9} and can still reproduce
the
problem on all of them.  I'm out of ideas as to where I can look for the
cause.  If anyone (LSI, Dell people maybe?) has any ideas please let me
know.

Thanks,
Chris  

