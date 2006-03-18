Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWCRQh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCRQh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWCRQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:37:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:6218 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750702AbWCRQh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:37:28 -0500
X-IronPort-AV: i="4.03,106,1141632000"; 
   d="scan'208"; a="14226820:sNHT130704014"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Sun, 19 Mar 2006 00:37:20 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC26A@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZKqN7LWO84lmfbTbC7c3QAzVzBEAAAN9/A
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 18 Mar 2006 16:37:21.0142 (UTC) FILETIME=[3A67E160:01C64AAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Here first are the dmesgs from suspending with a vanilla 2.6.16-rc5.  I
>did only one cycle so that it didn't hang and I could edit this email
>without rebooting (but later suspends produce the same method 
>calls, I'm
>90% sure):
>
># the sleep dmesgs
>PM: Preparing system for mem sleep
>Stopping tasks: 
>=======================================================|
Did you see any methods before and after this line in hang case on
screen?
If yeas, do you recall what they are?
