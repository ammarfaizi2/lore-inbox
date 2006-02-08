Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWBHTtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBHTtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBHTtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:49:50 -0500
Received: from fmr21.intel.com ([143.183.121.13]:22466 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750968AbWBHTtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:49:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 11:48:43 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05A6E0C5@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] let IA64_GENERIC select more stuff
Thread-Index: AcYs5VZIjb2rvlqAQOaPyB27fkohugAAzH7g
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jes Sorensen" <jes@sgi.com>, "Alex Williamson" <alex.williamson@hp.com>
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Keith Owens" <kaos@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Feb 2006 19:48:44.0526 (UTC) FILETIME=[AB56B8E0:01C62CE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That could explain it, but the question is whether one would want to
> boot a generic kernel when running on a simulator. After all then every
> cycle does count ;)

You might if you wanted to use the simulator to debug a problem that
only showed up in a generic kernel.

-Tony
