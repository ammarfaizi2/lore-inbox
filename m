Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQKVVRu>; Wed, 22 Nov 2000 16:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129470AbQKVVRb>; Wed, 22 Nov 2000 16:17:31 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:61294 "EHLO sgi.com")
        by vger.kernel.org with ESMTP id <S129392AbQKVVRZ>;
        Wed, 22 Nov 2000 16:17:25 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: include conventions /usr/include/linux/sys ?
Date: Wed, 22 Nov 2000 12:45:52 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHOEKLCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus has mentioned a desire to move kernel internal interfaces into
a separate kernel include directory.  In creating some code, I'm wondering
what the name of this should/will be.  Does it follow that convention
would point toward a linux/sys directory?
-l

--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
