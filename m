Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCOSj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCOSj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVCOSiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:38:10 -0500
Received: from fmr20.intel.com ([134.134.136.19]:62374 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261756AbVCOSd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:33:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 5/6] PCI Express Advanced Error Reporting Driver
Date: Tue, 15 Mar 2005 10:33:47 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080A4C09@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUm2jO13EN9rEGZSJKT6yTdG/nW9QCsq14g
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 15 Mar 2005 18:33:49.0228 (UTC) FILETIME=[879D2EC0:01C5298D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, March 11, 2005 11:30 PM Greg KH wrote:
>> +
>> +LIST_HEAD(rc_list);			/* Define Root Complex List */
>>
>Static?

The rc_list is not static. Thanks for pointing it out. Will make it
static. 

Thanks,
Long
