Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWH1Q2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWH1Q2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWH1Q2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:28:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:21356 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751080AbWH1Q2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:28:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="116224541:sNHT17283798"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Date: Mon, 28 Aug 2006 09:28:35 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A6EA45D@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Thread-Index: AcbKf1+Osoxfnk1jSIS53JKo+aKT4QAPsuXA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>, <linux-ia64@vger.kernel.org>,
       <linux-mips@linux-mips.org>, <linuxppc-embedded@ozlabs.org>,
       <paulkf@microgate.com>, <takata@linux-m32r.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Aug 2006 16:28:37.0308 (UTC) FILETIME=[038267C0:01C6CABF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c

Acked-by: Tony Luck <tony.luck@intel.com>

[IA-64 part only ... I didn't look at the rest]

-Tony
