Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVG0Uxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVG0Uxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVG0Uv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:51:59 -0400
Received: from fmr16.intel.com ([192.55.52.70]:44944 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262473AbVG0Utv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:49:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 16:49:24 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300428C952@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: ACPI buttons in 2.6.12-rc4-mm2
Thread-Index: AcWSHQ/MY8d6vP8iRRKiIsgwVGRcyQAz0bkQ
From: "Brown, Len" <len.brown@intel.com>
To: "Pavel Troller" <patrol@sinus.cz>
Cc: "Cameron Harris" <thecwin@gmail.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2005 20:49:27.0165 (UTC) FILETIME=[AD8E52D0:01C592EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that the value of _LID can be usefult to user-space
and I'll be sure it is restored as a property of the lid device
under sysfs -- available as a simple file read like it
was under /proc.

thanks,
-Len
