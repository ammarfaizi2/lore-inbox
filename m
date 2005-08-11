Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVHKV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVHKV6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHKV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:58:39 -0400
Received: from fmr16.intel.com ([192.55.52.70]:63171 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932289AbVHKV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:58:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 14:58:21 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F041DACC8@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Thread-Index: AcWevY9m5VRv6OWdS9q98H5ZXJ67qgAAfSwA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: <B.Zolnierkiewicz@elka.pw.edu.pl>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2005 21:58:22.0797 (UTC) FILETIME=[CAC7EFD0:01C59EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Tony, others, does this change give you any heartburn?  On
>the 460GX and 870 boxes I have, IDE is a PCI device.

No heartburn for me ... as you say IDE is built into one
of the 870 chips.

I don't know whether any non-Intel chipsets provide legacy IDE.

-Tony
