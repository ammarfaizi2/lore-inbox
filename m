Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUHSR0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUHSR0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHSR0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:26:18 -0400
Received: from webmail3.altiris.com ([64.90.198.11]:15136 "EHLO
	ali-ex1.altiris.com") by vger.kernel.org with ESMTP id S266836AbUHSR0P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:26:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices [ahem]
Date: Thu, 19 Aug 2004 11:26:19 -0600
Message-ID: <9B96255DE3B181429D06C6ADB0B37470232B75@sandman.altiris.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices [ahem]
Thread-Index: AcSEnHnIZCb57634Qy2KMJ2iuDfeKABdNHiw
From: "John Riggs" <jriggs@altiris.com>
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, "Jonathan Sambrook" <beardie@dsvr.net>
X-OriginalArrivalTime: 19 Aug 2004 17:26:18.0539 (UTC) FILETIME=[A34B17B0:01C48611]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Not sure if Jonathan's problem is the same that I am having. But
I seem to have fixed my problem by compiling ACPI support into the
kernel. I still don't know why it was crashing, but I don't really know
how to go about figuring it out either. So since the crash doesn't
appear anymore I will likely not pursue this any longer.

John
