Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbUJZKQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUJZKQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUJZKQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 06:16:33 -0400
Received: from fmr05.intel.com ([134.134.136.6]:54917 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262203AbUJZKQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 06:16:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [swsusp] print error message when swapping is disabled
Date: Tue, 26 Oct 2004 18:16:19 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057563D61B@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [swsusp] print error message when swapping is disabled
Thread-Index: AcS6fcVNxqp5maayRwuUXimdvgiMhAAxtzWQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Zhu, Yi" <yi.zhu@intel.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Oct 2004 10:16:22.0544 (UTC) FILETIME=[D7C5A100:01C4BB44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi!
>
>> swsusp exits silently when swapping is disabled. This patch gives
some
>> clues to
>> the user in this case. Please apply.
>
>Did you mean "swapon -a"? Otherwise approved, please send it to akpm
>directly.
Another case is PSE disabled. Should notify this to user also. 

Thanks,
Shaohua
