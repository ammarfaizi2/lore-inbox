Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVly>; Fri, 24 Nov 2000 16:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130218AbQKXVlo>; Fri, 24 Nov 2000 16:41:44 -0500
Received: from [209.143.110.29] ([209.143.110.29]:41739 "HELO
        mail.the-rileys.net") by vger.kernel.org with SMTP
        id <S129518AbQKXVlb>; Fri, 24 Nov 2000 16:41:31 -0500
Message-ID: <3A1ED97B.EC4C8A8C@the-rileys.net>
Date: Fri, 24 Nov 2000 16:11:23 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.6-15apmac ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] asm-ppc/elf.h error (fixed patch)
Content-Type: multipart/mixed;
 boundary="------------6532F9A4F519B1419F9DE670"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6532F9A4F519B1419F9DE670
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Oops, 
I included the wrong diff.  Perhaps I should check them better next
time.  Here's one that should work.
--------------6532F9A4F519B1419F9DE670
Content-Type: application/octet-stream;
 name="elf.h.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="elf.h.diff"

LS0tIC91c3Ivc3JjL2xpbnV4L2luY2x1ZGUvYXNtLXBwYy9lbGYuaAlGcmkgTm92IDI0IDE1
OjQyOjQ0IDIwMDAKKysrIC91c3Ivc3JjL2xpbnV4L2luY2x1ZGUvYXNtLXBwYy9lbGYuaAlG
cmkgTm92IDI0IDE2OjAzOjAyIDIwMDAKQEAgLTQsNiArNCw3IEBACiAvKgogICogRUxGIHJl
Z2lzdGVyIGRlZmluaXRpb25zLi4KICAqLworI2luY2x1ZGUgPGFzbS90eXBlcy5oPgogI2lu
Y2x1ZGUgPGFzbS9wdHJhY2UuaD4KIAogI2RlZmluZSBFTEZfTkdSRUcJNDgJLyogaW5jbHVk
ZXMgbmlwLCBtc3IsIGxyLCBldGMuICovCg==
--------------6532F9A4F519B1419F9DE670--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
