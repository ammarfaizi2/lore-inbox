Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBABwX>; Wed, 31 Jan 2001 20:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRBABwD>; Wed, 31 Jan 2001 20:52:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20373 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129379AbRBABwC>;
	Wed, 31 Jan 2001 20:52:02 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14968.49398.707318.632696@pizda.ninka.net>
Date: Wed, 31 Jan 2001 17:50:46 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: any razer boomslang users with 2.4.1?
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ask because I note that mine isn't working with the USB-->PS/2
adapter and the PSMOUSE driver in 2.4.x, but 2.2.x works fine.

Basically, the mouse gives random events to the kernel when
moved.  At the very least, they do not match up with where I actually
move the mouse.

This is on an Athlon-950 system.  If anyone else sees this or
can try it out themselves, please let me and the list know.

There is a workaround, after bootup, pull the mouse out then plug it
back in.  Wheee... this seems to work until I figure out what really
is causing the problems.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
