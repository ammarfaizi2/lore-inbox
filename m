Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUINXIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUINXIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUINXIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:08:13 -0400
Received: from gatehider.cnt.com ([139.93.128.13]:44611 "EHLO esply07.cnt.com")
	by vger.kernel.org with ESMTP id S267705AbUINXDj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:03:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SSC-2 support in Linux
Date: Tue, 14 Sep 2004 18:03:29 -0500
Message-ID: <82C736F456CA3E4EA3D0DC6CC31AA5CB01651157@esply09.cnt.ad.cnt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SSC-2 support in Linux
Thread-Index: AcSapi+/9MRPegzASzeAbs/mFUL4UwAB1RsA
From: "David Peterson \(Eng\)" <david_peterson@cnt.com>
To: <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 14 Sep 2004 23:03:30.0608 (UTC) FILETIME=[0D495300:01C49AAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to hear from anyone interested, or has looked into, adding
support for SSC-2 (SCSI Stream Commands -2, i.e., tape devices) explicit
address mode into the Linux OS.

In summary, SSC-2 explicit address mode enables for tape devices:
- robust tagged command queuing
- multi-path I/O
- enhanced error detection and recovery

Thanks...Dave
