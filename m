Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUA3RHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUA3RHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:07:06 -0500
Received: from fmr05.intel.com ([134.134.136.6]:4753 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262040AbUA3RHA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:07:00 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Date: Fri, 30 Jan 2004 08:58:39 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173B135C2@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Thread-Index: AcPnTsQbkrKFq65zQwiFiuRmES8zBQAA1xdg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Greg KH" <greg@kroah.com>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: "Matthew Wilcox" <willy@debian.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 30 Jan 2004 16:58:40.0647 (UTC) FILETIME=[4FAB5970:01C3E752]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, can someone from Intel test out Matthew's patch to make sure it
> works properly for them on their hardware?  It's much cleaner than the
> last patch submitted by you all :)

Okay I'll make sure it happens.

Jun

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Friday, January 30, 2004 8:33 AM
> To: Durairaj, Sundarapandian; Kondratiev, Vladimir; Seshadri,
> Harinarayanan; Nakajima, Jun
> Cc: Matthew Wilcox; Kernel Mailing List; linux-
> pci@atrey.karlin.mff.cuni.cz
> Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
> 
> On Thu, Jan 29, 2004 at 10:09:52AM -0800, Greg KH wrote:
> > On Thu, Jan 29, 2004 at 08:05:52AM -0800, Linus Torvalds wrote:
> > >
> > > That said, this patch looks perfectly acceptable to me. With some
> testing,
> > > I'd take it through Greg or -mm.
> >
> > It's looking much better.  But I _really_ want to actually test this
on
> > real hardware.  As no one is shipping PCI Express hardware yet,
there is
> > no rush to get this patch into the kernel tree.
> 
> Also, can someone from Intel test out Matthew's patch to make sure it
> works properly for them on their hardware?  It's much cleaner than the
> last patch submitted by you all :)
> 
> thanks,
> 
> greg k-h
