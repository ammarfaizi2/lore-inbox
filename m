Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWFYEcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFYEcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 00:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFYEcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 00:32:14 -0400
Received: from mga03.intel.com ([143.182.124.21]:47953 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751382AbWFYEcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 00:32:13 -0400
X-IronPort-AV: i="4.06,172,1149490800"; 
   d="scan'208"; a="56981655:sNHT16567831"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Date: Sun, 25 Jun 2006 00:32:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D35512@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Thread-Index: AcaYEAM0Q4CsHXNaQpCdKLDQ91jBBQAACFUg
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Miles Lane" <miles.lane@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 25 Jun 2006 04:32:11.0690 (UTC) FILETIME=[53A5A0A0:01C69810]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> acpi_processor-0758 [86] processor_preregister_: Error while parsing
>> _PSD domain information. Assuming no coordination
>
>Is that ACPI message new behaviour?

Yes, where new is in the last couple of months.
You can ignore the message -- it is going away.

-Len
