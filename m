Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUARG3m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 01:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUARG3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 01:29:42 -0500
Received: from fmr05.intel.com ([134.134.136.6]:23231 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266227AbUARG3l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 01:29:41 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] 2.6.1-mm3 acpi frees free irq0
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Sun, 18 Jan 2004 14:29:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CEE@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] 2.6.1-mm3 acpi frees free irq0
Thread-Index: AcPbvXA0YLLSM6w+RviQP+i/t84+KgBzcUuw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jes Sorensen" <jes@wildopensource.com>,
       "Brown, Len" <len.brown@intel.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "Jesse Barnes" <jbarnes@sgi.com>
X-OriginalArrivalTime: 18 Jan 2004 06:29:30.0904 (UTC) FILETIME=[6E1CB180:01C3DD8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In this specific case the prom doesn't have it in it's tables, so not
> finding it is expected behavior.

What's your machine type, and BIOS version?
This specific box seems to be short of
fundamental ACPI power button support.

Please refer ACPI spec 3.2.1
