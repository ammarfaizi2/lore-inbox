Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbULUTqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbULUTqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULUTqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:46:45 -0500
Received: from fmr19.intel.com ([134.134.136.18]:55715 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261535AbULUTql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:46:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Tue, 21 Dec 2004 11:46:32 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074C281F@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTnjvRZQ+ha6SNXQuiJYEV9ooGn/AABOh+Q
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 21 Dec 2004 19:46:33.0548 (UTC) FILETIME=[C64090C0:01C4E795]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 21, 2004 10:58 AM, Christoph Hellwig wrote: 
> Any reason the new files aren't just under drivers/pci/ ?
PCI Express Port Bus driver runs on PCI Express PCI-PCI Bridges to
manage service requests as required while under drivers/pci/ includes
specific drivers for the PCI bus. Please send us your suggestions.

Thanks,
Long
