Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLREHp>; Sun, 17 Dec 2000 23:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLREHZ>; Sun, 17 Dec 2000 23:07:25 -0500
Received: from proxy2.ba.best.com ([206.184.139.14]:40201 "EHLO
	proxy2.ba.best.com") by vger.kernel.org with ESMTP
	id <S129210AbQLREHR>; Sun, 17 Dec 2000 23:07:17 -0500
Message-ID: <3A3D85FC.FF1708C4@best.com>
Date: Sun, 17 Dec 2000 19:35:24 -0800
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Redundant Contours
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test12 final, test13-pre3 freezing system
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find that running these kernels (because of a netfilter modules
compile error, didn't try test13-pre1 or 2) in X my entire system
freezes, requiring a hard reboot.  With test12 final, suddenly
the screen streaked, then froze.

No oops, just the freeze.

Been a while (when I used to run Windoze) since I saw a frozen
screen complete with frozen mouse hour-glass. :)

FWIW. Bob L.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
