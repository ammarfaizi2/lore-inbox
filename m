Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbULRAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbULRAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbULRAo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:44:56 -0500
Received: from fmr19.intel.com ([134.134.136.18]:43984 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262506AbULRAou convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:44:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Fri, 17 Dec 2004 16:44:48 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024074742E2@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTklVIZX01d0RhTSZ6Jb8kFP6PmRgABHiQw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 18 Dec 2004 00:44:49.0290 (UTC) FILETIME=[C74B16A0:01C4E49A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, December 17, 2004 4:06 PM, Greg KH wrote:  
>Hm, I get a oops message at boot time, on a non-pci express box, with
>PCI_GOMMCONFIG enabled and your patch.  Something down in the ACPI
>subsystem. 
>
> Have you tested this kind of configuration?

No, we've not tested this kind of configuration on a non-pci express
box.
We'll test it on a non-pci express box and let you know the result
later.

> I'll hold off on applying the patch for now due to this :)
Agree.

Thanks,
Long
