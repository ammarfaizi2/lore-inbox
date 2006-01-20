Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWATGIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWATGIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWATGIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:38 -0500
Received: from fmr15.intel.com ([192.55.52.69]:50336 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422686AbWATGI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16-rc1-mm1 (**** SET: Misaligned resource pointer: ...)
Date: Fri, 20 Jan 2006 01:08:08 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF4@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc1-mm1 (**** SET: Misaligned resource pointer: ...)
Thread-Index: AcYcJ0FBRuMA4jW6RWW8MJn0RLeVGwBYB3dQ
From: "Brown, Len" <len.brown@intel.com>
To: "Grant Coady" <gcoady@gmail.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>
X-OriginalArrivalTime: 20 Jan 2006 06:08:18.0038 (UTC) FILETIME=[E8378160:01C61D87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>**** SET: Misaligned resource pointer: efe72c22 Type 07 Len 0

Grant,
Thanks for sending the DSDT.

Bob dug into this and concluded that this
new warning is from excess paranoia and can be ignored.
It will be gone in the next revision of the ACPI patch.

thanks,
-Len
