Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUGVUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUGVUth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUGVUth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:49:37 -0400
Received: from fmr12.intel.com ([134.134.136.15]:14976 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267258AbUGVUtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:49:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
Date: Thu, 22 Jul 2004 13:48:12 -0700
Message-ID: <37F890616C995246BE76B3E6B2DBE05501787207@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
thread-index: AcRvcySBi2h+76QbQ2qDVX56NZCWcwAue0SA
From: "Moore, Robert" <robert.moore@intel.com>
To: "Carl Spalletta" <cspalletta@yahoo.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, <acpi-devel@lists.sourceforge.net>,
       "Yu, Luming" <luming.yu@intel.com>
X-OriginalArrivalTime: 22 Jul 2004 20:48:14.0197 (UTC) FILETIME=[3538CA50:01C4702D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ACPI CA AML debugger and disassembler haven't been integrated into
the kernel yet, but development is underway and almost complete.


> -----Original Message-----
> From: Carl Spalletta [mailto:cspalletta@yahoo.com]
> Sent: Wednesday, July 21, 2004 3:36 PM
> To: Moore, Robert; lkml
> Cc: Brown, Len; acpi-devel@lists.sourceforge.net
> Subject: RE: [PATCH] remove 55 dead prototypes from
> include/acpi/acdisasm.h
> 
> --- "Moore, Robert" <robert.moore@intel.com> wrote:
> > These aren't nonexistent functions, they are part of the AML
> > disassembler (which is not always configured into the kernel)
> 
>   With respect, I cannot find the functions listed below anywhere in
> the kernel.org kernel.  Where are they?  Given that they are not
present,
> you should consider either contributing them to the mainline kernel
source
> tree, or removing their prototypes.
> 
