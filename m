Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWCPPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWCPPma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCPPma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:42:30 -0500
Received: from mail.visionpro.com ([63.91.95.13]:14231 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751902AbWCPPm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:42:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: remap_page_range() vs. remap_pfn_range()
Date: Thu, 16 Mar 2006 07:42:28 -0800
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0970C7D@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: remap_page_range() vs. remap_pfn_range()
Thread-Index: AcZJEDrtxKIpde6pT3yFMrmJogtkPg==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen the change in the kernel for this call so I changed my device
drive to use the new call and now every time I access the device the
machine gets really unstable and crashes after a minute or so.

When changing over the call, what else do I need to change?  All I did
was change the one call to the other.  Do I have to do anything else?

If someone can't help me, can anybody recommend a consultant that I can
hire to get this working?  I've already wasted three months on something
that is way beyond me.

TIA,

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> Those of you who think you know it all,
  really annoy those of us who do! 

