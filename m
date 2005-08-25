Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVHYIWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVHYIWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVHYIWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:22:10 -0400
Received: from amdext3.amd.com ([139.95.251.6]:31702 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S964871AbVHYIWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:22:09 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Content-class: urn:content-classes:message
Subject: RE: Hardware Perfromance Counters
Date: Thu, 25 Aug 2005 16:21:53 +0800
MIME-Version: 1.0
Message-ID: <1784BBD8D1F15B4C9FB0F09F0A939F9001D79456@SZEXMTA4.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Thread-Topic: Hardware Perfromance Counters
Thread-Index: AcWpIKZUoCZolXcLQmOmgnI62u73kgALQs7w
From: "Xie, Bill" <bill.xie@amd.com>
To: "Sushant Sharma" <sushant@cs.unm.edu>, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 25 Aug 2005 08:21:58.0489 (UTC)
 FILETIME=[0FA43490:01C5A94E]
X-WSS-ID: 6F13A02D2E81972895-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

AMD's CodeAnalyst is the right tool for you.  It is based on Oprofile.

It can be free downloaded from AMD website.

Best Regards
Bill Xie

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sushant Sharma
Sent: Thursday, August 25, 2005 10:52 AM
To: linux-kernel@vger.kernel.org
Subject: Hardware Perfromance Counters

Hello everyone,
The system I am working on is a single processor Athlon. In the kernel I need to detect a cache miss (L1/L2) and trigger an event/function (inside the kernel). Now we have performance counters for detecting/counting cache misses. Among the various tools/patches available for accessing performance counters, which one do you guys recommend. Or do you think it would be easy to write code for this myself, as i just need this one event detection. Can you give some links where one can read about programming performance counters or some book on it.

Thanks a lot.
please cc reply to me too.

--

Sushant Sharma
http://cs.unm.edu/~sushant
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

