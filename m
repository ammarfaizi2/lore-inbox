Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLECgh>; Mon, 4 Dec 2000 21:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLECgS>; Mon, 4 Dec 2000 21:36:18 -0500
Received: from hera.cwi.nl ([192.16.191.1]:59332 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129547AbQLECgN>;
	Mon, 4 Dec 2000 21:36:13 -0500
Date: Tue, 5 Dec 2000 03:05:45 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012050205.DAA155918.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] util-linux-2.10r released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there was some discussion about umount,
I released a version of mount/umount that perhaps
has a slightly better behaviour. Since the change
was largish (and is untested), don't put it blindly
into your distribution.
Another change was one intended to make things behave
a bit better for Japanese (with variable width characters).
Since I changed the patch a bit, it is quite possible
I broke things both for Japanese and English.

Andries - aeb@cwi.nl

ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
