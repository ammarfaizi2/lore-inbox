Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbTLRSYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbTLRSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:24:25 -0500
Received: from [208.33.57.99] ([208.33.57.99]:1188 "EHLO mail.ibiquity.com")
	by vger.kernel.org with ESMTP id S265267AbTLRSYW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:24:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: non-SMP kernels fail to compile
Date: Thu, 18 Dec 2003 13:24:21 -0500
Message-ID: <E3C9701D2F6B57468EBB36C053176EEF0172198F@mail.ibiquity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: non-SMP kernels fail to compile
Thread-Index: AcPFlCe35Dt91VK7RO+7QmYD3kJP8g==
From: "Chandler, Neville" <chandler@ibiquity.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
I'm having problems compiling Non-SMP versions of the linux kernel. 
linux-2.4.23 and linux-2.4.24-pre1 fail to compile with SMP disabled.
However, they do compile cleanly when SMP is enabled. Any help would be
appreciated.

Thanks.

System: Redhat 9
GCC:    3.3.2


chandler@ibiquity.com
