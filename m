Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTAFREx>; Mon, 6 Jan 2003 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTAFREw>; Mon, 6 Jan 2003 12:04:52 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:3279 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S267042AbTAFREv>; Mon, 6 Jan 2003 12:04:51 -0500
From: Richard Stallman <rms@gnu.org>
To: acahalan@cs.uml.edu
CC: linux-kernel@vger.kernel.org
In-reply-to: <200301050802.h0582u4214558@saturn.cs.uml.edu>
	(acahalan@cs.uml.edu)
Subject: Re: Nvidia and its choice to read the GPL "differently"
Reply-to: rms@gnu.org
References: <200301050802.h0582u4214558@saturn.cs.uml.edu>
Message-Id: <E18Vaoa-0002Pm-00@fencepost.gnu.org>
Date: Mon, 06 Jan 2003 12:13:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    By "GNU" you mean the Hurd?

GNU means the entire system that we set out from the beginning to
develop.  The Hurd is just one piece of GNU--it is the upper layer of
the kernel.

				That's not nice at all. Just where
    did you get your network stack from? How about the bulk of the
    hardware drivers?

The TCP/IP implementation in the Hurd comes from Linux, but the Hurd
as a whole is very different from Linux.  (There are no drivers in the
Hurd.)

Linux is a small part of the GNU/Linux system, but there are
various reasons to call it "GNU/Linux" than just "GNU".  See
http://www.gnu.org/gnu/gnu-linux-faq.html#justgnu.

    So Freax is our kernel, and Linux is the OS.

Anyone for renaming this list to freax@vger.kernel.org?


