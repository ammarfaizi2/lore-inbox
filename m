Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265672AbUFVTio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbUFVTio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUFVTed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:34:33 -0400
Received: from fmr06.intel.com ([134.134.136.7]:44679 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265058AbUFVSIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:08:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on using MSI in PCI driver
Date: Tue, 22 Jun 2004 11:08:04 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on using MSI in PCI driver
Thread-Index: AcRYgZ6cRo+18O9zQz+d5dIANjNmnAAAVBcw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jun 2004 18:08:05.0633 (UTC) FILETIME=[DDADC710:01C45883]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 Roland Dreier wrote: 

>Do you think the msi subsystem should use a different name for the
>MSI-X memory region ("MSI-X iomap Failure" seems very strange to me).

What do you think of "Failure to request the MMIO address space of the
MSI-X PBA"?
Or what name do you suggest?

Thanks,
Long
