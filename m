Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWDEAgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDEAgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDEAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:36:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:64351 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750911AbWDEAgP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:36:15 -0400
X-IronPort-AV: i="4.03,165,1141632000"; 
   d="scan'208"; a="19193030:sNHT16668981"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] [PATCH] kexec on ia64
Date: Wed, 5 Apr 2006 08:36:07 +0800
Message-ID: <08B1877B2880CE42811294894F33AD5C053A82@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] [PATCH] kexec on ia64
Thread-Index: AcZYE76ggLZqDs0wTC+a/DlWra64HAANN0IQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Khalid Aziz" <khalid_aziz@hp.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "Linux ia64" <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2006 00:36:07.0680 (UTC) FILETIME=[EDC77800:01C65848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org
> [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Eric W. Biederman
> Sent: 2006Äê4ÔÂ5ÈÕ 2:14
> To: Khalid Aziz
> Cc: LKML; Fastboot mailing list; Linux ia64
> Subject: Re: [Fastboot] [PATCH] kexec on ia64
> 
> Khalid Aziz <khalid_aziz@hp.com> writes:
> 
> > Add kexec support on ia64.
> 
> This looks like a starting place but this patch needs some
> more work.
> 
Eric,
	Khalid is also merging my ia64 kdump patch posted in http://lkml.org/lkml/2006/3/14/46.
	Hopefully those issues you pointed out will be solved once the kdump patch is merged. 

Thanks
Zou Nan hai
