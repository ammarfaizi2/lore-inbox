Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTE0USp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTE0USp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:18:45 -0400
Received: from fmr05.intel.com ([134.134.136.6]:47827 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264138AbTE0USo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:18:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Date: Tue, 27 May 2003 13:31:57 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96EDE@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Thread-Index: AcMiRV654VDsj3o/T5+6w9Bf8k79AQCSYWyA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 May 2003 20:31:57.0395 (UTC) FILETIME=[04AE2230:01C3248F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Saturday, May 24, 2003 3:40 PM
> To: Grover, Andrew
> Cc: Andi Kleen; torvalds@transmeta.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
> 
> 
> On Sat, May 24, 2003 at 01:55:26PM -0700, Grover, Andrew wrote:
> > Actually, I think osl.c should be changed to match the header as it
> > stands. Could you try that and see if that also fixes things?
> 
> On looking again these functions are not used at all.
> How about just removing them? 

We will remove them for the next release.

Thanks -- Regards -- Andy
