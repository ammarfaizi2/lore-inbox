Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbQL1Bfi>; Wed, 27 Dec 2000 20:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbQL1Bf1>; Wed, 27 Dec 2000 20:35:27 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:48269 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132241AbQL1BfS>; Wed, 27 Dec 2000 20:35:18 -0500
Date: Wed, 27 Dec 2000 20:05:25 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.2.18 dies on my 486..
Message-ID: <Pine.LNX.4.31.0012220359540.666-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded my 486 firewall's kernel to pure 2.2.18 from
2.2.17, with no other changes, and now it dies with all sorts
of hard disk failures.

I get:

hdb: lost interrupt

And stuff about DRQ lost...

Totally frozen box after that.



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------


If you're interested in computer security, and want to stay on top of the
latest security exploits, and other information, visit:

http://www.securityfocus.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
