Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUBCIQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUBCIQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:16:36 -0500
Received: from fmr05.intel.com ([134.134.136.6]:35767 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265913AbUBCIQg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:16:36 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] Re: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Date: Tue, 3 Feb 2004 16:16:06 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB670@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Thread-Index: AcPpFW+I63kGR3uURcWMz1Oo3jY4GQBGFfmQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Huw Rogers" <count0@localnet.com>
Cc: <linux-kernel@vger.kernel.org>, <ncunningham@users.sourceforge.net>,
       <linux-laptop@mobilix.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 03 Feb 2004 08:16:06.0939 (UTC) FILETIME=[F90E2EB0:01C3EA2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> [Do *not* enable suspend on SMP for mainline, unless you are willing
> to audit that code...]

When do you want to have SMP support ? This is a laptop having HT.
