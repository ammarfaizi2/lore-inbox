Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbUKXRzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUKXRzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUKXRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:53:12 -0500
Received: from fmr15.intel.com ([192.55.52.69]:60093 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262770AbUKXRvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:51:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Date: Wed, 24 Nov 2004 09:51:24 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0271E665@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Thread-Index: AcTRw96orC/nsr9iTRiMK45P3iuPtQAie6aw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: <hugh@veritas.com>, <chrisw@osdl.org>, <torvalds@osdl.org>,
       <schwidefsky@de.ibm.com>, <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2004 17:51:26.0765 (UTC) FILETIME=[3855DDD0:01C4D24E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>>
>> I think ia64 ia32
>> subsystem is not vulnerable to this kind of overlapping vm problem,
>> because it does not support a.out binary format, 
>> X84_64 is vulnerable to this. 
>
>Martin, Andi and Tony: could we please get a 2.6.10 ack on 
>this from you?

I can "Ack" it too ... but I gave Nanhai one of my "Signed-off-by:"
lines which he already attached to this patch :-)

-Tony
