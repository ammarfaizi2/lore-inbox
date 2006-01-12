Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWALTl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWALTl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWALTlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:41:55 -0500
Received: from mail.visionpro.com ([63.91.95.13]:29400 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1161221AbWALTlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:41:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Capturing All Kernel Messages
Date: Thu, 12 Jan 2006 11:41:56 -0800
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0970971@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Capturing All Kernel Messages
Thread-Index: AcYXsD3D8KikHHTPRLe56X2A73BfVA==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm trying to build a new special kernel and of course, as Murphy
says, it'll blow up the first 1,000 times!  I need to capture the boot
messages because I'm getting a lot of errors scrolling by before the
kernel panics and I'm toast and have to revert back to my old kernel.
Once I revert back to my old kernel, all my previous messages are lost
and dmesg does me no good! 

How can I make the kernel output to a file or some other means as soon
as it starts loading so I can capture this stuff?

TIA,

-brian

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> Those of you who think you know it all,
  really annoy those of us who do! 

