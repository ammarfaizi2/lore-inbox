Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUIHQ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUIHQ5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUIHQ5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:57:39 -0400
Received: from fmr99.intel.com ([192.55.52.32]:2270 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S269060AbUIHQ5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:57:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Date: Wed, 8 Sep 2004 09:56:05 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F01FB74E7@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Thread-Index: AcSVXJ2V2rOB091wQv2KBMoL91BIGgAZ9Gug
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jesse Barnes" <jbarnes@engr.sgi.com>, "Paul Jackson" <pj@sgi.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, <ianw@gelato.unsw.edu.au>,
       "William Irwin" <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Sep 2004 16:56:08.0544 (UTC) FILETIME=[BCB6C600:01C495C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks Paul, this looks a little simpler than the patch I 
>posted (I'd rather just make CONFIG_DISCONTIGMEM and
>CONFIG_VIRTUAL_MEMMAP mandatory on ia64, but that's for
>another patch).  Linus, since this breakage is in your
>tree now, can you please apply this assuming Tony has
>no complaints so that people can build on ia64 again?

I have no complaints.  I see that Linus has already
applied Paul's patch to his BK tree.

-Tony
