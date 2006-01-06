Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWAFSXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWAFSXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAFSXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:23:36 -0500
Received: from amdext4.amd.com ([163.181.251.6]:61406 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964816AbWAFSXf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:23:35 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] Inclusion of x86_64 memorize ioapic at bootup
 patch
Date: Fri, 6 Jan 2006 10:22:13 -0800
Message-ID: <6F7DA19D05F3CF40B890C7CA2DB13A42030949C1@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] Inclusion of x86_64 memorize ioapic at bootup
 patch
Thread-Index: AcYS1h6mtQrsW0j4Qz+NKA/mqgAGuQAF7l1Q
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Ronald G Minnich" <rminnich@lanl.gov>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Andrew Morton" <akpm@osdl.org>, discuss@x86-64.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       vgoyal@in.ibm.com
X-OriginalArrivalTime: 06 Jan 2006 18:22:15.0243 (UTC)
 FILETIME=[1EA739B0:01C612EE]
X-WSS-ID: 6FA06ADD0T02065022-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is critical, otherwise We can use kexec with LinuxBIOS.

I'm thinking we may need to use kexec and tiny kernel to support RAID5
in some MB....

YH


