Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbULUVCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbULUVCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbULUVCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:02:33 -0500
Received: from fmr20.intel.com ([134.134.136.19]:7552 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261577AbULUVCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:02:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Tue, 21 Dec 2004 13:02:24 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074C28FC@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTnlzBMHNUCLa0IRZSmyldmCLvMJwACOYKA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Dec 2004 21:02:26.0315 (UTC) FILETIME=[5FE9ADB0:01C4E7A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 21, 2004 11:56 AM, Greg KH wrote:  
> On Tue, Dec 21, 2004 at 11:46:32AM -0800, Nguyen, Tom L wrote:
>> On Tuesday, December 21, 2004 10:58 AM, Christoph Hellwig wrote: 
>> > Any reason the new files aren't just under drivers/pci/ ?
>> PCI Express Port Bus driver runs on PCI Express PCI-PCI Bridges to
>> manage service requests as required while under drivers/pci/ includes
>> specific drivers for the PCI bus. Please send us your suggestions.
>
> I think drivers/pci/pcie would be a good place for this, as you can't
> have PCI-E without PCI, right?
Sound good.

Thanks,
Long
