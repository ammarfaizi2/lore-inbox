Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTIEWnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTIEWnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:43:31 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:41960 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262497AbTIEWna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:43:30 -0400
From: "Will L G" <diskman@kc.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: AlphaPC 164SX
Date: Fri, 5 Sep 2003 17:39:10 -0500
Message-ID: <004f01c373fe$86864620$6501a8c0@zephyr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering, how come you (as in Kernel.org) don't better support the
AlphaPC 164SX? Especially considering you fully support the EB64 which is
about as rare as hens teeth. The AlphaPC 164SX is one of the more popular
models among the mainstream because it uses the alpha cpu while the same
time using PC based hardware (definite cost savings). From my point of view,
I would say your most popular 'consumer' models would be the following:

AlphaPC 164
AlphaPC 164SX
Alpha 164SX
Alpha 164LC
Alpha 300XL (gradually dieing off as we speak)

Granted the AlphaPC 164SX runs fine on the 'GENERIC' kernel but the speed
hit is outrageous. The PCA56 is one of the best all round Alpha processors
and with the EB164 EV5 kernel, you can't take full advantage of the extended
cpu instruction set which can boost the speed of optimized programs by 80%
or better.

To fully support the AlphaPC 164SX wouldn't take any real work considering
it's a stop gap between the EB164 and the LX... Sincerely Will L G



