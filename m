Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUDMVyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbUDMVyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:54:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:27058 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263772AbUDMVyX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:54:23 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] PCI MSI Kconfig consolidation
Date: Tue, 13 Apr 2004 14:54:05 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058238@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI MSI Kconfig consolidation
Thread-Index: AcQhkxa3om2DXrP+RA2RlOXDujCnCgADhJWg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 13 Apr 2004 21:54:11.0220 (UTC) FILETIME=[DA7B9540:01C421A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, Bjorn Helgaas wrote:

> No.  This is one reason why I think the MSI configuration symbol
> should be CONFIG_PCI_MSI, not CONFIG_PCI_USE_VECTOR.

Agree. The MSI configuration symbol should be CONFIG_PCI_MSI. We will update it, including
your PCI MSI Kconfig consilidation patch.

Thanks,
Long

