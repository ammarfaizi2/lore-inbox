Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756025AbWKQXTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbWKQXTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbWKQXTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:19:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:20344 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1756025AbWKQXTU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:19:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,436,1157353200"; 
   d="scan'208"; a="163310563:sNHT85103270"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][acpi-cpufreq/userspace-governor]Frequency does not change
Date: Fri, 17 Nov 2006 15:19:17 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E76579@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][acpi-cpufreq/userspace-governor]Frequency does not change
Thread-Index: AccKjn7NT/8ZGfpRSvOTubU9x1nJDQAD++3w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dhaval Giani" <dhaval.giani@gmail.com>, <davej@codemonkey.org.uk>,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>, <linux@brodo.de>,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2006 23:19:18.0808 (UTC) FILETIME=[CE72A980:01C70A9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 

>-----Original Message-----
>From: Dhaval Giani [mailto:dhaval.giani@gmail.com] 
>Sent: Friday, November 17, 2006 1:22 PM
>To: Pallipadi, Venkatesh; davej@codemonkey.org.uk; 
>Diefenbaugh, Paul S; linux@brodo.de; Sadykov, Denis M
>Cc: linux-kernel@vger.kernel.org
>Subject: [BUG][acpi-cpufreq/userspace-governor]Frequency does 
>not change
>
>Hey there,
>
>Looks like I spoke too soon. I tried changing the frequency in cpu1
>and then it all fell apart. I got a ridiculously high value. To test
>it, I rebooted my system, and this is what happened.
>

You will also need another patch here.
http://lists.linux.org.uk/mailman/private/cpufreq/2006-November/006591.h
tml

Please apply that patch along with the other one that you already
applied and let me know if you still see the issue.

Thanks,
Venki
