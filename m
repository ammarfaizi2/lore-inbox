Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWFXXZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWFXXZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 19:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFXXZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 19:25:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:55073 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750859AbWFXXZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 19:25:35 -0400
X-IronPort-AV: i="4.06,172,1149490800"; 
   d="scan'208"; a="88767051:sNHT14900144"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] riport LADAR driver
Date: Sat, 24 Jun 2006 16:25:33 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D018D22B7@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] riport LADAR driver
Thread-Index: AcaX3eLPRgAt6km8QH2635Ak6GseyQAB1Iag
From: "Gross, Mark" <mark.gross@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, <mgross@linux.intel.com>
Cc: <arjan@infradead.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2006 23:25:34.0807 (UTC) FILETIME=[7E400E70:01C697E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
>Sent: Saturday, June 24, 2006 3:34 PM
>To: mgross@linux.intel.com
>Cc: arjan@infradead.org; linux-kernel@vger.kernel.org; Gross, Mark
>Subject: Re: [PATCH] riport LADAR driver
>
>On Fri, 23 Jun 2006 15:46:54 -0700 mark gross wrote:
>
>> +module_param(io, int, 0444);
>> +MODULE_PARM_DESC(io, "if non-zero then overrides IO port address");
>> +
>> +module_param(irq, int, 0444);
>> +MODULE_PARM_DESC(io, "if non-zero then overrides IRQ number");
>                    irq
>
>> +module_param(size, int, 0444);
>> +MODULE_PARM_DESC(io, "if non-zero then overrides buffer size");
>                    size
>
>Did you ever update these?  I mentioned them in a previous
>email.

They are now.  Sorry I missed them.  The first time my eye looked over
your comments I actually didn't see the irq and size comments you put
in.

Thanks,

--mgross
