Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKMD0C>; Sun, 12 Nov 2000 22:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKMDZw>; Sun, 12 Nov 2000 22:25:52 -0500
Received: from smtp-2u-1.atlantic.net ([209.208.25.2]:9735 "EHLO
	smtp-2u-1.atlantic.net") by vger.kernel.org with ESMTP
	id <S129121AbQKMDZj>; Sun, 12 Nov 2000 22:25:39 -0500
Date: Sun, 12 Nov 2000 23:27:55 -0500 (EST)
From: Burton Windle <burton@fint.org>
To: linux-kernel@vger.kernel.org
Subject: Broadcast Pings
Message-ID: <Pine.LNX.4.21.0011122324070.21174-100000@fint.staticky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sent to L-K at DaveM's suggestion]

Shouldn't Linux default to not respond to broadcasts pings? Perhaps I've
set them up wrong, but all of my Linux boxes reply to pings sent to the
broadcast address (RH's 2.2.16-3, 2.2.18pre18, and 2.4.0-test11-pre3).  
Just for safety/non-smurfism, shouldn't they default to not reply ( I
[think] they can be tuned to do so) ? Sorry if this is a config issue that
I overlooked...

-- 
Burton Windle				burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux/init/main.c:1384

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
