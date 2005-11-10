Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVKJHky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVKJHky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKJHky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:40:54 -0500
Received: from fmr15.intel.com ([192.55.52.69]:9181 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751266AbVKJHkx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:40:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: merge status
Date: Thu, 10 Nov 2005 02:38:35 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30051F0F73@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: merge status
Thread-Index: AcXlda1kDKUMSyrUSzCl5FoQduDafgAUyHTw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Luck, Tony" <tony.luck@intel.com>,
       "Ben Collins" <bcollins@debian.org>,
       "Jody McIntyre" <scjody@modernduck.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Roland Dreier" <rolandd@cisco.com>,
       "Dave Jones" <davej@codemonkey.org.uk>, "Jens Axboe" <axboe@suse.de>,
       "Dave Kleikamp" <shaggy@austin.ibm.com>,
       "Steven French" <sfrench@us.ibm.com>
X-OriginalArrivalTime: 10 Nov 2005 07:38:38.0891 (UTC) FILETIME=[C3F7C7B0:01C5E5C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-rw-r--r--    1 akpm     akpm       188863 Nov  9 11:29 git-acpi.patch

FreeBSD found some problems with some of the post 2.6.14
ACPI core changes, and the version we have in 2.6.14 seems
pretty stable, so I'll probably keep it the same for 2.6.15.

I do have a bundle of Linux specific bug fixes to push,
but I didn't follow Tony's git branching strategy
correctly at first, so I've got to cherry pick a few...

-Len


