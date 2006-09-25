Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWIYRyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWIYRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWIYRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:54:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:53887 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751407AbWIYRyI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:54:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,215,1157353200"; 
   d="scan'208"; a="135429854:sNHT413652946"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: New section mismatch warning on latest linux-2.6 git tree
Date: Mon, 25 Sep 2006 10:51:54 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454A41360@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: New section mismatch warning on latest linux-2.6 git tree
Thread-Index: Acbft5wUD29dp3dLQa6nIdDPmSjR5gBE4/Uw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ismail Donmez" <ismail@pardus.org.tr>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 25 Sep 2006 17:51:55.0233 (UTC) FILETIME=[4A123D10:01C6E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ismail Donmez
>Sent: Sunday, September 24, 2006 1:58 AM
>To: LKML
>Subject: New section mismatch warning on latest linux-2.6 git tree
>
>Hi,
>
>This seems to be pretty new :
>
>WARNING: arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o - 
>Section mismatch: 
>reference to .init.text: from .data between 
>'sw_any_bug_dmi_table' (at offset 
>0x320) and 'centrino_attr'
>
>Using Linus' latest git tree.
>
>Regards,
>ismail

Andrew,

Can you please push the patch from Jeremy here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0609.1/1389.html

Thanks,
Venki
