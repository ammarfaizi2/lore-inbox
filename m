Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133049AbRAYS3l>; Thu, 25 Jan 2001 13:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130927AbRAYS3b>; Thu, 25 Jan 2001 13:29:31 -0500
Received: from [38.204.212.32] ([38.204.212.32]:50048 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S133049AbRAYS3Y>;
	Thu, 25 Jan 2001 13:29:24 -0500
Date: Thu, 25 Jan 2001 13:29:24 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
To: linux-kernel@vger.kernel.org
Subject: hotmail can't deal with ECN
Message-ID: <Pine.LNX.4.21.0101251328240.2961-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After mentioning ECN, this is the response I received from hotmail.

-jeremy

---

From: MSN Hotmail Support <support_x@hotmail.com>
To: jeremy@xxedgexx.com
Subject: RE: CST23725481ID - Ban on Ecropolis

Jeremy,

Some of the routers and load balencers that we use will drop any packet
that contains any bits in the reserved section of TCP headers.  There are
firmware updates being planned by our vendor, but they are not available
yet.  Also, we have to wait until they are fully stable before we can use
them on our site.  We can't have our routers and load balancers falling
over constantly under stress because of bugs in the firmware.  When we
can, we will update, until then, there is nothing that we can do about
this.

We apologize for any inconvenience.

David
MSN Hotmail Customer Support







--
this is my sig.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
