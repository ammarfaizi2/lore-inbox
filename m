Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266444AbSKZRzD>; Tue, 26 Nov 2002 12:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbSKZRzC>; Tue, 26 Nov 2002 12:55:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2432 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S266444AbSKZRzB>;
	Tue, 26 Nov 2002 12:55:01 -0500
Date: Sat, 23 Nov 2002 14:22:55 -0500 (EST)
From: tmrbill@tmr.com
X-X-Sender: root@bilbo.tmr.com
Reply-To: tmrbill@tmr.com
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.47-ac6 PCMCIA network modules
Message-ID: <Pine.LNX.4.44.0211231420040.17379-200000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810548-2076019933-1038079375=:17379"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810548-2076019933-1038079375=:17379
Content-Type: TEXT/PLAIN; charset=US-ASCII

Just FYI, I try built-in or dig up the export.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


---1463810548-2076019933-1038079375=:17379
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="x.tmp"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0211231422550.17379@bilbo.tmr.com>
Content-Description: depmod fail
Content-Disposition: attachment; filename="x.tmp"

bWFrZVsyXTogd2FybmluZzogLWpOIGZvcmNlZCBpbiBzdWJtYWtlOiBkaXNh
Ymxpbmcgam9ic2VydmVyIG1vZGUuDQptYWtlWzJdOiB3YXJuaW5nOiAtak4g
Zm9yY2VkIGluIHN1Ym1ha2U6IGRpc2FibGluZyBqb2JzZXJ2ZXIgbW9kZS4N
CiAgbWtkaXIgLXAgL2xpYi9tb2R1bGVzLzIuNS40Ny1hYzYva2VybmVsL2xp
Yi96bGliX2RlZmxhdGU7IGNwIGxpYi96bGliX2RlZmxhdGUvemxpYl9kZWZs
YXRlLm8gL2xpYi9tb2R1bGVzLzIuNS40Ny1hYzYva2VybmVsL2xpYi96bGli
X2RlZmxhdGUNCm1ha2UgLWozIC1mIHNjcmlwdHMvTWFrZWZpbGUubW9kaW5z
dCBvYmo9YXJjaC9pMzg2L2xpYg0KaWYgWyAtciBTeXN0ZW0ubWFwIF07IHRo
ZW4gL3NiaW4vZGVwbW9kIC1hZSAtRiBTeXN0ZW0ubWFwICAyLjUuNDctYWM2
OyBmaQ0KZGVwbW9kOiAqKiogVW5yZXNvbHZlZCBzeW1ib2xzIGluIC9saWIv
bW9kdWxlcy8yLjUuNDctYWM2L2tlcm5lbC9kcml2ZXJzL25ldC84MzkwLm8N
CmRlcG1vZDogCWNyYzMyX2JlDQpkZXBtb2Q6ICoqKiBVbnJlc29sdmVkIHN5
bWJvbHMgaW4gL2xpYi9tb2R1bGVzLzIuNS40Ny1hYzYva2VybmVsL2RyaXZl
cnMvbmV0L3BjbWNpYS8zYzU3NF9jcy5vDQpkZXBtb2Q6IAljbGkNCmRlcG1v
ZDogCXJlc3RvcmVfZmxhZ3MNCmRlcG1vZDogCXNhdmVfZmxhZ3MNCmRlcG1v
ZDogKioqIFVucmVzb2x2ZWQgc3ltYm9scyBpbiAvbGliL21vZHVsZXMvMi41
LjQ3LWFjNi9rZXJuZWwvZHJpdmVycy9uZXQvdHVsaXAvZGUyMTA0eC5vDQpk
ZXBtb2Q6IAljcmMzMl9sZQ0KbWFrZTogKioqIFtfbW9kaW5zdF9wb3N0XSBF
cnJvciAxDQoNCnJlYWwJMG0yLjY1M3MNCnVzZXIJMG0yLjYwMnMNCnN5cwkw
bTEuNTE0cw0KKysgYnJlYWsNCisrIHNsZWVwIDENCg==
---1463810548-2076019933-1038079375=:17379--
