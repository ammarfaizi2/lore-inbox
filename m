Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLRGpa>; Mon, 18 Dec 2000 01:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLRGpV>; Mon, 18 Dec 2000 01:45:21 -0500
Received: from mdj.nada.kth.se ([130.237.224.206]:13833 "EHLO mdj.nada.kth.se")
	by vger.kernel.org with ESMTP id <S129421AbQLRGpM>;
	Mon, 18 Dec 2000 01:45:12 -0500
To: David Feuer <David_Feuer@brown.edu>
Cc: linux-kernel@vger.kernel.org, djurfeldt@nada.kth.se
Subject: Re: APM/DPMS lockup on Dell 3800
In-Reply-To: <3A3D9AE2.8721062F@brown.edu>
Reply-To: djurfeldt@nada.kth.se
From: Mikael Djurfeldt <mdj@mdj.nada.kth.se>
Date: 18 Dec 2000 07:14:38 +0100
In-Reply-To: David Feuer's message of "Mon, 18 Dec 2000 00:04:34 -0500"
Message-ID: <xy7wvcyxnld.fsf@mdj.nada.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Feuer <David_Feuer@brown.edu> writes:

> I get this problem both in Linux and Windows, so I won't
> rule out hardware/bios bugs, but I find that often when my
> monitor (backlight) gets turned off automatically after a
> long period of non-use, the computer freezes up.  I think it
> only happens when I've left it that way for a long time,
> though.  If I move the mouse immediately after the screen is
> blacked, I have no trouble, but if I leave it for a long
> time, when I get back the monitor won't unblack,
> ctrl-alt-backspace does nothing, ctrl-alt-delete does
> nothing,  Fn-Suspend, Fn-A don't do anything, and the
> capslock and numlock keys don't do anything either.  I
> haven't tried reaching the machine from outside yet, but I
> will if someone wants.

I have a Dell Inspiron 7000 with BIOS A15 and exactly the same
problem.

(I last observed this problem using linux-2.4.0-test12, though.
Now I'm running test13-pre3 and it has not yet occurred.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
