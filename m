Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVAOASS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVAOASS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVAOASS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:18:18 -0500
Received: from fmr13.intel.com ([192.55.52.67]:212 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262043AbVAOASP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:18:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] swiotlb: fix gcc printk warning
Date: Fri, 14 Jan 2005 16:17:47 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02BC5066@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] swiotlb: fix gcc printk warning
Thread-Index: AcT6ls03wQZixXwZSg6PRjeIDmYxlAAALNHA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "akpm" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jan 2005 00:17:48.0884 (UTC) FILETIME=[A505C140:01C4FA97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> swiotlb: Fix gcc printk format warning on x86_64, OK for ia64:
>> arch/ia64/lib/swiotlb.c:351: warning: long unsigned int format, long 
>> long unsigned int arg (arg 2)
>
>I applied to my tree for now, thanks, although Tony will likely
>want to push it.

I've put in my tree too.  I'll push to Linus with the next batch
of ia64 bits next week.

Thanks

-Tony
