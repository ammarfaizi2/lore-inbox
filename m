Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUIXAyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUIXAyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUIXAxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:53:39 -0400
Received: from constellation.doubledimension.com ([63.90.75.35]:46228 "EHLO
	constellation.doubledimension.com") by vger.kernel.org with ESMTP
	id S267602AbUIXAiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:38:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: PCI Burst
Date: Thu, 23 Sep 2004 17:34:21 -0700
Message-ID: <E6456D527ABC5B4DBD1119A9FB461E3501935A@constellation.doubledimension.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Burst
Thread-Index: AcShzjv3JBTT/730SK2B2iDRuCPzoQ==
From: "Brian McGrew" <Brian@doubledimension.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running RedHat 7.3 with the 2.4.20 kernel.

How do I enable PCI burst mode for reading and writing on the PCI bus?  We mmap 128MB per board that we install and now that we've added our addressing to the /proc/mtrr file, we can burst on write but we're not seeing any burst on the read.  

Any ideas?

-brian

Brian D. McGrew {brian@doubledimension.com || pacemakertaker@rock.com }
---
> Failure is not an option; it is included with every Microsoft product.

