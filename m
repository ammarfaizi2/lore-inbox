Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbUDMV6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUDMV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:58:42 -0400
Received: from fmr06.intel.com ([134.134.136.7]:43956 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263767AbUDMV6k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:58:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] PCI MSI Kconfig consolidation
Date: Tue, 13 Apr 2004 14:57:18 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058239@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI MSI Kconfig consolidation
Thread-Index: AcQhnobUSaD6HtTfTpWY2xuPv1DyZAAA2FXA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 13 Apr 2004 21:58:13.0379 (UTC) FILETIME=[6AD21D30:01C421A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2004 Andi Kleen wrote:

>> 
>> In fact, I think there's a whole lot more architecture-specific
>> knowledge that has leaked across into drivers/pci/msi.[ch].  For
>
>Yes. Far too lot. Even for the relatively small x86<->x86-64 differences.
>That was the reason I disabled it for x86-64 initially ....
>[hoping that someone with MSI hardware will fix and reenable it]

We are in the progress of enabling MSI on x86_64.

Thanks,
Long
