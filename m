Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVHXVnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVHXVnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVHXVnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:43:00 -0400
Received: from fmr14.intel.com ([192.55.52.68]:63668 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932285AbVHXVm7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:42:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 05/15] ia64: remove use of asm/segment.h
Date: Wed, 24 Aug 2005 14:42:44 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04385372@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 05/15] ia64: remove use of asm/segment.h
Thread-Index: AcWo82NrayhVI3r7RUWM1J3XVKFMdgAAOIgA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2005 21:42:45.0517 (UTC) FILETIME=[C37D1BD0:01C5A8F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll apply this for ia64 w/o the deletion.

This is now in my test tree.  I will send to Linus soon after
2.6.13 is released.

>I've posted a patch before this to remove all non-architecture users  
>of asm/segment.h.
>
>http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/0099.html

Good.  After that gets I applied I will delete include/asm-ia64/segment.h

-Tony
