Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVG2TPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVG2TPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVG2TNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:13:53 -0400
Received: from fmr14.intel.com ([192.55.52.68]:30659 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262744AbVG2TLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:11:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Followup on 2.6.13-rc3 ACPI processor C-state regression
Date: Fri, 29 Jul 2005 15:11:29 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004311B75@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Followup on 2.6.13-rc3 ACPI processor C-state regression
Thread-Index: AcWUZ2yfE0mSRNy5SFCNPJvz0trufAACKksw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Kevin Radloff" <radsaq@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Jul 2005 19:11:31.0263 (UTC) FILETIME=[541254F0:01C59471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Len, Kevin confirms that the below patch fixes the above regression for
>him.  Should we merge it now?

Yes.
It is in my to-linus git tree.

thanks,
-Len
