Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLJGe4>; Sun, 10 Dec 2000 01:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQLJGeq>; Sun, 10 Dec 2000 01:34:46 -0500
Received: from pm3-3-35.apex.net ([209.250.40.195]:38411 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129563AbQLJGec>; Sun, 10 Dec 2000 01:34:32 -0500
Date: Sun, 10 Dec 2000 00:04:32 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Freeze and reboot with 2.4.0-test12-pre5
Message-ID: <20001210000432.A7770@hapablap.dyn.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several times now, at seemingly random intervals, my computer has frozen
solid.  The computer was not under high load--XMMS playing and my typing
an email in mutt.  X was frozen, the soundcard played the same sound
repeatedly, and ctrl+alt+del did nothing.  SysRq, however, caused the
computer to reboot.  Not just SysRq+b, but also SysRq+s.  This has
happened at least 3 times.  The system is a AMD-K6/2 500MHz Model 8,
Steeping 12, kernel 2.4.0-test12-pre5+reiserfs, running XFree86 4.0.1

No other useful debug information could be obtained.
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
