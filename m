Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLPKeu>; Sat, 16 Dec 2000 05:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLPKej>; Sat, 16 Dec 2000 05:34:39 -0500
Received: from SPYLOG-TCNET.tcnet.ru ([195.230.65.66]:25349 "HELO gate.local")
	by vger.kernel.org with SMTP id <S129408AbQLPKe2>;
	Sat, 16 Dec 2000 05:34:28 -0500
From: "Max Shaposhnikov" <shapa@spylog.ru>
To: <linux-kernel@vger.kernel.org>
Subject: raid5 broken in latest 2.4
Date: Fri, 15 Dec 2000 18:24:19 +0300
Message-ID: <AOEJJKJLFPBGFHPGKHAFCEJACBAA.shapa@spylog.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raid5 bug in 2.4test12pre13

mk2efs froze (at approx. 50% persents)
on big partition (15G)
mkreiserfs - got the same error too. it seems raid5 in latest 2.4 is broken.

2.4test10 - all is fine.

ext2 tools - latest version (1.20)
SuSE 7.0
SMP pIII-800
1G of RAM

bur repeats on 3 servers.


Max Shaposhnikov,
SpyLog UNIX administrator (www.spylog.ru)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
