Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUGSCS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUGSCS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 22:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUGSCS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 22:18:28 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10405 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264643AbUGSCS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 22:18:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: vaio preempt + acpi ac/battery trouble
Date: Mon, 19 Jul 2004 10:18:14 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5600@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: vaio preempt + acpi ac/battery trouble
Thread-Index: AcRp0RWXmX6joWS+RMSQIFJkT0tTYwDZSysQ
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Greg Ingram" <ingram@symsys.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jul 2004 02:18:15.0802 (UTC) FILETIME=[A63EEDA0:01C46D36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> ACPI-1133: *** Error: Method execution failed
[\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL

> The real problem is that the AC Adaptor status is wrong.  The preempt 
> kernel always thinks the AC is off-line. 

ACPI bugs are tracked on http://bugme.osdl.org. Please file a bug there.

-yi
