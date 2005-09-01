Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVIASY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVIASY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVIASY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:24:26 -0400
Received: from fmr16.intel.com ([192.55.52.70]:43980 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030285AbVIASYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:24:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: reboot vs poweroff
Date: Thu, 1 Sep 2005 14:23:31 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: reboot vs poweroff
Thread-Index: AcWvIcPmcynP1pdLRUa84eIX1QsCTAAACV7Q
From: "Brown, Len" <len.brown@intel.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <ncunningham@cyclades.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 18:23:35.0882 (UTC) FILETIME=[444182A0:01C5AF22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>Patch tested and works fine here. You should probably make a 
>note in the bugzilla so we don't get a conflicting merge
>from the ACPI folks.

One might also consider that it would be a good idea to
send patches that break ACPI files to the ACPI maintainer
and acpi-devel@lists.sourceforge.net before sending them
to Linus...

-Len
