Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130142AbQLUQZP>; Thu, 21 Dec 2000 11:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQLUQZF>; Thu, 21 Dec 2000 11:25:05 -0500
Received: from [207.144.235.141] ([207.144.235.141]:27777 "EHLO gilgamesh.uruk")
	by vger.kernel.org with ESMTP id <S130142AbQLUQYz>;
	Thu, 21 Dec 2000 11:24:55 -0500
Date: Thu, 21 Dec 2000 10:54:22 -0500 (EST)
From: Jim Bray <jb@as220.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-12: Hard Hang related to Serial Mouse
Message-ID: <Pine.LNX.4.21.0012211052520.18259-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm not on this list, so please respond directly to me for more info.

 I was running 2.4.0-12 (back to -10 now), K6-2 chip. With -12, the system
would hard-hang quite frequently. Complete lockup: no response to alt-sysrq,
so no info available. Eventually I figured out that this was only happening
when I was moving the mouse.

  I'm also running xfree-4, which may be related, but that shouldn't be able
to lock the system up completely.

Jim		http://as220.org/jb
Public Key:     http://as220.org/jb/key

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
