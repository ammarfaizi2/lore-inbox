Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVCUWkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVCUWkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCUWgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:36:31 -0500
Received: from fmr16.intel.com ([192.55.52.70]:40390 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262126AbVCUWcg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:32:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
Date: Mon, 21 Mar 2005 14:31:36 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/5] freepgt: free_pgtables use vma list
Thread-Index: AcUuZUY3qS+fUTaJT1SVABfnQeFJjAAAFXgQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: <akpm@osdl.org>, <nickpiggin@yahoo.com.au>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
X-OriginalArrivalTime: 21 Mar 2005 22:31:43.0624 (UTC) FILETIME=[C24BA880:01C52E65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Builds clean and boots on ia64.

I haven't tried any hugetlb operations on it though.

-Tony
