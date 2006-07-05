Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWGEXWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWGEXWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWGEXWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:22:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:33170 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965061AbWGEXWO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:22:14 -0400
X-IronPort-AV: i="4.06,211,1149490800"; 
   d="scan'208"; a="61033362:sNHT61193468"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: regression / [PATCH] ACPI: fix fan/thermal resume
Date: Wed, 5 Jul 2006 19:22:09 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E593A8@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: regression / [PATCH] ACPI: fix fan/thermal resume
Thread-Index: AcagbrqCd/6UiZzwRiaKX6tFqRAxhQAGT5pw
From: "Brown, Len" <len.brown@intel.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>,
       "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>, "Pavel Machek" <pavel@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 05 Jul 2006 23:22:13.0151 (UTC) FILETIME=[D8990AF0:01C6A089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>found another smallish but annoying 
>regression...description/patch below.
>@intel: please add signed-off-by lines and forward to Linus 
>before 2.6.18 if you argee.
>@akpm: one round or so in -mm?

Daniel,

If the patch that originated in bugzilla 5000 fixes
your system, it would be most helpful if you could
update that bug report with your test results.

If you tested a modified patch, then it would be best
to attach that path to the report so that others could
test your modification also.

We use the RESOLVED state to signify that a patch exists
in the bug report that may fix the issue and it needs
review, testing, and consideration for forwarding to mm
and untimately to linus, depending on the results.

Looks like # 5000 moved from RESOLVED back to ASSIGNED
when the resume regression was found.
It should be marked RESOLVED now that there is a follow-on
patch to address that regression.

thanks,
-Len
