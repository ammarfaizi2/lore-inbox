Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTKWUQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 15:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTKWUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 15:16:17 -0500
Received: from fmr01.intel.com ([192.55.52.18]:53909 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263447AbTKWUQQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 15:16:16 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Date: Sun, 23 Nov 2003 15:16:11 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC886F@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Thread-Index: AcOx09mjcaAPM9UjQ1GqA7Fh44inYQAJNO4A
From: "Brown, Len" <len.brown@intel.com>
To: "Eduard Bloch" <edi@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Nov 2003 20:16:12.0530 (UTC) FILETIME=[A3DA2D20:01C3B1FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> weird 1+2xHT mode.

Re: BIOS disables CPUSs.
It would be good to verify that 2.4.21 still works properly on this box
to verify the hardware isn't hosed.  Also, if your BIOS CMOS has error
logs, it might be good to read them to see what it is thinking.

Also, does the same 3-cpu configuration result when you boot 2.6?

Thanks,
-Len
