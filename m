Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWAGAgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWAGAgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWAGAgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:36:07 -0500
Received: from amdext4.amd.com ([163.181.251.6]:17040 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932457AbWAGAgE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:36:04 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Inclusion of x86_64 memorize ioapic at bootup patch
Date: Fri, 6 Jan 2006 16:35:09 -0800
Message-ID: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CA@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Inclusion of x86_64 memorize ioapic at bootup patch
Thread-Index: AcYTIY9rBvf2vrE5SMC8KZwH0FIQdgAAGNSw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Morton Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Jan 2006 00:35:10.0558 (UTC)
 FILETIME=[376157E0:01C61322]
X-WSS-ID: 6FA1D3343982121723-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. You don't need Etherboot with IB later....

How about the size of your first kernel and initrd? Are they in IDE
Flash?

YH

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Friday, January 06, 2006 4:30 PM
To: Lu, Yinghai
Cc: Andi Kleen; Vivek Goyal; Fastboot mailing list; linux kernel mailing
list; Morton Andrew Morton
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch

Yinghai Lu <yinghai.lu@amd.com> writes:

> Eric,
>
> Do you try kexec with Nvidia ck804 based MB? it seems some one modify
> the mptable but not update the checksum ...

We've got a cluster using 2.6.14 booting over infiniband that
way.

Eric


