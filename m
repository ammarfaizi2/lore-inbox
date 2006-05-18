Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWEROBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWEROBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWEROBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 10:01:15 -0400
Received: from mail.visionpro.com ([63.91.95.13]:6037 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932079AbWEROBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 10:01:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Invalid module format?
Date: Thu, 18 May 2006 07:01:13 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B321D@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Invalid module format?
Thread-Index: AcZ6g4W7XJmJbmb5Q46RoGd5CEiErQ==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two device drivers for two separate PCI cards.

Using the 2.6.15.6 I can compile and insert both of these drivers.

I copy my sources to my 2.6.16.16 tree and recompile them.  One driver
inserts just fine (and works) and the other gives me this:

FATAL: Error inserting ibb
(/lib/modules/2.6.16.16/kernel/drivers/mvp/ibb.ko): Invalid module
format

The same source file between both kernels and I get no errors at compile
time.

This is a Fedora Core 3 system running on a Dell PE1800.

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

