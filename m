Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWDZOQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWDZOQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDZOQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:16:41 -0400
Received: from mail.advantech.ca ([207.35.60.239]:25849 "EHLO
	exch2k.Advantech.ca") by vger.kernel.org with ESMTP id S964782AbWDZOQl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:16:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: how to use the new wait functions in wait.c?
Date: Wed, 26 Apr 2006 10:16:40 -0400
Message-ID: <1A60C93388AFD3419AEE0E20A116D3201CFDAA@exch2k>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to use the new wait functions in wait.c?
Thread-Index: AcZpOEVwsmMBA7fmTgy+i/8EAsEaIQAAisoQ
From: "Michael Guo" <Michael.Guo@advantechAMT.com>
To: "Xin Zhao" <uszhaoxin@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can refer the following books:
 Love Robert -- Linux Kernel Development (2.6.x kernel)
 Bovet,Daniel and Marco Cesate -- Understanding the Linux Kernel,Third Edition 
 Jonathan Corbet, Alessandro Rubini and Greg Kroah-Hartman -- Linux device drivers Third Edition.

I hope those books could give a mountain view about Linux kernel.

Guo



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Xin Zhao
Sent: Wednesday, April 26, 2006 9:48 AM
To: linux-kernel
Subject: how to use the new wait functions in wait.c?


Looks like linux kernel switched to new wait function sets in wait.c.
But I cannot find any document about the new APIs. Can someone kindly
let me know where I can find them or let me know how to use them?
Thanks a lot!

xin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
