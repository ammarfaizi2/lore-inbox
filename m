Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVDURTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVDURTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDURTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:19:54 -0400
Received: from fmr14.intel.com ([192.55.52.68]:47031 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261556AbVDURTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:19:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Date: Thu, 21 Apr 2005 10:19:28 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0350B393@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Thread-Index: AcVGg6xerZgjmZb4SUqzCmNVWXSt+gAEg16A
From: "Luck, Tony" <tony.luck@intel.com>
To: <davidm@hpl.hp.com>, <akpm@osdl.org>
Cc: "Andreas Hirstius" <Andreas.Hirstius@cern.ch>,
       "Bartlomiej ZOLNIERKIEWICZ" <Bartlomiej.Zolnierkiewicz@cern.ch>,
       "Gelato technical" <gelato-technical@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2005 17:19:29.0075 (UTC) FILETIME=[46709830:01C54696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just checked 2.6.12-rc3 and the fls() fix is indeed missing.  Do you
>know what happened?

If BitKeeper were still in use, I'd have dropped that patch into my
"release" tree and asked Linus to "pull" ... but it's not, and I was
stalled.  I should have a "git" tree up and running in the next couple
of days.  I'll make sure that the fls fix goes in early.

-Tony
