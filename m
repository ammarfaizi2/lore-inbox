Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWA0PeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWA0PeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWA0PeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:34:16 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:1249 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751484AbWA0PeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:34:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with MSI-X on ia64
Date: Fri, 27 Jan 2006 09:34:13 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10B8ABBD0@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with MSI-X on ia64
Thread-Index: AcYi+2wpYWAuVhjHRse12cfWJjl5UQAW3QeA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Grundler, Grant G" <grant.grundler@hp.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 27 Jan 2006 15:34:14.0838 (UTC) FILETIME=[20F03D60:01C62357]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> cciss/c2d0:
> > 
> > And this is where we hang, when enabling interrupts in the driver.
> 
> Can you try 2.6.15, or possibly 2.6.16-rc1-mm3?
> 
That's the next step. Unfortunately the system is at another site so
there is latency in the process.

mikem
