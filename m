Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUIYBIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUIYBIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269165AbUIYBIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:08:36 -0400
Received: from mail.dolby.com ([204.156.147.8]:17671 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S269164AbUIYBIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:08:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: Kernel hang with 2.6.9-mm3-S6
Date: Fri, 24 Sep 2004 18:07:57 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA05EC7134@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel hang with 2.6.9-mm3-S6
Thread-Index: AcSinBlMNREHBpLJQX2zzVtjTAtIVQ==
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This probably needs to be reported to IM or AM.
I'm building a KGDB instrumented low latency Linux kernel,  the target
machine is a Dell Inspiron 8100. If it boots to login, and the lid is
closed, it's hung hard. (Ctrl C from KGDB client does nothing, no curser
flashing, no keyboard input (not even beeping after holding keys down).
It doesn't hang at initial kdgbwait, or under 2.6.8.1.
Let me know if there's anything I can do to help fix this (I'm not a
kernel programmer).
Thanks.

John Gilbert
jgg@dolby.com 

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

