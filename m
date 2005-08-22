Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVHVV4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVHVV4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVHVV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:56:49 -0400
Received: from mail.visionpro.com ([63.91.95.13]:56089 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751267AbVHVV4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:56:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Binding a thread (or specific process) to a designated CPU
Date: Mon, 22 Aug 2005 14:56:47 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Binding a thread (or specific process) to a designated CPU
Thread-Index: AcWnZGQjUxZ2tAtDTGqgbtoJ/s5O+g==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

Using FC3 or FC4 with the 2.6.9 or later kernel, we're looking for a way
to bind a thread (or an entire process) to a designated CPU.  We're
using dual processor systems as well as P4 with HT and Xeons so all of
our boxes either have two CPU's or 'appear' to have two.

I want to be able, in my C++ code to designate a specific thread to a
specific processor.  I've heard rumors that with the 2.6 kernel this is
now possible???

Thanks,

-brian
 
Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
---
> Those of you who think you know it all,
  really annoy those of us who do!

