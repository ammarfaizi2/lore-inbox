Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVCNQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVCNQyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCNQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:54:51 -0500
Received: from fmr19.intel.com ([134.134.136.18]:2999 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261574AbVCNQys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:54:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 08:54:34 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240803A13E@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUohQ1ag2HyJ4UxSUSL1EAMg6yYygAMMuWw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "David Vrabel" <dvrabel@cantab.net>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <greg@kroah.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 16:54:33.0642 (UTC) FILETIME=[7F6520A0:01C528B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, March 14, 2005 3:01 AM David Vrabel wrote:

>> This patch includes PCIEAER-HOWTO.txt, which describes how the PCI
>> Express Advanced Error Reporting Root driver works.
>>
>> --- linux-2.6.11-rc5/Documentation/PCIEAER-HOWTO.txt
>>
>Could this be placed in a sub-system subdirectory (creating one if
>necessary, e.g., pci/)?  The root of Documentation/ is rather full of
>random files as is.

Most of the HOWTO documents are under Documentation/ directory. I have
no problem of placing it in a sub-system subdirectory if it is OK with
Linux community?

Thanks,
Long
