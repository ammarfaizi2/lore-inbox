Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbRAOEAb>; Sun, 14 Jan 2001 23:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRAOEAV>; Sun, 14 Jan 2001 23:00:21 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:16682 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S131114AbRAOEAI>; Sun, 14 Jan 2001 23:00:08 -0500
Date: Sun, 14 Jan 2001 21:59:53 -0600
From: Matthew Fredrickson <matt@frednet.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PS/2 Mouse && Asus A7V Mobo && X 4.0.x (and 3.3.x)
Message-ID: <20010114215953.A16661@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specs:
AMD T-bird 1ghz
Asus A7Vpro motherboard
160M of mem
Kensington Mouseworks mouse(or any other ps2 mouse I hook up for that matter) 

I think those are all the relevant specs.  My problem is in that when I
try to use my mouse in X, after a brief period of time my mouse pointer
activity goes a little crazy.  It almosts start acting like a mouse does
when you used to switch it to 3 button mode in windows.  It seems to occur
mostly when the mouse button is held down (click and drag operations).
The only reason I'm mailing the kernel list about it is that when I
upgraded from kernel 2.2.18pre21 which caused the mouse pointer to
eventually completely freeze, to 2.4.0 stock it doesn't lock up completely
anymore, just is a little bit sporadic.  Any ideas what might be causing
this?  My ignorance is about to show through, but could it be some kind of
bug in the VIA ps/2 mouse code? (ugh).  I wasn't quite sure to what
extent I should go into detail about what is happening, so if more info is
needed, I can give more.  btw, gpm works just fine with no problems, just
X has problems.  Thanks.

-- 
Matthew Fredrickson AIM MatthewFredricks
ICQ 13923212 matt@NOSPAMfredricknet.net 
http://www.fredricknet.net/~matt/
"Everything is relative"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
