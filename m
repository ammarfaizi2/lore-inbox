Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268634AbUHLRrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268634AbUHLRrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268635AbUHLRrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:47:18 -0400
Received: from webmail3.altiris.com ([64.90.198.11]:28680 "EHLO
	ali-ex1.altiris.com") by vger.kernel.org with ESMTP id S268634AbUHLRrR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:47:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Date: Thu, 12 Aug 2004 11:47:16 -0600
Message-ID: <9B96255DE3B181429D06C6ADB0B37470232B29@sandman.altiris.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Thread-Index: AcR/6nG1TFLtTA9zRuu+EV+0RtivBAAqc/2w
From: "John Riggs" <jriggs@altiris.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "John Riggs" <jriggs@altiris.com>
X-OriginalArrivalTime: 12 Aug 2004 17:47:16.0749 (UTC) FILETIME=[685A73D0:01C48094]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, that sounds like what is happening.  Can you build a modular
kernel
> and load the drivers you need one by one until the error happens?

After rebuilding the modular kernel I see that the crash happens before
any modules are loaded.

Thanks,
John
