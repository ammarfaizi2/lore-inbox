Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTLDFew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTLDFew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:34:52 -0500
Received: from fmr05.intel.com ([134.134.136.6]:54232 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261863AbTLDFev convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:34:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: My current suspend bigdiff
Date: Thu, 4 Dec 2003 13:34:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720BFE@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My current suspend bigdiff
Thread-Index: AcOyrT+znWn2BuQfRQaZI++CAeCftwHelGwA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "ACPI mailing list" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Dec 2003 05:34:48.0328 (UTC) FILETIME=[54F49880:01C3BA28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is how my current "bigdiff" looks... [This is not for
>application, but if you want to make S3 working, it might help you].

I have some issues about entering S3. From device driver point of view,  
Could you please explain the main difference between entering S1 and S3.
