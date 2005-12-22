Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVLVNbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVLVNbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVLVNbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:31:13 -0500
Received: from palrel11.hp.com ([156.153.255.246]:18354 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S965151AbVLVNbM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:31:12 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [perfmon] Re: quick overview of the perfmon2 interface
Date: Thu, 22 Dec 2005 05:31:09 -0800
Message-ID: <3C87FFF91369A242B9C9147F8BD0908A02C69459@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [perfmon] Re: quick overview of the perfmon2 interface
Thread-Index: AcYG7wGo9h8zCNacT9CtFCEU3xhKXwABpBiA
From: "Truong, Dan" <dan.truong@hp.com>
To: "Eranian, Stephane" <stephane.eranian@hp.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <perfmon@napali.hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <perfctr-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 22 Dec 2005 13:31:10.0265 (UTC) FILETIME=[F884D290:01C606FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to David, Dan and Phil for their comments.

Another note on the urgency of standardizing Perfmon:

Anarchy is not a good breeding ground for tools that need a
stable infrastructure to mature. Being "there" is what made
PAPI and perfctr popular and somewhat standard infrastructure.

Compilers, tools, JVMs... -you name it- are all moving
fast towards using hardware counters to get feedback,
tune, monitor or measure application behavior.

The PMU is becoming a standard commodity. Once Perfmon is
"the" Linux interface, all the tools can align on it and
coexist, push their R&D forward, and more importantly become
fully productized for businesses usage. Hopefully Perfmon's
interface is powerful enough to support future needs.

Good luck Stephane :)

Cheers,

Dan-
