Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAYFoI>; Thu, 25 Jan 2001 00:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRAYFn6>; Thu, 25 Jan 2001 00:43:58 -0500
Received: from [38.204.212.32] ([38.204.212.32]:8832 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S129383AbRAYFnv>;
	Thu, 25 Jan 2001 00:43:51 -0500
Date: Thu, 25 Jan 2001 00:43:46 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
To: linux-kernel@vger.kernel.org
Subject: hotmail not dealing with ECN
Message-ID: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just curious if others have noticed that hotmail is unable to deal with
ECN and wondering if this is a standard that should be encouraged, as in
should I tell hotmail that perhaps they should look into supporting it, or
should I not waste my breath and echo 0 > /proc/sys/net/ipv4/tcp_ecn?

thanks
-jeremy


--
this is my sig.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
