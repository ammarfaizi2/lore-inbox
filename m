Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWDYTxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWDYTxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWDYTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:53:40 -0400
Received: from mga03.intel.com ([143.182.124.21]:18955 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751383AbWDYTxj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:53:39 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27681347:sNHT68659143"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 25 Apr 2006 15:53:34 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZogp454nB91ws2SWyjcRy2AvwmaQAHvoNw
From: "Brown, Len" <len.brown@intel.com>
To: "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>
Cc: <akpm@digeo.com>, <ak@suse.de>, <kmurray@redhat.com>,
       <natalie.protasevich@unisys.com>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2006 19:53:35.0906 (UTC) FILETIME=[F068C820:01C668A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather see the original irq-renaming patch
and its subsequent multiple via workaround patches
reverted than to further complicate what is becoming
a fragile mess.

-Len
