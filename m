Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUC2Uwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUC2Uwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:52:32 -0500
Received: from fmr03.intel.com ([143.183.121.5]:63148 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262217AbUC2Uw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:52:26 -0500
Message-Id: <200403292049.i2TKnvF11443@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "'Ray Bryant'" <raybry@sgi.com>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Cc: <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Date: Mon, 29 Mar 2004 12:49:57 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQVkBQZE22XHoMUTr6zcz3m3jTLKAAO2bgQAADg7GA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> Chen, Kenneth W wrote on Mon, March 29, 2004 12:46 PM
> overcomit is not checked for hugetlb mmap, is it intentional here?

Just to follow up myself, I meant overcommit accounting is not done
for mmap hugetlb page.  (typical Monday morning symptom :))

- Ken


