Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbQKKRFt>; Sat, 11 Nov 2000 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbQKKRFk>; Sat, 11 Nov 2000 12:05:40 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:15633 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131401AbQKKRFa>;
	Sat, 11 Nov 2000 12:05:30 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011111705.UAA04570@ms2.inr.ac.ru>
Subject: Re: [BUG REPORT] TCP/IP weirdness in 2.2.15
To: tpolling@rhone.CH (Thomas Pollinger)
Date: Sat, 11 Nov 2000 20:05:10 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com (Dave Miller)
In-Reply-To: <5.0.0.25.0.20001106111445.034a8660@stargate> from "Thomas Pollinger" at Nov 6, 0 10:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

172.30.0.3 is HPUX?

Upgrade it, you were so unlucky to purchase some invalid OS release.
Each TCP connection to it from any sane OS will freeze miximum after
656 seconds.

I think this bug has been fixed.

[ Dave: one puzzle less, this bogon wraps his own timestamps at 16 bits. 8) ]

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
