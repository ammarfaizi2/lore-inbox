Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUABHSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUABHSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:18:11 -0500
Received: from fmr06.intel.com ([134.134.136.7]:20182 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265196AbUABHR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:17:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI and framebuffer related problems with Linux 2.6.1-rc1
Date: Fri, 2 Jan 2004 15:17:53 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C6E@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI and framebuffer related problems with Linux 2.6.1-rc1
Thread-Index: AcPQtKSs5HVeEQbyT6mskH1G2g294wAS4GLA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Martin Loschwitz" <madkiss@madkiss.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 02 Jan 2004 07:17:53.0859 (UTC) FILETIME=[89CC7930:01C3D100]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>However, there is a problem with ACPI:
/proc/acpi/processor/CPU0/performance, 
>which was there in previous versions of the kernel and allowed me to
slow the 
>CPU down in order to save power, disappeared in Linux 2.6.1-rc1. It's
simply 
>not there anymore. Was it replaced? 

It sounds like a regression. Would you file it on
http://bugzilla.kernel.org
