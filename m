Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUBOKAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUBOKAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:00:09 -0500
Received: from fmr05.intel.com ([134.134.136.6]:61112 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264449AbUBOKAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:00:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] 2.6.2 ACPI problem
Date: Sun, 15 Feb 2004 17:59:50 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB6C1@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] 2.6.2 ACPI problem
Thread-Index: AcPwOj40lMLutg5WS4q6ayKLyh5G/ADb+wNg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Lenar L?hmus" <lenar@vision.ee>,
       "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 15 Feb 2004 09:59:51.0429 (UTC) FILETIME=[7418FB50:01C3F3AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now despite this machine seems to work fine until kde's laptop daemon 
> does something I'm not aware of which results in
> these lines in dmesg:
> 
> Feb 10 17:52:35 debian kernel:     ACPI-0245: *** Error: 
> Cannot release 
> Mutex [_GL_], not acquired

Would you please have patch
http://bugzilla.kernel.org/attachment.cgi?id=2090&action=view
a test!

-Luming
