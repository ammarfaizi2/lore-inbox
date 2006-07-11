Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWGKTgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWGKTgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGKTgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:36:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:9016 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751143AbWGKTgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:36:36 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="96413952:sNHT15528422"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1, kacpid_notify/7105
Date: Tue, 11 Jul 2006 15:36:30 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F3153D@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1, kacpid_notify/7105
Thread-Index: AcalIDeuXC/B7GlZRWGcU7Tw32wgMgAAQLkQ
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Jeremy Fitzhardinge" <jeremy@goop.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2006 19:36:33.0331 (UTC) FILETIME=[50B6F830:01C6A521]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I think the patch I posted on Friday will solve this issue:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=115230920629981&w=2
>
>It is included in 2.6.18-rc1-mm1.

FYI, this is included in 2.6.18-rc1-git4
