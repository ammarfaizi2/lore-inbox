Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbTGaWuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270278AbTGaWuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:50:51 -0400
Received: from [198.70.193.2] ([198.70.193.2]:20442 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S270000AbTGaWut convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:50:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b5).
Date: Thu, 31 Jul 2003 15:50:56 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B060EC99@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b5).
Thread-Index: AcNXtjPmXqyvalHnRyaH+XmzjjtLqw==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 31 Jul 2003 22:50:56.0864 (UTC) FILETIME=[343DDE00:01C357B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

A new version of the 8.x series driver for Linux 2.6.x kernels has
been uploaded to SourceForge:

	http://sourceforge.net/projects/linux-qla2xxx/

This beta addresses several scanning issues reported against 
8.00.00b4:

	o Mid-layer will not scan storage with sparse luns and/or
	  no lun 0.

Review the revision notes for further details of the changes 
in 8.00.00b5.

Regards,
Andrew Vasquez
