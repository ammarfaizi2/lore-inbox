Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRANHzt>; Sun, 14 Jan 2001 02:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbRANHzj>; Sun, 14 Jan 2001 02:55:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:530 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129773AbRANHz0>; Sun, 14 Jan 2001 02:55:26 -0500
Date: Sun, 14 Jan 2001 01:31:03 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: eth1: Transmit timed out, status 0000, PHY status 0000
Message-ID: <Pine.LNX.4.31.0101130334190.716-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What might be a reason I'm seeing this?

Becker's latest via-rhine driver ontop 2.2.18..

...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...
eth1: Transmit timed out, status 0000, PHY status 0000,
resetting...

Keeps going nonstop until I ifdown eth1.

Card worked fine 2 days ago...


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------


Windows 95(n) - 32-bit extensions and graphical shell for a 16-bit patch
to an 8-bit operating system originally coded for a 4-bit microprocessor,
written by a 2-bit company that can't stand 1 bit of competition. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
