Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUAFBEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUAFBEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:04:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:19615 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266033AbUAFBD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:03:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
Date: Tue, 6 Jan 2004 09:03:54 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
Thread-Index: AcPT7bCHtnOTV1HhSHaRifUk6hq28wAAr8hQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Dax Kelson" <dax@gurulabs.com>, <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Jan 2004 01:03:55.0606 (UTC) FILETIME=[F535C760:01C3D3F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
>
>Found at boot: 
>ACPI: Battery Slot [BAT0] (battery present)
>ACPI: Battery Slot [BAT1] (battery present)
>But no run-time information:

Some DELL battery issues in recent kernel are solved by
patch filed at http://bugzilla.kernel.org/show_bug.cgi?id=1766 .

Is it worthy to have it a try?

--Luming
