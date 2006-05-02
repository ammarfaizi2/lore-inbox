Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWEBSFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWEBSFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEBSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:05:42 -0400
Received: from mail.visionpro.com ([63.91.95.13]:10928 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S964954AbWEBSFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:05:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Too many levels of symbolic links
Date: Tue, 2 May 2006 11:05:41 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Too many levels of symbolic links
Thread-Index: AcZuEwblQtiOng38Qzy2i5ZQ4ePzxw==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the way our internal filesystem is setup, I'm seeing this
error more and more.

At one time, back in the early 2.4 days, I'd made a change to the kernel
to all more links but I can't seem to find it again in 2.6.  Does anyone
know off hand where this constant is defined???

Thanks,

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

