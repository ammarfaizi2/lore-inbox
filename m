Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbQLKU0v>; Mon, 11 Dec 2000 15:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbQLKU0l>; Mon, 11 Dec 2000 15:26:41 -0500
Received: from zaphod.kpnqwest.ch ([146.228.10.43]:28422 "EHLO
	zaphod.kpnqwest.ch") by vger.kernel.org with ESMTP
	id <S130307AbQLKU0e>; Mon, 11 Dec 2000 15:26:34 -0500
Message-ID: <3A353F65.C471A24@dial.eunet.ch>
Date: Mon, 11 Dec 2000 20:56:05 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 vanilla on SMP, latency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same latencies as 2.2.16 and 2.2.17 vanilla,
over 75 seconds to wait on an other screen!
And top(1) on a serial VT510 freezes.

Machine loaded with 2 setiathome and
Doug Ledford's memtest.

ASUS P2B-DS Dual PIII550 1024MB memory,
only SCSI devices (no IDE!).

Andrea Arcangeli's ..17pre6aa2, ..18pre17aa1
and ..18pre21aa2 reduced the latency <2 secs.

Regards
Mario Vanoni

PS If necessary, cc, not in lkml!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
