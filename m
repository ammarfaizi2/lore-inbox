Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLRFfM>; Mon, 18 Dec 2000 00:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQLRFfB>; Mon, 18 Dec 2000 00:35:01 -0500
Received: from bootp-83.newpem.brown.edu ([128.148.214.83]:44036 "HELO
	delta.brown.edu") by vger.kernel.org with SMTP id <S129428AbQLRFev>;
	Mon, 18 Dec 2000 00:34:51 -0500
Message-ID: <3A3D9AE2.8721062F@brown.edu>
Date: Mon, 18 Dec 2000 00:04:34 -0500
From: David Feuer <David_Feuer@brown.edu>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APM/DPMS lockup on Dell 3800
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this problem both in Linux and Windows, so I won't
rule out hardware/bios bugs, but I find that often when my
monitor (backlight) gets turned off automatically after a
long period of non-use, the computer freezes up.  I think it
only happens when I've left it that way for a long time,
though.  If I move the mouse immediately after the screen is
blacked, I have no trouble, but if I leave it for a long
time, when I get back the monitor won't unblack,
ctrl-alt-backspace does nothing, ctrl-alt-delete does
nothing,  Fn-Suspend, Fn-A don't do anything, and the
capslock and numlock keys don't do anything either.  I
haven't tried reaching the machine from outside yet, but I
will if someone wants.  Possibly useful note: when the
computer is in this state and I remove the (PCMCIA) network
card and re-insert it, it does not get reset.  This could
indicate a complete lockup.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
